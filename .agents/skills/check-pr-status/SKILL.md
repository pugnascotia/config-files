---
name: check-pr-status
description: Triage a failing Buildkite CI build on a GitHub PR by locating the failing job, retrieving logs, and identifying the root cause.
version: 1.0.0
---

# Check PR status

## Prerequisites

- `buildkite-cli` skill installed and available. Use it for `bk` installation/authentication and generic command reference.
- `gh` authenticated for GitHub API access.
- `jq` available for JSON filtering.

## Steps

1. Get the PR head commit SHA.

```bash
SHA="$(gh pr view <PR_NUMBER> --repo <OWNER>/<REPO> --json headRefOid -q .headRefOid)"
```

2. Extract `BUILDKITE_ORG`, `BUILDKITE_PIPELINE`, and `BUILDKITE_BUILD_NUMBER` from the failing Buildkite commit status URL.

Assumption: at least one commit status on the PR head commit has a Buildkite context and a `failure` or `error` state.

```bash
read -r BUILDKITE_ORG BUILDKITE_PIPELINE BUILDKITE_BUILD_NUMBER <<<"$(gh api \
  -H "Accept: application/vnd.github+json" \
  "/repos/<OWNER>/<REPO>/commits/$SHA/status" \
  --jq '.statuses[]
    | select(.context | startswith("buildkite/"))
    | select(.state == "failure" or .state == "error")
    | .target_url
    | capture("https://buildkite.com/(?<org>[^/]+)/(?<pipeline>[^/]+)/builds/(?<build>[0-9]+)")
    | "\(.org) \(.pipeline) \(.build)"' | head -1)" && \
printf 'org=%s\npipeline=%s\nbuild=%s\n' "$BUILDKITE_ORG" "$BUILDKITE_PIPELINE" "$BUILDKITE_BUILD_NUMBER"
```

Guard against no result before proceeding:

```bash
[[ -z "$BUILDKITE_BUILD_NUMBER" ]] && echo "No failing Buildkite status found — build may not have reported yet" && exit 1
```

3. Use the `buildkite-cli` skill to troubleshoot the failed build.

When summarizing the failure, prefer the **first primary error** in the
failing job log. Failures during e.g. cleanup or diagnostics capture can be
called out as secondary problems.

If it looks like a particular component / service is at fault, look for
artifacts / diagnostics attached to the build to dig deeper (see below).

## Output format (recommended)

When reporting results, include:

- Primary failure: first true error from the failing script job.
- Secondary failures: triggered/blocked/broken follow-on jobs caused by primary failure.
- Failing build/job links: parent build, triggered build (if any), and first failing script job.
- Suggested next fix: one concrete action for the owning team.

## Artifacts (generic workflow)

For generic artifact listing/downloading patterns, follow the `buildkite-cli` skill.

## Artifacts: k8s platform diagnostics (optional)

Some pipelines upload a platform diagnostics zip artifact named like `k8s-platform-diagnostics-${TIMESTAMP}.zip`.
Once extracted (e.g. under `/tmp`), pod logs can be found at:

`$ARCHIVE_NAME/$SERVICE/pod/$POD_NAME/logs.txt` (or sometimes just `$SERVICE/pod/$POD_NAME/logs.txt`)

Discover diagnostics zip artifacts:

```bash
bk artifacts list "$BUILDKITE_BUILD_NUMBER" \
  -p "$BUILDKITE_ORG/$BUILDKITE_PIPELINE" \
  --json | \
jq -r '.[] | select((.path // .filename // "") | test("^k8s-platform-diagnostics-.*\\.zip$")) | "\(.id)\t\(.path // .filename // "<no-path>")"'
```

Download a selected diagnostics zip and inspect it manually:

```bash
bk artifacts download "$ARTIFACT_ID" \
  --build "$BUILDKITE_BUILD_NUMBER" \
  -p "$BUILDKITE_ORG/$BUILDKITE_PIPELINE" && \
unzip -o "<downloaded-zip-file>" -d "/tmp/k8s-platform-diagnostics"
```

Then inspect pod logs under:
`/tmp/k8s-platform-diagnostics/$ARCHIVE_NAME/$SERVICE/pod/$POD_NAME/logs.txt`

## Optional: check for versions mismatch

If you are able to identify that a particular component is at fault, use
the `check-released-version` skill to look for a version mismatch across CI,
`dev`, and the project's `main` branch.
