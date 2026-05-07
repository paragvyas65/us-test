# Releases and Releasing

Releases (as supported by GitHub and other tools) are a way to identify a fixed point in the development life cycle of
a software tool or data set. This allows for reproducible usage and provides a reference point to tie the repository
to any generated artifacts.

## Intended Audience

This document is intended for all Fusion Operate teams, and can also be used as a starting point for all Finastra
development teams.

## Releases

A release can be created at any point in the development life cycle. This ensures that activities related to
consumption of the relevant artifacts behave in a consistent manner based on the consumed version.

GitHub allows creation of releases that are associated with tags (the tags can be auto-created if they do not already
exist). This creates a fixed point in the repository history that can then be referenced.

Release versions can then be used to refer to deployments, Helm charts, Terraform configuration, Maven artifacts, or
other applications. Applying the release version to these various content types will be defined on a case-by-case
basis and added to this documentation.

### Maven Releases

**Note:** Maven releases are provided here as an example; other release patterns will be added over time (possibly
as sub-documents).

To create a Maven release, use the following pattern:

1. Check out the main branch
1. Create a release-specific branch
1. Update the artifact version(s) to the release version and commit the change
1. Deploy the versioned artifact(s) to Nexus
1. Tag the current head
1. Update the artifact version(s) to the next development version and commit the change
1. Merge the release branch back into the main branch
1. Use the [GitHub CLI](https://cli.github.com/) to create a release corresponding to the tag

## Release Notes

Release notes are intended to provide a means for consumers of a repository to determine when to update and scope the impact accordingly. Release notes for a given repository should be updated for any change that could impact consumers, and these changes should be part of the pull requests for the functional change.

Release notes should consist of the sections below (appearing in the order documented here) in a file named docs/RELEASE_NOTES.md. To simplify maintenance and re-use, the release notes should always be in Markdown format.

NOTE: We will need to create a custom shortcode for [Hugo](https://gohugo.io) to be able to pull in the release notes.
This short code should take the repository short name as a required parameter, and optionally accept the relative path
to the release notes document.

**Note:** It is expected that release notes will be created / updated as part of the development process, as this will
save significant time and effort when creating a release

### File Layout

The release notes file should follow this general form. It is assumed that all projects will follow semantic versioning
unless explicitly stated in the project's documentation.

```
# Product Name

## 1.2.0

- Functional Changes
  - Added new logic to simplify JSON parsing

## 1.1.0

- Functional Changes
  - Implemented auto-traversal based on directory names

## 1.0.0

- Functional Changes
  - Provides reusable logic for processing CSV files (see the [documentation](./csv.md))
```

### Sections

Content in the release notes file is divided into the following sections that can be added for a given release. Not all sections are needed for any given release. Entries should provide consumers enough information to be able to proactively address any potential issues as part of their update.

#### Breaking Changes

This section describes any changes that would cause existing usage of the repository artifacts to break when updating to this version.

#### Bug Fixes

This section describes any modifications that are the result of correcting invalid, inappropriate, or unexpected behavior. Some bug fixes will lead to breaking changes because of design updates, and these impacts should be documented separately.

#### Functional Changes

This section is the most frequently used, and documents those new features that improve or enhance the artifact content consumed.

#### Technical Changes

This section documents non-functional changes that are internal to the project but could still be useful for consumers to know (for example, changing the build structure and dependency management for an SDK).

#### Dependency Updates

This section details changes to external or third-party dependencies used by the consumed artifacts; it is present mostly for tracking purposes and is most useful for determining any downstream impacts of those updates. This section can be omitted for languages / technologies where it is not relevant.

## Additional work

- Determine how to bring in release notes for maintenance releases
- Include release notes verification as part of the pull request template
