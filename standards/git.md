# Git & GitHub Usage

GitHub is used to manage both the code that we deliver and the management of its history. To that end, the team has
developed a series of conventions to ensure that development processes are reproducible and easy to manage. This
document covers aspects of the development process outside of any CI/CD integration, which will be covered separately.

## Intended Audience

This document is intended for all FusionOperate teams, and can also be used as a starting point for all Finastra
development teams.

## Repository Setup

Each repository will configure the following elements:

- Code owners (the default reviewer pool): Configure via `.github/CODEOWNERS`; See the [CODEOWNERS] documentation for
  more details
- Ensure that a minimum number of reviewers with various roles are required to approve pull requests; this can be
  handled by configuring [Get-Consensus]
- Documentation on how to contribute to the project at `.github/CONTRIBUTING.md`; see the [CONTRIBUTING] documentation
  for more details
- A pull request template at `.github/PULL_REQUEST_TEMPLATE`; see the [PR template] documentation for more details

Usage of these integrations can and should be integrated with GitHub.

**Enforcement:**

- The code owners and reviewers can be handled using [Get-Consensus]
- Adding a template file will ensure it is automatically populated into each pull request for the repository

### Branching Strategy

The preferred branching strategy is to use [trunk-based development](https://trunkbaseddevelopment.com/). The
production-ready code branch will be named `main`, and this is where releases will typically be created from. This
will be the default for new repositories.

Some teams may choose to use [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/), which also has a
set of command-line [extensions](https://github.com/nvie/gitflow) for Git. This is a less-preferred model. The
production-ready branch will still be named `main`.

**Enforcement:**

- Use of [Get-Consensus] automates pull request management
- Use of the pull request template automates the content generation at creation

## Branching

Branches will be named for the work that will be completed on them.

Branches must be deleted once merged (GitHub allows branch restoration via the corresponding pull request if needed).

**Enforcement:**

- Simple branch name conventions can be automated

### Feature Work

The naming standard for feature branches will be as follows: "`feature/<Jira-id>[/<work-summary>]`".

Branches for typical work use the branch name prefix "`feature`", which indicates that it is a set of work related to a
discrete deliverable. The "`Jira-id`" is the identifier of the Jira issue describing the work. If there will be
multiple segments of work (for example, when an issue is broken into sub-tasks), an additional name segment can be
added describing the work subset.

### Ad Hoc Work

Branches for work outside of Jira issues is sometimes needed. The naming standard for ad hoc branches will be as follows: "`feature/<work-summary>`". Like feature work, each branch will be explicitly tied to a specific deliverable
aspect.

### Maintenance Work

The naming standard for maintenance branches will be as follows: "`maint/<maint-version>`", where `maint-version`
will replace the last version segment with `x` (for example, `maint/v1.4.x`). This allows ongoing maintenance on that
branch without the need to create a new branch for subsequent maintenance releases of that version.

Branches for maintenance work use the branch name prefix `maint` to indicate that it is a set of work related to a
patch or maintenance update for an existing release. These branches are potentially long-lived and are treated as
secondary main branches. New work is branched from them and merged back into them, and they are potentially release
sources.

## Commits

Each commit must map to a discrete set of changes that can be built / delivered.

### Commit Messages

The commit message summary must start with the Jira issue ID and be less than 50 characters long (if possible; 72
should be considered a hard limit). It should be phrased in the imperative ("`Change the handle`" instead of
"`Changed the handle`") and should not have terminating punctuation. The summary phrase must start with a capital
letter.

If there is additional information about the commit, use the commit message body to provide additional information
about the rationale behind the changes. The "what" of the changes is clearly captured by Git; this information is for
the team and should capture the "why". The body (if present) must be separated from the summary by a blank line and
contain the additional information in narrative or a bullet-style list. Lines must be no longer than 72 characters,
and phrases should be sentence-case with capitalization as needed.

To simplify this process, a team commit message template can be provided. Once configured, the template will be used
automatically for all commits. This file can be stored in source control for better reusability.

To configure the template, use the following command:

```shell
git config --global commit.template <path/to/template>
```

**Note:** Most commit message templates contain documentation for the message standards; there are no fields that Git
will auto-populate when using the template.

**Enforcement:**

- The inclusion of the Jira ID can be checked for via automation
- The header/body details cannot, and require reviewers to verify

### Pre-Commit Workflow

A tool like [`pre-commit`](https://pre-commit.com) should be used to verify the working copy state prior to commit
and push (any formatting automation will be included in that process).

Recommended processes include:

- Code / file linting
- Code / file formatting
- Content validation for text formats and scripts
- Ensuring merges are complete
- File size validation (prevent large files from being committed)
- Check for private keys / passwords

## Pull Requests

The pull request title must start with the Jira issue ID and contain an overall summary of the work. The pull request
summary should describe what was done, and link to the Jira issue.

**Helpful tip:** Pull request titles in GitHub will automatically pull from the summary of the first commit on the
branch. When there are multiple commits prior to creating the pull request, the title formatting is not propagated
well; one way to work around this is to create a draft pull request after your first commit. This locks in the title,
and is unaffected by subsequent commits.

Pull requests should be squashed into a single commit when merging; the resulting commit message for the squash commit
must follow the same guidelines as for the individual commits.

**Enforcement:**

- Reviewer count and default reviewers can be automated
- Requiring resolution of comments can be automated

### Pull Request Templates

Pull request templates should be developed (content TBD); we should create a template for per repository. The template
will guide the developer to provide context for the review, and guide the reviewers to ensure that appropriate content
is provided as part of the pull request (for example, documentation updates).

### Reviewing

GitHub is very good at tracking cross-commit differences and allowing reviewers to track their work. To simplify this
process, always create new individual commits to make changes or address review feedback.

Any comments or issues raised during review should only be resolved by the reviewers who created them. This ensures
that the intent of the review comment was communicated clearly, and provides a learning opportunity for the reviewer
if there is something new to them that they were unaware of.

All comments made during a pull request review should be added to the GitHub review instead of making comments. The
reviewer must then submit the review using one of GitHub's end states:

- Comment
- Approve
- Request changes (this will block the merge for a pull request)

New commits should dismiss previous approvals, and require re-review prior to merging. This can be enforced by repository configuration.

#### Addressing Pull Request Feedback

All conversations should be resolved prior to merging. The reviewer making the comment has primary responsibility for
resolving it. If the comment is not resolved in a timely fashion and the pull request has the required approvals, the
pull request author can request permission from their scrum master or manager to resolve the comment and unblock the
work.

Reviewers can also explicitly request changes; this request will block merging of the code. The reviewer and pull
request author should agree on one of the following strategies:

- The author will make the change
- The change will be deferred, and the code will be accepted as is

If consensus cannot be reached in a timely fashion and the pull request has the required approvals, the pull request
author can request permission from their scrum master or manager to dismiss the review and unblock the work.

If the reviewer will be out of office when the story is due to be completed, it is recommended that they dismiss their
review to prevent blocking further work.

## Repository Setup

The following configuration is recommended for FusionOperate GitHub repositories.

1. Ensure a pull request is required before merging
   - Require pull request approvals
   - Dismiss stale pull request approvals when new commits are pushed
   - Require review from Code Owners
2. Require status checks to pass before merging
   - Require branches to be up to date before merging
   - Other checks as configured (SonarQube, Checkmarx, WhiteSource, etc.)
3. Require conversation resolution before merging

This configuration should integrate with the [Get-Consensus] usage as described above.

**Enforcement:**

- Repository configuration can be managed in Terraform

## Additional Work

- The overall Git workflow should be reviewed to see if there are any other improvements or automation to add
- Evaluate [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) and similar tools

## References

- https://reflectoring.io/meaningful-commit-messages/
- https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/
- https://cbea.ms/git-commit/
- https://semver.org/

[codeowners]: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners "CODEOWNERS"
[contributing]: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/setting-guidelines-for-repository-contributors "Contributing"
[get-consensus]: https://github.com/pholleran/get-consensus "Get-Consensus"
[pr template]: https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository "pull request template"
