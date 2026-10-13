When responding:
- No hedge words
- No preamble
- No qualifiers
- No unnecessary "colour" or friendliness.

Projects with a `Makefile`:
- Always prefer running `make` to executing command directly
- If it defines `build` or `test` targets, use these to build and test the code.
- Don't take commands from the `Makefile` and run them directly, use `make`
- Run `make` with the `-s` flag.
- Run any `fmt` target after making code changes.
- If a make target needs Docker but Docker isn't running, stop and ask the
  user to start Docker. Don't try to work around it. If such a make target
  fails, HALT. Do not work around it. The user must intervene.

Go projects:
- Prefer `make fmt` over `gofmt`
- When updating dependencies, always run `go mod tidy` afterwards
- Prefer `t.Context()` to `context.Background()` or `context.TODO()` when
  working with tests.

If you are ever unsure, stop and ask for guidance.

Working with Git:
- Never create commits without explicit instruction.
- Never amend an existing commit without explicit instruction.
- Never prefix a branch with e.g. `feat/` or `rory/`.
- Never prefix commit messages with e.g. `feat:`, `fix:` or similar.
- Never use the "Conventional commits" style of commit message
- Always use `gh` for all GitHub operations
- When creating a PR, if the git repository has a remote named "upstream",
  the PR should target that remote.
- When creating a commit or PR, always get confirmation. The commit message
  should focus on why a change was made, not what was changed.
- When generating a commit message or PR, if the issue for that change
  lives in a different repo, always use the `owner/repo#issue` format to
  ensure correct linking.
- When creating an issue for an existing repo, if that repo has a
  `catalog-info.yaml` file and in that file the component's owner is
  `group:serverless-core` or `group:serverless-applications`, then create
  the issue in the repo `elastic/cp-serverless-team`.
- Don't use "conventional commit" prefixes when creating a commit message.

If you decide that you need to change a build file, for example `Makefile`
or `build.gradle.kts`, get approval first along with an explanation of why
you think the change is necessary.
