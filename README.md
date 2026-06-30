# finteam_steps

**Mock** module showing how an individual app team can publish its *own* workflow
steps alongside the platform team's `psm_steps`. Its `finteam_` prefix means PSM
surfaces these only when an operator adds `finteam_` to **Preferences → Workflow
step sources** — demonstrating multiple, team-owned step sources in one builder.

These steps are **simulations** — they print a JSON result and exit cleanly.

## Tasks

| Task | Purpose | Key params |
|------|---------|------------|
| `finteam_steps::quiesce_app` | Gracefully stop the finance app | `service`, `drain_seconds` |
| `finteam_steps::smoke_test` | Run app smoke suite (fails loud) | `endpoint`, `suite` |
| `finteam_steps::resume_app` | Restart app + resume jobs | `service` |

## Plans

| Plan | Steps | Use as |
|------|-------|--------|
| `finteam_steps::validate` | smoke_test, `fail_plan` on any failure | workflow **validate** gate |

Validates at 100/100 for PE-console compatibility.

## Predefined workflow (`workflows/`)

`workflows/finance_safe_patch.yaml` packages exactly that sequence:
`psm_steps::pre_patch` → `finteam_steps::quiesce_app` → *patch* →
`finteam_steps::validate` → `finteam_steps::resume_app` → `psm_steps::post_patch`
— mixing platform-owned and app-team-owned steps in one rolling rollout. PSM
discovers it from git and offers it as an importable template in **Patch Groups →
Workflow**.
