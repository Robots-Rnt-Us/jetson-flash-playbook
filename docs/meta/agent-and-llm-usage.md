# Using this playbook with AI assistants (grounding workflow)

Humans cloned [Robots-Rnt-Us/jetson-flash-playbook](https://github.com/Robots-Rnt-Us/jetson-flash-playbook) partly so Cursor / Copilot / ChatGPT-class tools **stop freelancing unreliable Jetson folklore**. Assistants must read **`AGENTS.md`** (repo root) first.

---

## What “grounded” means here

1. Answers should **cite playbook Markdown** (`docs/START_HERE.md`, `docs/jetson/troubleshooting.md`, …) before inventing bespoke procedures.
2. When NVIDIA’s UI or release notes contradict this corpus, assistants must **state the conflict** explicitly and prefer official NVIDIA docs for authoritative deltas—then help you patch this repo afterward.

---

## Wiring patterns by tool class

### A. IDE agents (Cursor, VS Code workspaces, Windsurf-class)

Best practice:

1. **Open this repository folder** as the workspace root (or add it to a multi-root workspace).
2. Keep [`AGENTS.md`](../../AGENTS.md) reachable; many agent flows auto-index workspace roots.
3. Optional: duplicate the short “read ordering” bullets into `.cursor/rules` if your robotics program mandates uniform behavior across contributors.
4. When asking questions, prepend context similar to:

   ```
   Repo: jetson-flash-playbook — obey AGENTS.md read order before guessing commands.
   Board: Jetson AGX Orin Developer Kit …
   Host: Ubuntu …
   Current SDK Manager/JetPack line: …
   Symptom (trimmed logs/commands): …
   ```

Agents with code search / file grounding use local Markdown instead of improvised forum advice.

### B. Hosted chats (attachments / projects)

Minimal upload bundle:

- [`AGENTS.md`](../../AGENTS.md)
- [`START_HERE.md`](../START_HERE.md)
- [`../jetson/troubleshooting.md`](../jetson/troubleshooting.md)
- [`../jetson/faq.md`](../jetson/faq.md)

Add [`../jetson/flash-runbook.md`](../jetson/flash-runbook.md) when you need verbatim CLI scaffolding.

Starter instruction snippet:

```
Use the attached playbook Markdown as the primary source for ordering/steps/fixes for this Jetson flashing session.
Where the playbook is silent, cite NVIDIA Jetson/Linux/SDK Manager documentation and label speculative steps.
Never assume Jetson default passwords; credentials depend on OEM Runtime vs Pre-Config flow.
```

### C. Retrieval / internal RAG pipelines

Treat each Markdown path as chunked ground truth.

- Always ingest [`AGENTS.md`](../../AGENTS.md) alongside detailed docs so retrievers inherit **read precedence rules**.
- Version snapshots with Git tags/releases so curricula can cite stable corpora (`v0.x.y`), not drifting `main`.

### D. Automation / scripted agents

Even with perfect grounding, flashing remains **hardware-in-the-loop**. Agents should propose validated commands (`START_HERE.md`, [`flash-runbook.md`](../jetson/flash-runbook.md)); humans confirm before pressing enter on destructive host actions.

---

## Failure modes and quick corrections

| Symptom | Root cause | Correction |
|---------|------------|------------|
| Assistant ships novel commands absent from playbook | Skipped grounding | Paste `AGENTS.md` preamble; narrow prompt to subsection |
| Assistant contradicts phase ordering | Memorized shortcuts | Paste relevant `START_HERE.md` headings |
| Assistant invents SSH users | Credential misunderstanding | Paste [`faq.md`](../jetson/faq.md) Runtime vs Pre-Config block |
| Assistant ignores cramped `/home` mitigation | Missing disk troubleshooting context | Paste [`troubleshooting.md`](../jetson/troubleshooting.md) disk-space section |

---

## Maintainers

If new stable patterns emerge (JetPack numbering changes, redesigned SDK prompts), extend [`troubleshooting.md`](../jetson/troubleshooting.md) plus [`bring-up-journey.md`](../jetson/bring-up-journey.md) narrative, summarize in [`START_HERE.md`](../START_HERE.md), bump [`CHANGELOG.md`](../../CHANGELOG.md). Grounding improves each time Markdown tracks reality before AI answers.
