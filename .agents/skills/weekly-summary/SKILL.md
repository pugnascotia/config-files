---
name: weekly-summary
description: >-
  Generates a weekly summary of the user's work (last seven days including
  today). Use when the user asks for a weekly summary, week in review, what
  they did this week, or to run the weekly-summary workflow.
---

# Weekly summary

**NOTE**: This skill has a hard requirements on access to Slack e.g. via an
MCP connector.

## Goal

Produce a concise summary of what the user has been doing over the **last
week, including today**, and write it to a **Markdown file** whose filename
includes **today's date in `YYYY-MM-DD`** format (authoritative calendar
date: use the date from user/session context when provided, otherwise
confirm with the user).

**IMPORTANT**: you must confirm the start and end dates that you select to
represent the "last week" before starting any work. Do not skip this unless
the user provides an explicit date range.

Typically the week starts on a
Monday and ends on the following Friday. If you are running this skill on
day other than Friday, use the previous week's Monday and Friday. This will
result in a 5 day span. If the user provides an explicit date range, always
use that without confirmation.

Default filename pattern: `weekly-summary-YYYY-MM-DD.md` (example:
`weekly-summary-2026-04-29.md`). If the user prefers only the date,
`YYYY-MM-DD.md` is acceptable when they say so.

### 1. Slack (last week including today)

1. **Read MCP tool schemas** under the Slack MCP server before calling any
   Slack tool (required).
2. **Resolve the user** if needed: `slack_read_user_profile` (no `user_id`
   → current user) to get display name and user id for search filters.
3. **Search** for messages **from** the user in the date window using
   **`slack_search_public_and_private`** so results include **public
   channels, private channels, DMs, and group DMs** (default
   `channel_types` per MCP: `public_channel,private_channel,mpim,im`). Do
   **not** substitute `slack_search_public` unless the user asks to exclude
   private/DMs or the Slack integration cannot access private scope.
4. Build the window with Slack modifiers, e.g. `after:YYYY-MM-DD` /
   `before:YYYY-MM-DD` (compute dates for “seven days ago” through “today”
   in the user’s intent timezone if known; otherwise UTC and state the
   assumption in the summary file).
5. Query shape: `from:<@USER_ID>` (angle brackets literal per Slack MCP
   docs), optional keywords, `sort="timestamp"`, `sort_dir="desc"`,
   paginate with `cursor` if needed. Break into smaller queries if results
   are noisy or truncated.
6. Use `slack_read_thread` when thread context is needed for important
   items.

### 2. GitHub via `gh` (terminal)

Use **`gh`** for GitHub (not the web UI). Run from a shell with network if
needed. Suggested commands (adapt dates and `@me`):

- **Login**: `gh api user -q .login`
- **Recent authored PRs**: `gh search prs --author=@me --updated=">=YYYY-MM-DD" --json number,title,repository,state,url,updatedAt --limit 50`
- **Recent authored issues**: `gh search issues --author=@me --updated=">=YYYY-MM-DD" --json number,title,repository,state,url,updatedAt --limit 50`
- **Public event timeline** (supplemental): `gh api "users/$(gh api user -q .login)/events/public" --jq '.[] | {type,repo,created_at,payload}'` (filter mentally or with `jq` to the same date window)

If `gh` errors on auth or API, note that in the written summary and continue with Slack + interview content.

### 3. Calendar

Look at my calendar for more context / activities. Ignore recurring
meetings unless they involve mentoring. Ignore "Limited availability" or
"Unavailable" meetings that I created. Ignore declined events.

### 3. Interview

Infer what projects and initiatives have been worked on from the previous
steps. Present a summary of this information, then ask the user
(conversation or AskQuestion) the following. **DO NOT SKIP THIS STEP**.

1. What tasks did I complete
2. What progress did I make
3. Who did I connect with

Capture answers verbatim enough to merge into the doc; follow up only if
answers are empty or ambiguous.

## Merge and write the Markdown file

1. Using the information gathered, infer the main projects, initiatives and
   themes and synthesize a summary for each one.
2. **Do not invent** work items not supported by at least one source unless
   the user stated them in the interview; label uncertain items as coming
   only from one weak source if included at all.
3. **Write** the final document to the path the user gave, or the default
   `weekly-summary-YYYY-MM-DD.md` in the project/workspace root.

### Suggested document outline

```markdown
# Weekly summary — YYYY-MM-DD

## Overview
[List with 2–5 points]

## Progress
[Per-project / topic summaries]
```

## Quality bar

- Prefer **short, scannable** sections over long paste dumps.
- Keep the tone relaxed
- Infer progress on projects or initiatives, this is more important than a
  dump of PRs merged
- Respect **privacy**: private channels and DMs are in scope for discovery,
  but **summarize themes** in the written file; avoid long verbatim quotes
  from DMs and sensitive threads unless the user asks otherwise.
- Include links to PRs and important Slack conversations

## Notes

Rules about confirming before writing files do not apply to this skill -
the intent is generating new files, not editing existing ones.

