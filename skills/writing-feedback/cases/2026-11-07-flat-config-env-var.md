---
date: 2026-11-07
verdict: bad
source: pasted in chat
---

## Verdict
"as of writing skill a "it" should not be the main subject. please give me a better sentence"

Asked what was meant: for an instruction, the reader stands as subject ("set X"), the tool does not ("ESLint reads X once …").
A description of what a system does keeps the thing as subject.

## Text
ESLint 8 reads a flat config once ESLINT_USE_FLAT_CONFIG=true sits in the environment.

## Patterns
- An instruction worded as tool behaviour: "ESLint 8 reads a flat config once ESLINT_USE_FLAT_CONFIG=true sits in the environment". The reader has to act, but the tool stands as subject and the action hides in a condition. Rule: "An obligation on the reader says so", which named contracts alone. Cause: Uncovered (a fresh reader kept ESLint as subject and judged that the reader owed nothing).
- A placement verb standing in for the reader's action: "sits in the environment". Rule: none. Cause: Uncovered (a fresh reader swapped it for "With … set", which still hides who sets it).

## Rewrite
To use a flat config with ESLint 8, set `ESLINT_USE_FLAT_CONFIG=true` in the environment.
