# Contributing

## Where to edit

Primary sources live under `docs/jetson/`. Prefer small, focused edits with updated [CHANGELOG](../CHANGELOG.md) entries when workflows change materially.

## Organization wiki mirror

The team may optionally mirror distilled sections:

1. Keep the authoritative copy in Git (this repo PR review flow).
2. Copy **Quick Path** plus two highest-traffic troubleshooting rows into wiki pages.
3. Link back here for full matrix and versioning history.

Avoid duplicating long logs on the wiki—they rot quickly.

## Local GitHub CLI

```bash
gh auth login -h github.com
gh repo clone Robots-Rnt-Us/jetson-flash-playbook
```

## Review expectations

Pull requests must use the checklist in [.github/PULL_REQUEST_TEMPLATE.md](../.github/PULL_REQUEST_TEMPLATE.md).
