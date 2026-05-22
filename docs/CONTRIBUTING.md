# Contributing

## Canonical vs casual notes

- **Canonical**: Markdown in this repo, reviewed via pull request (`main` stays deployable/teachable).
- **Casual grease**: Allowed on the GitHub organization wiki **only if** each page starts with “Source of truth: `jetson-flash-playbook` @ commit …” linking a tag or permalink.

Detailed rationale: [documentation strategy](meta/documentation-strategy.md).

## Where to edit

| Kind of change | File |
|----------------|------|
| First-time phased guide + cabling/cheat refresher | [docs/START_HERE.md](START_HERE.md) |
| New failure mode discovered | Extend [docs/jetson/troubleshooting.md](jetson/troubleshooting.md) |
| Emotional / timeline context | Extend [docs/jetson/bring-up-journey.md](jetson/bring-up-journey.md) THEN distill into troubleshooting |
| Exhaustive scripted steps after START_HERE drift | [docs/jetson/flash-runbook.md](jetson/flash-runbook.md), [README](../README.md) |

## Workflow

```bash
gh auth login -h github.com
gh repo clone Robots-Rnt-Us/jetson-flash-playbook
```

Open PRs referencing the checklist GitHub renders from [.github/PULL_REQUEST_TEMPLATE.md](../.github/PULL_REQUEST_TEMPLATE.md).

## Releases

JetPack/SDK Manager/UI string changes merit a Git tag (`v0.x.y`) and a [CHANGELOG](../CHANGELOG.md) entry so robotics courses can cite an immutable tarball.
