---
layout: note
title: "Agentic Coding — the Enterprise Engineer's Patient Leaflet"
description: "What breaks when coding agents meet enterprise software delivery."
date: 2026-05-02
status: draft
---

This is a working catalog of pain points an engineer encounters when using AI coding agents on real B2B software. It focuses on the professional delivery workflow — directing, observing, verifying, and preserving agent work — not on code quality in isolation.

The catalog groups problems by where they show up in the workflow. Within each group, each item is a distinct, named failure mode. Some are tool gaps; some are interaction design failures; some are structural problems that no current tool addresses at all.

## Foundational Misalignment

Agent output is locally correct but globally unaligned with the project's technical and business decisions. The agent never checks for alignment. The engineer is left to bridge the gap on every change.

- **Pattern drift** — introduces new code-level patterns (naming, error handling, module organization, idioms) instead of reusing those already established in the codebase.
- **Product treated as scratch space** — overwrites the running product's current behavior — the contract with users — whenever doing so is the shortest path to a working solution.
- **Recorded product commitments ignored** — does not consult external or forward-looking commitments the product has made, so it proposes changes that contradict them even when current behavior would pass review. Examples: roadmap promises, deprecation timelines, support agreements, ADRs, public API stability guarantees.
- **No constraint discovery** — the codebase's behavior encodes edge cases, invariants, and undocumented rules, but the agent does not probe current behavior, callers, or tests to surface them, leading to subtle bugs and violations.
- **Project tech direction ignored** — treats the project's already-set macro tech direction (architecture style, framework conventions, libraries in use, module boundaries) as open design space rather than a constraint.
- **No org-tech lookup** — does not consult the company-level tech constraints that live outside the repo and does not flag their absence, so it ships solutions that violate them and get rejected at review. Examples: approved languages and libraries, internal SDKs and golden paths, compliance and security requirements, cross-cutting logging/metrics/tracing standards.
- **Standalone instead of incremental** — generates standalone solutions that do not slot into the existing structure, leaving manual integration to the engineer.

## Workflow and Playbook Execution

Problems with making the agent follow the right workflow at the right level of autonomy.

- **Manual playbook enforcement** — in paid work, common task types follow known playbooks, but the user must manually impose the workflow instead of the agent executing it. Examples: phases, checkpoints, artifacts, and stop conditions.
- **Manual step-mode tuning** — user must manually adjust model level, permission mode, and autonomy for each playbook step. Examples: exploration, planning, implementation, verification, and cleanup need different defaults.
- **Action handoff instead of execution** — agent tells the user to run the next command or perform the next routine step even when the point of agentic workflow is for the agent to execute it.
- **Manual follow-up branching** — when agent output creates multiple follow-up points, user must first identify them, then manually track which should become separate sessions, tickets, commits, or future tasks.

## Scope, Design, and Ambiguity Management

Problems with defining, aligning, and protecting the intended change before and during implementation.

- **No explicit change-scope contract** — before execution, the agent does not clearly declare the intended change scope. Examples: main classes/files, structural changes, build/pipeline/config impact, and acceptance criteria.
- **Unlayered planning** — agent presents different decision levels in one mixed wall of text instead of separating them. Examples: top-level direction, design choices, naming, file edits, tests, and implementation minutiae.
- **Missing design checkpoints** — after agreeing on the top-level solution shape, the agent does not pause to align on key design choices before implementation. Examples: main concepts, class names, boundaries, and structural choices.
- **Missing ambiguity escalation rule** — when local context is insufficient or ambiguous, the agent does not clearly decide whether to ask the user, inspect broader sources, or stop instead of silently guessing.
- **No exploration watchdog** — before code changes start, there is no compact exploration summary for validating whether the discovered direction is relevant, bounded, and sufficient.
- **Low-value clarification blocking** — agent stops progress to ask a question even when the likely answer is already implied, low-risk, or could be handled as a stated default assumption.
- **Over-eager execution** — starts editing before the problem shape is stable enough.
- **Scope drift** — during implementation, the agent deviates from the original task scope or accidentally modifies files that were not supposed to be part of the change.
- **Acceptance mismatch** — code may compile and test green while still being hard to accept into the product.

## Context and Session Hygiene

Problems caused by stale, noisy, or poorly isolated session context.

- **Session contamination** — wrong assumptions and dead ends remain in context instead of being truncated back to the last healthy point.
- **Manual context-size babysitting** — the user must decide when stale or noisy context has made the session unreliable instead of the agent pruning, compressing, or isolating it.
- **No subtask context isolation** — subtasks run inside the main session, so low-level details pollute the coordinator context instead of being isolated or routed to lighter execution modes.

## Supervision Surface and Output Structure

Problems with consuming agent output through chat as the main supervision interface.

- **Chat-first supervision trap** — chat fits only babysitting mode, and even then it is too verbose and fast to follow; autonomous work needs structured task state instead of an endless scrolling transcript.
- **No turn boundaries** — chat is an endless scroll without clear per-turn units, making it hard to inspect what happened in each request/response cycle.
- **No consumption marker** — user cannot mark which parts of the agent's output have been read, accepted, rejected, or deferred, so every return to the task requires re-scanning the same history.
- **No output drill-down** — agent output is flat and linear instead of summary-first with expandable layers. Examples: goal, plan, decisions, implementation details, evidence, risks, and reasoning trail.
- **No supervision surface** — user lacks a compact view for deciding whether to let the agent continue, redirect it, or stop it.

## Live Supervision State

Problems with seeing the agent's current operational state while work is active.

- **No progress model** — user cannot easily see which phase the agent is in: understanding, planning, editing, debugging, verifying, or cleanup.
- **Missing checkpoint packet** — at natural pause points, the agent does not present a compact, structured state packet. Examples: current goal, completed work, key decisions, changed files, open risks, proposed next step, and available user actions (continue, redirect, pause, stop).
- **Weak milestone visibility** — progress is shown as activity, not as completed checkpoints against the task scope.
- **External goal tracking** — user has to track the session goal and current sub-goal outside the chat, which becomes worse when one task is split across multiple agent sessions.

## Blockers, Hypotheses, and Stop Conditions

Problems with seeing uncertainty, failed paths, blockers, and when the agent should stop.

- **Assumption opacity** — does not surface the assumptions it made unless asked afterwards.
- **Struggle hiding** — presents the final result without exposing problems it hit along the way, even though the user needs to judge whether those problems were solved correctly.
- **Hidden blockers** — agent may spend time working around a problem without clearly surfacing that it is blocked or uncertain.
- **Invisible hypothesis trail** — when trying to overcome a problem, it does not expose the current hypothesis, rejected hypotheses, or why it changed direction.
- **Poor stop conditions** — keeps patching, polishing, or expanding after the useful change is done.
- **Late surprise cost** — important problems are discovered only in the final summary or diff, when correction is already expensive.

## Durable Work State

Problems with preserving agent work as trustworthy state for later review, reuse, or resumption.

- **No session continuity** — each session starts blank: no understanding of the product, codebase, or prior decisions survives between sessions, so every run must rediscover context from scratch.
- **No durable work packet** — the main work artifacts are not bundled as one resumable unit of work. Examples: branch, prompt, task notes, ticket, PR, session state, and verification evidence.
- **Weak or unsafe resume state** — hard to resume later with a compact, trustworthy view of the work; stale or vague notes can be worse than no saved state because they create false confidence. Examples: what changed, why it changed, what was verified, what remains open, and what is risky.
- **Missing build-and-decision narrative** — there is no inspectable structured report of how the solution was built incrementally, what changed at each step, which intermediate problems were resolved, and which decisions were taken by the agent or user.
- **No incremental checkpoints** — agent work is not automatically captured as small local commits/checkpoints, even though the branch can be freely rewritten before publishing the final PR.
- **Relevant-files gap** — git preserves changed files, but not the broader file context used to understand the task, so later review and resumption lose important context. Examples: files read, investigated, used as patterns, ruled out, or used for orientation.
- **Chat history as dead weight** — raw chat transcripts preserve activity but not reusable task state; re-reading them costs almost as much as redoing the exploration. Missing extraction: goals, decisions, evidence, risks, and dead ends.
- **No learning extraction** — agent work does not automatically extract durable learnings about the project, codebase, process, or recurring mistakes that should improve future runs.

## Verification, Review, and Credibility

Problems with proving, reviewing, and trusting agent-generated changes.

- **Missing verification receipt** — there is no deterministic end-of-run proof that automated verification actually happened, which commands ran, and whether they passed.
- **Diff-as-communication breakdown** — with AI-generated output volume, raw code diff becomes an inefficient communication layer; reviewer needs higher-level intent, scope, decisions, and risk summary before reading line-level changes.
- **Diff archaeology** — reviewer must reconstruct intent from a large generated diff.
- **Wrong review order** — even when reading the code, the reviewer is forced into lexical/file-order diffs instead of relevance and provenance order: core decision first, dependent changes next, mechanical fallout last.
- **Missing PR credibility packet** — agent work does not produce a distilled author- and peer-facing report that makes the change reviewable and defensible. Examples: scope, key decisions, verification evidence, risks, and follow-ups.
- **Risk-free summary tone** — summaries sound confident but often do not identify the real risky parts.
- **Verification tax** — every generated change needs deeper checking because failures are plausible but subtle.
- **Self-verification trap** — the same agent session cannot be trusted to verify scope completion, because it may confidently report "done" even when the result does not compile.
- **Rubber-stamp temptation** — high output volume creates pressure to trust changes without enough inspection.
- **Review-story burden** — user must turn messy agent activity into a coherent PR narrative, logical commits, and reviewer-facing explanation.

## Recurring Implementation Failure Modes

Common coding and debugging patterns that make generated changes harder to accept.

- **Manualized IDE chores** — agent wastes time on routine IDE-level cleanup that should be delegated to deterministic tooling. Examples: Java imports, formatting, obvious namespace resolution.
- **Premature test fixing** — agent starts fixing unit tests before the target code shape, architecture fit, and pattern alignment have been settled.
- **No deduplication pass** — after producing code from copied patterns, there is no automatic follow-up phase that consolidates duplication into existing abstractions or project-level patterns.
- **Test-code overfitting** — aligns production code to outdated or non-business-unit test cases instead of questioning whether the tests still represent correct behavior.
- **Implementation-mirroring tests** — writes unit tests that mirror the current implementation instead of asserting the wanted contract or spec.
- **Debugging loops** — repeatedly patches symptoms instead of finding the root cause.

## External State and System Integration

Problems with keeping surrounding systems of record aligned with agent work.

- **Manual work orchestration** — surrounding work-state tracking remains human-owned instead of agent-assisted. Examples: open items, decisions, follow-ups, Jira state, PR state, and stakeholder updates.
- **No external-state sync** — agent progress does not automatically update surrounding systems of record. Examples: Jira, PR description, notes, next actions, or manager/team status.

## Appendix

### Resulting Human Cost

These are the downstream costs that accumulate when the gaps above are not addressed. They are not separate failure modes; they are the human price of everything above.

- **Engineer as alignment layer** — because outputs are technically valid but system-misaligned, the engineer must bridge the gap on every change instead of receiving aligned work.
- **Babysitting fatigue** — because progress, assumptions, and blockers are not visible enough, the user must stay alert while the agent works.
- **Attention fragmentation** — because supervision is not structured, agent work becomes another stream of interruptions.
- **Prompt fatigue** — because direction and context are not captured as durable workflow defaults, the user must repeatedly restate them.
- **Trust erosion** — because failures are subtle and verification is weak, every generated change starts to feel suspicious.
- **Overload pressure** — because agents can produce more work than the human can safely inspect, the user is tempted to keep too many risky threads in flight.

### Intentional exclusions

Out of scope for this catalog: governance and compliance, privacy and data handling, licensing and IP risk, token cost and usage accounting, vendor-specific plan or product differences, multi-session workspace management, tool and window containment across IDE/browser/terminal/OS, cross-session hierarchy and agent-to-agent coordination, and backward compatibility (shipped versions, persisted data, in-flight migrations).
