# Publishing the GitHub wiki mirror

The canonical authoring flow keeps Markdown beside the playbook under [`wiki/`](../wiki). GitHub’s Wiki UI renders files from **a sibling git repo** (`…/repo.wiki.git`). Some organizations keep that remote disabled until someone creates the Wiki home page once in the browser.

Humans browse the published wiki here: **[github.com/Robots-Rnt-Us/jetson-flash-playbook/wiki](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/wiki)**.

---

## What ships inside `wiki/`

| Path | Purpose |
|------|---------|
| `Home.md` | Landing page + links back to authoritative repo docs |
| `Ninety-second-cheatsheet.md` | Laminated-bench cheatsheet mirrored on its own Wiki tab |
| `_Sidebar.md` | Wiki navigation injected by GitHub |
| `images/phases-overview.svg` | Three-phase infographic embedded on Home |

Treat anything checked into `wiki/` as publishable surfaces—avoid tossing scratch drafts there.

---

## One-time Org / repo checks

| Check | Details |
|-------|---------|
| GitHub Wiki feature | **Settings → General → Wikis → Enable** *(already enabled for this repo).* |
| Local permissions | Maintainer role required to push to `.wiki.git`. |
| First commit | Visit **Wiki** tab → **Create the first page** if `git ls-remote … .wiki.git` still 404’s. |

If `.wiki.git` clones continue to fail, paste `wiki/Home.md` manually—the git mirror is convenience, not correctness.

---

## Automated sync helper

[`scripts/sync-github-wiki.sh`](../scripts/sync-github-wiki.sh) wraps the mundane steps:

```bash
chmod +x scripts/sync-github-wiki.sh          # once per clone
scripts/sync-github-wiki.sh                   # publishes wiki
DRY_RUN=1 scripts/sync-github-wiki.sh         # diff only
WIKI_SYNC_DELETE_EXTRA=0 scripts/sync-github-wiki.sh  # keep orphaned wiki-only pages
```

The script clones/pushes via `gh auth token` over HTTPS **without** leaking the token beyond your shell history—still prefer running inside CI with `GH_TOKEN` secret when possible.

Historical note: wiki repos traditionally default branch `master`. The script probes `master`, then `main`, then pushes whatever exists.

---

## Updating the infographic

Edit `wiki/images/phases-overview.svg` in any SVG editor (`inkscape`, Figma export, VS Code preview). Prefer flat vectors + web-safe fonts; avoid embedding raster snapshots of SDK Manager dialogs (license/UI drift headaches).
