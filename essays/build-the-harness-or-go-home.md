---
layout: essay
title: "The Honeymoon Is Over: Build the Harness or Go Home"
subtitle: "Why coding agents automate the easy part and multiply the hard part"
date: 2026-05-02
status: draft
opening: |
  Many still believe you can point a coding agent at an existing enterprise codebase, hand it a real task, and get something shippable back. After ten months of trying hard, I say: no f***ing way — unless you are fine with exhausting babysitting. The agent is like a junior engineer who brings a clean build and thinks the work is done — eager to rewrite the foundations, blind to every constraint or pattern that isn't in the diff. The difference: this junior engineer never learns, makes random mistakes, and produces faster than you can review. Build the harness, or go home (scanning endless chat transcripts).
---

## Background

I am a senior software engineer with 15+ years of experience in enterprise software delivery. This essay is the distilled argument from a [structured catalog of agent pain points](/notes/agentic-coding-pains-catalog/) I built over ten months of real delivery work.

There is an odd silence around all of this. The discourse is full of benchmarks and projects built overnight with no day-two follow-up, but almost nothing about what actually happens when you use these tools on a mature product with real constraints. Is the "I can build anything" euphoria so strong that nobody dares to write about the misfit with real paid work?

## The almost-useful trap

You give the agent a real task — something from an actual backlog, inside an actual product with a decade of accumulated decisions. Twenty minutes later it hands you back three hundred lines of generated code that compiles, passes the tests it wrote for itself, and violates six project-level constraints the agent never knew to look for.

That's the almost-useful trap. The code is not wrong, exactly. It just doesn't fit. The naming doesn't match the codebase's conventions. The abstraction doesn't slot into the existing structure. A library you phased out eighteen months ago for good reasons has reappeared. The behavior has changed in a corner case that no test covers because it lives in a ten-year-old support agreement nobody thought to document.

You can fix it. You always can. That's the trap. Because "fixable" is doing a lot of load-bearing work here. You fix the naming. You rebuild the abstraction. You re-examine the library choice. You go read the support agreement. By the time you're done, you've spent more time than if you had written the code yourself — except now you're also the author of record for something you didn't design, verifying decisions you didn't make, holding the risk for a diff you didn't review properly because the agent had already made you feel like the work was done.

The agent automated the part that was already easy: typing. What it multiplied is everything else.

## What the agent leaves behind

Every agent session leaves a trail.

There's the obvious trail — the diff. The less obvious one is the hole where context should be: no record of what the agent read to understand the task, no explanation of which alternatives it rejected and why, no flag on the three places it guessed instead of asked, no summary a reviewer could actually use. The chat transcript exists, technically, but reading it costs almost as much as redoing the exploration. It's not state. It's archaeology.

The next session starts blank. Everything the agent learned about the product, the codebase's idioms, the stakeholder constraints, the decisions made during the prior run — gone. You reconstitute it from scratch, every time, hoping you remember to mention the things that burned you last time.

Meanwhile, the verification burden has landed on you. The agent cannot verify its own work — not because it lacks a test runner, but because the scope question ("did we actually solve the right problem?") requires judgment that lives outside the diff. And agents are optimistic. They will tell you the work is done with the same tone of voice whether it compiles or catastrophically breaks. So every generated change needs deeper inspection than manually written code, not because the code is worse on average, but because the failure modes are subtle and the agent will not wave a flag.

Zoom out and the picture is: agents produce output volume that exceeds what a human can safely inspect, with verification infrastructure that wasn't designed for this rate, in a supervision interface (chat) that wasn't designed for this at all. You are not moving faster. You are moving faster *toward decisions you haven't made yet*, building up a debt of unverified assumptions that will crystallize into an incident at the worst possible moment.

## The harness prescription

Nobody talks about the harness.

They talk about the agent. They benchmark it on HumanEval. They demo it writing a web scraper from scratch. The demo always works because a web scraper from scratch has no prior decisions to violate, no codebase to align with, no reviewers who will ask why you introduced a new HTTP client when the project already has one.

The harness is everything the demo skips: the workflow that specifies when the agent explores vs. when it executes. The constraint document that gives the agent the org-level rules it can't find in the repo. The checkpoint discipline that stops the agent before it's too deep into the wrong path. The verification gate that runs before the agent is allowed to call the work done. The session-close ritual that extracts decisions and risks into durable notes instead of letting them die in the transcript. The commit discipline that gives you rollback points instead of a single massive diff to review.

None of this is glamorous. None of it will win a benchmark. But without it, what you have is an agent that is very good at generating code and very bad at being a professional: it doesn't ask the right questions before starting, it doesn't stop when it's blocked, it doesn't tell you what it doesn't know, it doesn't preserve its own work for the next session, and it doesn't hand you something you can responsibly ship.

The engineers who are getting real leverage out of these tools right now are not the ones who are most impressed by the agent. They're the ones who treat the agent as one component in a delivery system that they had to build and that they maintain. They have playbooks. They have constraint files. They commit checkpoints. They close sessions with structured notes. They've built the harness.

Everyone else is still in the honeymoon phase, measuring productivity by token output, waiting for the invoice to arrive.

## Closing

*Build the harness, or end up in cognitive hell.*

