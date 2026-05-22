# Where should this knowledge live? (GitHub vs alternatives)

The playbook started as a **Git repository** under an organization. That is a strong default—but not the only tool. This page helps you choose a **primary** source of truth and **mirrors**.

---

## What you are optimizing for

| Need | Lean toward … |
|------|----------------|
| Version history, blame, reproducible approvals | Git + PR review |
| Fast edits by many people without Git fluency | Wiki or shared doc |
| Search across a company intranet | Internal doc platform |
| Customer/public sharing without repo noise | Published docs site exported from Markdown |

Most robotics labs end up with **two layers**: authoritative Git-backed text **and** a short living wiki index.

---

## Option A — Git repo (what we chose)

**Strengths**

- Every change has an author + diff; regressions are obvious.
- Branches + PR templates encode review habits (checkboxes matter for safety docs).
- Works offline; clones survive vendor churn.

**Weaknesses**

- Non-developers hesitate to propose edits.
- Long narrative pages can feel heavy next to dashboards.

**Best when** Ops runbooks influence hardware safety, audit trails matter, or the same Markdown should feed static site generation later.

Companion note: this repo doubles as **grounding corpus** for assistants—see **`AGENTS.md`** (machine-oriented) plus [`agent-and-llm-usage.md`](agent-and-llm-usage.md) (human wiring).

---

## Option B — GitHub (or GitLab) wiki

**Strengths**

- Lower friction edits; good for grease notes (“Cable B on bench 3 flaky”).

**Weaknesses**

- Weaker structured review; history is thinner than meaningful Git archaeology.

**Pattern:** Keep **canonical procedures** in the repo; use wiki for **ephemeral lab tips** with a prominent link back to pinned commit or release tag.

---

## Option C — Notion / Confluence / Google Docs

**Strengths**

- Comments, inline tasks, permissions for mixed teams.

**Weaknesses**

- Export/portability lags; version diffs are noisy for operational baselines.

**Best when** The audience is overwhelmingly non-engineering collaborators.

---

## Option D — Static site generator (MkDocs, Docusaurus, mdBook)

Compile Markdown from this repo into a branded site via CI.

**Use when** You want readability for students without exposing repo file paths.

---

## Recommendation for Robots-Rnt-Us shaped teams

1. **Keep** Markdown in `jetson-flash-playbook` as the **truth** for flash procedures—especially narratives like [bring-up-journey.md](../jetson/bring-up-journey.md).
2. **Mirror** only a one-page cheat sheet plus top three failure modes onto the GitHub organization wiki ([Robots-Rnt-Us org](https://github.com/Robots-Rnt-Us)).
3. **Tag** milestones (`v0.y.z` git tags or Releases) whenever JetPack lines change materially so classrooms can cite immutable snapshots.

GitHub remains “ideal enough” because robotics bring-ups are inherently **engineering artifacts**—but pair it with a lighter mirror if non-Git teammates must edit weekly.
