---
name: testing-notes
description: Write testing notes for a PR and add them to the Trello card's Testing checklist. Takes an optional PR number or URL argument; defaults to the current branch's PR.
argument-hint: "[PR number or URL]"
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
  - mcp__trello__get_card
  - mcp__trello__get_checklist_by_name
  - mcp__trello__add_checklist_item
---

# Testing Notes

Generate testing notes for a PR and post them to the linked Trello card's "Testing" checklist.

## Step 1: Identify the PR

- If an argument was provided, use it as the PR number or URL.
- If no argument was provided, detect the PR from the current branch:
  ```bash
  gh pr view --json number,title,url,comments
  ```
- If there's no PR for the current branch, tell the user and stop.

## Step 2: Understand the changes

1. Get the base branch and diff:
   ```bash
   gh pr view <number> --json baseRefName --jq '.baseRefName'
   git diff <base>..HEAD --stat
   git log <base>..HEAD --oneline
   ```
2. Read the key changed files to understand what the PR does. Focus on added/modified files, not deletions.
3. Only consider changes introduced by this branch. Do not write testing notes for upstream changes that were merged in from the base branch.

## Step 3: Draft testing notes

Write a flat bulleted list of manual testing instructions. Rules:

- Each bullet is a concise instruction a tester can follow (max 80 characters).
- Maximum 8 bullet points. Fewer is better if it covers the key flows.
- Cover the distinct user-facing flows introduced or changed by the PR, on the happy path.
- Add an edge case only when the change could plausibly break it. Don't list boundary or error cases for completeness; the specs cover those.
- Do not include notes for code that was only deleted/removed.
- Do not include notes for purely internal refactors with no user-facing change.

## Step 4: Get approval

Present the draft testing notes to the user and ask if they look good, or if any should be added, removed, or changed. Wait for confirmation before proceeding.

## Step 5: Find the Trello card

1. Get the PR comments to find the Trello card link:
   ```bash
   gh pr view <number> --json comments --jq '.comments[].body'
   ```
2. Extract the Trello card short ID from the URL (the part after `/c/`, e.g. `c0sAPVVf`).
3. If no Trello card is linked in the PR comments, ask the user for the card URL and stop.

## Step 6: Post to Trello

1. Call `get_card` with the short ID to verify the card exists and has a "Testing" checklist.
2. If there's no "Testing" checklist, create one: `ch trello api -X POST "/cards/<short ID>/checklists" -p "name:Testing"` (run from the scribe repo).
3. For each approved testing note, call `add_checklist_item` with:
   - `cardId`: the Trello card short ID
   - `checkListName`: "Testing"
   - `text`: the testing note text (without the bullet prefix)
4. Make parallel calls where possible.

## Step 7: Report

Return the Trello card URL to the user.
