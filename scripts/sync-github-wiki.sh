#!/usr/bin/env bash
# Publish mirrored Markdown + assets from wiki/ → GitHub wiki git remote.
#
# Requirements:
#   - gh authenticated (scopes: repo for HTTPS git helpers)
#   - Wiki enabled & initial page created upstream if remote was missing historically
#
# Usage:
#   scripts/sync-github-wiki.sh               # rsync mirror + push
#   DRY_RUN=1 scripts/sync-github-wiki.sh     # show plan only
#
# Environment knobs:
#   WIKI_GIT_URL   Explicit clone URL ending in .../repo-name.wiki.git
#   WIKI_SYNC_DELETE_EXTRA=0  Preserve extra pages present only inside remote wiki checkout

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WIKI_SRC="${ROOT}/wiki"
TOKEN="$(gh auth token)"
REPO_FULL="$(gh repo view --json nameWithOwner --jq '.nameWithOwner')"
DEFAULT_WIKI_URL="https://${TOKEN}@github.com/${REPO_FULL}.wiki.git"
WIKI_GIT_URL="${WIKI_GIT_URL:-$DEFAULT_WIKI_URL}"

if [[ ! -d "${WIKI_SRC}" ]]; then
  echo "error: missing ${WIKI_SRC}" >&2
  exit 2
fi

TMP="$(mktemp -d "${TMPDIR:-/tmp}/wiki-sync.XXXXXXXX")"
cleanup() {
  rm -rf "${TMP}"
}
trap cleanup EXIT

echo "Repo: ${REPO_FULL}"

if GIT_TERMINAL_PROMPT=0 git ls-remote "${WIKI_GIT_URL}" >/dev/null 2>&1; then
  :
else
  cat <<EOF >&2
error: Cannot reach wiki remote (${REPO_FULL}.wiki.git).
Enable Wikis → create the wiki home page once → retry.
Organizations may forbid wiki git access for service accounts—in that case copy wiki/*.md manually.
EOF
  exit 3
fi

git clone "${WIKI_GIT_URL}" "${TMP}/wiki"
cd "${TMP}/wiki"

# Determine default wiki branch name (historic default is master)
if git show-ref --verify --quiet refs/heads/master; then
  TRACKING_BRANCH="master"
elif git show-ref --verify --quiet refs/heads/main; then
  TRACKING_BRANCH="main"
else
  # Fall back to current HEAD name
  TRACKING_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
fi

echo "Tracking wiki branch: ${TRACKING_BRANCH}"

RSYNC_OPTS=(-a)
if [[ "${WIKI_SYNC_DELETE_EXTRA:-1}" != "0" ]]; then
  RSYNC_OPTS+=(--delete-before)
fi

plan_rsync() {
  rsync "${RSYNC_OPTS[@]}" --checksum --itemize-changes --dry-run \
    "${WIKI_SRC}/" "${PWD}/"
}

apply_rsync() {
  rsync "${RSYNC_OPTS[@]}" "${WIKI_SRC}/" "${PWD}/"
}

if [[ "${DRY_RUN:-0}" == "1" ]]; then
  echo ":: dry-run rsync preview ::"
  plan_rsync || true
  exit 0
fi

plan_rsync || true

apply_rsync

git config user.name "${GIT_AUTHOR_NAME:-Robots-Rnt-Us Wikibot}"
git config user.email "${GIT_AUTHOR_EMAIL:-wiki-sync@noreply.users.github.com}"

if git diff --quiet && git diff --cached --quiet; then
  echo "wiki already matches mirror — nothing to commit"
else
  git add -A
  git commit -m "docs(wiki): sync from repo snapshot $(date -u +%Y-%m-%dT%H:%MZ)"
fi

GIT_TERMINAL_PROMPT=0 git push origin "${TRACKING_BRANCH}"
