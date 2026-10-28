---
name: implement-trello
description: Take one or more Trello cards end to end - worktree, implementation, adversarial review with one commit per fix, draft PR, Greptile review with every comment fixed or answered, a green build and testing notes. Takes card numbers, shortLinks or URLs; with none, takes every open card labelled "Claude". Several cards run as parallel subagents. Use when Andrew says to implement, pick up or run a specific Trello card or cards, or to work the Claude-labelled cards.
argument-hint: "[card numbers, shortLinks or URLs, or nothing for every card labelled Claude]"
---

# Implement Trello cards

Each card goes through the steps in [card-flow.md](card-flow.md): check nobody else has it, implement in a worktree, adversarial review, one commit per accepted fix, draft PR, card to "In code review", Greptile review handled comment by comment, a green build with Greptile's last review on the final commit, and testing notes on the card.

## No cards given: the Claude label

Andrew marks cards he's happy for Claude to take end to end with the **Claude** label (id `6862a291d2361b59e9381a7c`). Take every open card carrying it in Backlog, Blocked / dependent or Ready to Play:

```bash
ch trello api "/boards/{board}/cards" -p "fields:idShort,name,shortUrl,idList,idLabels" \
  | jq '[.[] | select(.idLabels | index("6862a291d2361b59e9381a7c"))]'
```

The label is the go-ahead, even for a card still in Backlog or Blocked; mention those in the report so the board can be tidied. List and label ids live in `.trello.yml`.

Cards come in as numbers (`13472`), shortLinks (`4yUn5yHF`) or URLs (`https://trello.com/c/4yUn5yHF/...`). For a URL, the shortLink is the path segment after `/c/`. A bare number has no direct lookup; find its shortLink from the board:

```bash
ch trello api "/boards/{board}/cards" -p "fields:idShort,name,shortUrl,idList" | jq '.[] | select(.idShort == <number>)'
```

## One card

Run card-flow.md yourself, in this session. Questions go to Andrew with AskUserQuestion.

## Several cards

1. Resolve every card to its shortLink and title, and show Andrew one short table (number, title, column) before starting.
2. Spawn one `general-purpose` subagent per card in the background, **at most four at a time** (each may bring up its own worktree Docker env). Start the next card as each one finishes, until the list is empty.
3. Each prompt is short: "Read /Users/amcdonough/.claude/skills/implement-trello/card-flow.md and follow it. You're a subagent, so return questions as your report.", the card number, shortLink and URL, and a few lines of card-specific steering where you have it. Good steering, from experience:
   - **Authorisation changes** (policies, Pundit scopes, `superuser_for?`): audit every caller and list which roles can do what today before changing anything, and check whether other features share the same predicate so they don't widen by accident. The card's proposed fix may be too blunt: in #10380, deleting the clause the card suggested would have broken a parent team's API key acting on child teams.
   - **Cards whose detail lives in Slack, Rollbar or Notion**: read it with those tools before coding, and stop with options if the source leaves the answer ambiguous.
   - **Cards with a proposed fix in the description**: start from failing specs for the card's own examples, plus cases showing behaviour that must stay unchanged.
   - **Two cards in the same area**: tell each which files the other owns, so they don't conflict.
4. When an agent returns a question, put it to Andrew and resume that agent with SendMessage and the answer. Don't answer product questions yourself.
5. Agents return their testing notes as a draft. Show Andrew each card's draft with its report; once he approves (with any edits), post them to the card's Testing checklist following steps 5–6 of the `testing-notes` skill.

## Check each result

Don't relay a report until you've checked it. Report only what an agent has actually reported; one that's paused on its own background work hasn't finished.

```bash
n=<pr>
gh pr view $n --json isDraft,headRefOid,statusCheckRollup -q '"draft=\(.isDraft) head=\(.headRefOid[:7]) checks=\([.statusCheckRollup[].conclusion]|group_by(.)|map("\(.[0]):\(length)")|join(","))"'
echo "footer=$(gh pr view $n --json body -q .body | grep -c 'Generated with') coauthor=$(gh pr view $n --json commits -q '[.commits[].messageBody]|join("\n")' | grep -c Co-Authored-By)"
gh pr view $n --json commits -q '.commits[].messageHeadline'
gh api repos/neonpictures/scribe/pulls/$n/reviews -q '.[] | select(.user.login|test("greptile")) | "\(.submitted_at) \(.commit_id[:7])"'
```

- **AI attribution** must be zero. Strip a footer with `gh pr edit --body-file`; a trailer needs the commit amended and a `--force-with-lease` push to that PR's own branch.
- **Commits**: the implementation plus one commit per fix.
- **Greptile on the head commit**: if its latest review is on an older commit, comment `@greptileai review` and say so in the report.
- **Card**: in "In code review" with Andrew on it and the PR attached. Confirm the column at the end with one `ch trello api "/lists/<In code review id>/cards"` call.
- **REVIEW.md pass**: if the agent says it couldn't do it, review `gh pr diff <n>` yourself against REVIEW.md and say so.

## Report back

One table: card, PR link (or whoever already has it), one line on what changed or what to watch. Then:

- **Needs you**: decisions the agents surfaced, each with their recommendation; terraform applies (with the commands); data fixes (with the console snippet); secrets to delete; impact checks to run before merging; testing notes awaiting approval.
- **Worth their own cards**: problems found outside a card's scope.
- **Done without asking**: anything beyond the flow, such as force-pushes or comments posted on someone else's PR.

All PRs stay drafts. Leave the worktrees in place until Andrew says to tear them down, then remove only the ones this run created: `ch worktree remove <names...>`, after checking none is dirty or has unpushed commits.
