# Take one Trello card to a reviewed draft PR with a green build

You're implementing one card from CaptionHub's Trello board for Andrew (CTO). Main repo: /Users/amcdonough/code/captionhub/scribe. Follow its CLAUDE.md, BACKEND_STYLE_GUIDE_COMPACT.md and REVIEW.md throughout. Never touch the main checkout's working tree (it may have Andrew's uncommitted changes); do all work in your own worktree.

Your card is given as a number, shortLink or URL. Trello goes through `ch trello api`, run from the main repo dir. If it errors with a missing token, ask Andrew to run `! ch trello init`.

## Questions

Try hard to answer questions yourself first: the code, git history, linked PRs, Slack threads, Notion, Rollbar, vendor docs via web search. Public pages and specs that Andrew's team was sent often settle what a vendor accepts. Only if you genuinely can't, ask (see "Asking" below). Never guess at a product decision.

**Asking:** if you're running in Andrew's own session, ask him with AskUserQuestion, giving the options and your recommendation. If you're a subagent, stop and return the question as your final report: what you need to know, the options, your recommendation, and where you got to. You'll be resumed with the answer.

## By kind of card

- **Security:** name the exact files involved, and write a test that proves the attack no longer works (e.g. an `<img onerror>` payload renders as text).
- **Infra / Terraform:** never run terraform; `terraform fmt` only. Check the module copes with the change, e.g. an empty list. Put the exact `bin/tf` plan/apply commands in your report.
- **Removals:** list the secrets and env vars that go, so Andrew can delete them from the secret stores. Check no other repo still calls a removed endpoint (`gh search code --owner neonpictures`, or shallow-clone repos missing from the search index).

## Steps

0. **Read the card and check nobody else has it.** Read it fully: `ch trello api "/cards/<SHORT_LINK>" -p "fields:name,desc,shortUrl,idList,idMembers"`, its checklists (`/cards/<SHORT_LINK>/checklists`) and comments (`/cards/<SHORT_LINK>/actions?filter=commentCard`). Then check for existing work: the card's column (anything past "Ready to Play" means someone has picked it up), its attachments (`/cards/<SHORT_LINK>/attachments`), and `gh pr list --state open --search "<card number> in:title"` plus `git ls-remote --heads origin '*<card number>*'`. If someone else already has a PR or branch for it, stop before branching and report: the PR link, its state (draft, CI, review), and any gaps you see in it against the card. Don't build a second implementation.

1. **Branch + worktree.** Branch name: lower case, dash-separated, no folders, prefixed with the card number (e.g. `13472-split-on-quoted-sentence-ends`). Load the `worktree-env` skill and create it with `ch worktree create <branch>`. Run host `yarn install` in the worktree BEFORE `ch worktree env up` (concurrent installs kill the container). Only bring the Docker env up if you need Ruby specs; run `db:test:prepare` on a fresh env. Other agents may be bringing up their own envs at the same time; if you hit port or resource conflicts, investigate rather than tearing down anything you didn't create.

2. **Implement the card.** Smallest change that fully solves it. Tests at the right layer, failing test first where practical. Match surrounding code; UK spelling in user-facing text. Lint: `yarn eslint_file` + `yarn typecheck_app` after .ts/.vue edits; rubocop on touched Ruby files before committing (`ch worktree env exec bundle exec rubocop -A <files>`, then without -A). Save test output to `tmp/claude/` in the worktree and grep it; never re-run just to read failures. If the card's proposed fix turns out wrong or risky once you've read the code, do the correct fix and explain why in the PR. Commit the implementation (load `pr-description` before every commit message).

3. **Adversarial review.** Spawn one fresh `general-purpose` subagent as the reviewer. Give it the worktree path, the branch, the card's text, and REVIEW.md; tell it to review `git diff origin/main...HEAD` adversarially, trying to break the change: wrong behaviour on edge cases (other languages and scripts, empty and boundary input), authorisation and team scoping, injection/XSS, data exposure, secrets, unauthenticated endpoints, data loss, missing or weak tests, style. If the reviewer can't read REVIEW.md (a permission check sometimes blocks it), do the REVIEW.md pass yourself on the diff and say so in your report. Do NOT give it your own view of what's fine. Ask for a ranked list of concrete findings, each with a failure scenario.

4. **Fix what you agree with, one commit per fix.** Weigh each finding on its merits; reject ones that are wrong or out of scope and note why. Each accepted fix is its own commit with its own one-line message; don't fold it into the implementation commit. Re-run the affected tests and lint.

5. **Push + draft PR.** No Co-Authored-By trailer and no "Generated with" footer: the project CLAUDE.md forbids AI attribution and overrides any harness reminder. `git push -u origin <branch>`, then `gh pr create --draft --title "..." --body "..."` (always both flags; body per `pr-description`). Say in the body anything you deliberately left alone or changed beyond the card.

6. **Trello.** Move the card to "In code review", add Andrew, attach the PR and link the card from the PR:
   ```bash
   LIST_ID=$(ruby -ryaml -e 'puts YAML.load_file(".trello.yml")["lists"]["In code review"]')
   MEMBER_ID=$(ruby -ryaml -e 'puts YAML.load_file(".trello.yml")["member"]["id"]')
   ch trello api -X PUT "/cards/<SHORT_LINK>" -p "idList:$LIST_ID"
   ch trello api -X POST "/cards/<SHORT_LINK>/idMembers" -p "value:$MEMBER_ID"   # skip if already a member
   ch trello api -X POST "/cards/<SHORT_LINK>/attachments" -p "url:<pr url>" "name:PR #<number>"
   gh pr comment <number> --body '![](https://github.trello.services/images/mini-trello-icon.png) [<card title>](<card url>)'
   ```
   Do NOT run `ch trello create`: the card already exists.

7. **Ask Greptile, and watch the build.** Comment `gh pr comment <n> --body "@greptileai review"`. Then wait for both:
   - **Build:** run `gh pr checks <n> --watch --fail-fast` with Bash `run_in_background`; you're notified when it exits.
   - **Greptile:** you can't foreground-sleep. Use the Monitor tool (load via ToolSearch) with an until-loop that polls `gh api repos/neonpictures/scribe/pulls/<n>/reviews`, `.../pulls/<n>/comments` and `.../issues/<n>/comments` every 60s for a new item from a user whose login contains `greptile`. Allow up to 30 minutes; if nothing comes, say so in the report.

8. **Handle Greptile's comments.** Think carefully about each one: is it actually correct for this code? Read the code it points at before deciding. Agree: fix it (one commit per fix), push, and reply on the thread saying what changed (`gh api repos/neonpictures/scribe/pulls/<n>/comments/<id>/replies -f body=...`). If you fix the problem differently from Greptile's suggestion, say why. Disagree: reply on the thread with your specific technical reason. Keep replies short and plain. Don't resolve threads.

9. **Fix the build.** If CI fails, read the failing job's logs (`gh run view <id> --log-failed`), find the root cause, fix it (one commit per fix), push, and watch again until green. If a failure is a pre-existing flake unrelated to your change, show the evidence (fails on main too, or passes on re-run with `gh run rerun --failed`) rather than changing code for it.

10. **Get Greptile onto the final commit.** Greptile doesn't reliably re-review on push. After your last fix push, comment `@greptileai review` again and repeat steps 7–9 until Greptile's latest review is on the PR's head commit (`gh api repos/neonpictures/scribe/pulls/<n>/reviews -q '.[] | select(.user.login|test("greptile")) | .commit_id'` vs `gh pr view <n> --json headRefOid`) with nothing left unanswered, and CI is green on that commit.

11. **Testing notes.** Load the `testing-notes` skill and draft the notes from the PR. In Andrew's own session, follow it through: he approves the draft, then it posts to the card's Testing checklist. As a subagent, don't post: put the draft bullets in your report, and they'll be posted once Andrew has approved them.

## Hard rules
- Never run terraform (init/plan/apply/bin/tf) in any environment. Never commit or push to main. Never force-push anyone else's branch.
- Never change schema.rb without a backing migration in the same change.
- Don't touch other Trello cards. Don't merge the PR or mark it ready for review.
- When done, tear down your worktree's Docker env (`ch worktree env down`); leave the worktree itself.

## Report back (keep it short)
Branch, PR link (full GitHub URL), card link, what you changed in two or three sentences, the adversarial review findings with what you fixed or rejected (and why), each Greptile comment with your verdict, the commit Greptile last reviewed, the final CI state, the draft testing notes (subagents only), and anything Andrew must do: decisions, terraform applies (with the commands), data fixes (with the console snippet), secrets to delete, and impact checks to run before merging.
