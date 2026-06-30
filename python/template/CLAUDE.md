# CLAUDE.md

Engineering doctrine for working in this repo — how to **plan, architect, write,
and test**. Not a project tour; read the README and the code for what this repo
does.

## Plan before you build

- For anything non-trivial, plan first: state the approach, the files you'll
  touch, and the trade-offs — briefly — before writing code. Prefer the simplest
  design that satisfies the requirement.
- If a change would alter a public interface, a data schema, or a cross-component
  contract, stop and get agreement before implementing — even if told to just do it.
- Ask only when a genuine decision is ambiguous *and* the answer changes what you
  build. Otherwise pick the obvious default, say so, and proceed.
- **Verify empirically.** Run it, measure it, diff it — don't assert behavior you
  haven't observed. Report outcomes faithfully, including failures and skips.

## Architecture

- **Small units.** Functions under ~50 lines, files under ~500. Longer usually
  means it's doing too much.
- **Composition over inheritance;** no 3+ level hierarchies.
- **No global mutable state,** module-level mutables, or singletons. Pass
  dependencies explicitly.
- **Single source of truth.** Define each constant/decision once; co-locate a
  component with its tests and types.
- **Explicit over magic.** No hidden control flow, no decorator/annotation magic,
  exhaustive `match`/`if` arms (no catch-all that silently swallows new cases),
  explicit imports (no barrel re-exports). Read config once at one entrypoint —
  not via ambient env reads scattered around.

## Code style (for agent reliability)

- **Type hints at module boundaries** — they are compile-time guardrails.
- **Docstrings on exported surfaces** (public functions, entrypoints, APIs).
  Internal single-callsite helpers rely on good names, not docstrings.
- **Comment the *why*, never the *what*.** Default to no comment. A stale comment
  is a bug — update or delete it in the same change.
- **Anchor comments:** `AIDEV-NOTE:` for durable notes (keep short; don't remove
  one without reason). **Structured TODOs only:** `TODO(#123):`, never a bare
  `# TODO fix later`.
- **Self-documenting names:** verb + noun (`refine_frame`, not `handle`/`process`).
- **Explicit, typed errors** callers can catch — never `raise Exception("...")`.
- **Match the surrounding code** — its idioms, naming, and comment density.

## Make surgical changes

- Every changed line traces to the task. Don't refactor what isn't broken.
- Clean up only the mess you made (your own orphaned imports/vars).
- Surface unrelated issues you notice as follow-ups; don't silently fix or
  reformat them inside an unrelated change.

## Testing

- **Test behavior, not mechanics.** Assert on observable outputs, not call counts.
- **Name tests after behaviors** (`test_rejects_invalid_frame`), not `test_3`.
- When you find a bug, add the failing input as a test case **first**, then fix.
- **Mock at the boundary** (external services), never internal functions between
  your own modules.
- Don't test framework behavior or trivial getters, and never write a test that
  still passes when the feature is broken.

## Before you finish

- Run the repo's checks (format, lint/type, tests) before calling work done.
- State what you verified and how. If something is unverified or skipped, say so.
