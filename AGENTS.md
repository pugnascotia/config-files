Use `gh` for GitHub operations.

When a project has a `Makefile` and it defines `build` or `test` targets,
use these to build and test the code.

If you are unsure, stop and ask for guidance.

When creating a PR, if the git repository has a remote named "upstream",
the PR should target that remote.

When creating a git commit or a PR, confirm the command with me.

If I ask, "What's going on?":

- Use a GitHub GraphQL query to find all my open PRs, including their
  review status, and report them in a table. Use colors and emojis. Don't
  duplicate emojis and text content. Don't include a PR href. Aim for
  brevity.
- Use `gh search issues --assignee=@me --state open` to find all my open
  issues and report them in a table. Use colors and emojis. Omit labels and
  repository.
