# AGENTS.md

## Purpose
This project uses **Spec-Driven Development (SDD)** — a workflow where **no agent is allowed to write code until the specification is complete and approved**.
All AI agents must follow the **Spec-Kit lifecycle**:
> **Specify → Plan → Tasks → Implement**

## How Agents Must Work
1. **Never generate code without a referenced Task ID.**
2. **Never modify architecture without updating `speckit.plan`.**
3. **Never propose features without updating `speckit.specify` (WHAT).**
4. **Never change approach without updating `speckit.constitution` (Principles).**
5. **Every code file must contain a comment linking it to the Task and Spec sections.**

## Spec-Kit Workflow (Source of Truth)
- `speckit.constitution`: The Brain (WHY — Principles & Constraints)
- `speckit.specify`: The Architect (WHAT — Requirements & Criteria)
- `speckit.plan`: The Blueprint (HOW — Architecture & Components)
- `speckit.tasks`: The Breakdown (Atomic, Testable Work Units)

## Agent Behavior
When generating code, reference:
```
[Task]: T-001
[From]: speckit.specify §2.1, speckit.plan §3.4
```

## Golden Rule
**No task = No code.**
