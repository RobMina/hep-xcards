# hep-xcards

Experiment-agnostic [xCards](https://github.com/AI-ModCon/discovery-local) for HEP resources in the DOE Genesis
Mission: Markdown cards with YAML front matter that the Genesis Discovery Engine indexes and the xCard Registry
stores. Mu2e-specific cards live in the [`mu2e-xcards`](https://github.com/RobMina/mu2e-xcards) **submodule**.

This repository holds only card sources (plus the Mu2e submodule). Each card file is the source of truth;
registering a card copies it into a registry, which assigns its own id.

## Layout

| Path | Contents |
|---|---|
| `cards/agents/` | Experiment-neutral agents / libraries that act (`hep-endpoints`, …) |
| `cards/models/` | Shared models and packages (`cryjax`, `hep-simlib`, `hep-simbench`, `nova-fastsim`, `scint-fibre-fastsim`, …) |
| `cards/datasets/` | Shared datasets (none yet; collaboration data policy applies) |
| `cards/infrastructure/` | Shared facilities (prefer experiment cards when the use is experiment-specific) |
| `cards/workflows/` | Cross-experiment workflows |
| `mu2e-xcards/` | Git submodule → [RobMina/mu2e-xcards](https://github.com/RobMina/mu2e-xcards) |

File name = the card `id` + `.md`. Parent-repo ids are **not** `mu2e-` prefixed (those belong in the submodule).

## Clone

```bash
git clone --recurse-submodules https://github.com/RobMina/hep-xcards.git
# or after a plain clone:
git submodule update --init --recursive
```

## Writing a card

Start from the matching template in `discovery-local/templates/` (or the `xcard-author` skill), never from scratch.

```bash
conda env create -f environment.yml            # once (or: pip install -r requirements.txt)
conda activate hep-xcards
python scripts/validate.py                     # parent cards only
python scripts/validate.py --include-mu2e      # parent + submodule
scripts/check.sh cards/models/cryjax.md        # validate.py + discovery-local template-diff
```

`validate.py` matches the registry offline (front matter, Draft 2020-12 against `schema/xcard.schema.json`), plus
HEP conventions as warnings. Secrets or non-public paths are always errors. GitHub Actions runs it on every push.

Conventions (same spirit as mu2e-xcards):

- `description`, `keywords` and `skills` carry everything search should find; the body is for readers only.
- `sensitivity`: `general` only for public resources. Site-private services are `reviewed` or `restricted`.
- No secrets, tokens, internal hostnames with credentials, or non-public data locations — this repository is public.
- **No numbers that go stale.** Describe what a resource is and how to reach it; cite documents for results.
- Typed `relationships:` entries create graph edges for spine cards; targets must be card ids that exist when both
  catalogues are registered (cross-repo links to `mu2e-*` are intentional).

## Registering (local Discovery stack)

Registering is deliberate. Use `scripts/registry.sh`, which validates, creates once, replaces on later pushes, and
resyncs the engine:

```bash
# Bring up AI-ModCon/discovery-local (docker compose up -d) first.
scripts/registry.sh push cards/models/cryjax.md
scripts/registry.sh ids
```

Workflow cards have no registry subtype; `registry.sh push` writes them into the local engine container storage.
See [Publishing to the Genesis Discovery Engine](#publishing-to-the-genesis-discovery-engine) below and the
private workspace wiki page `<private-mu2e-wiki>/genesis/xcards-discovery-publish`.

## Publishing to the Genesis Discovery Engine

Short path (detail in the wiki):

1. **Author** the card from a discovery-local template; keep it in this repo (or `mu2e-xcards` if Mu2e-only).
2. **Validate offline:** `python scripts/validate.py path/to/card.md` (and `--strict` before a push).
3. **Validate against a local registry** (optional but recommended for data cards):
   `curl -X POST http://localhost:18100/api/current/registry/<type> …` or `scripts/registry.sh push`.
4. **Local engine:** `curl -X POST http://localhost:18000/api/v1/admin/resync`, then search in the UI / discover API.
5. **Production AmSC catalogue:** a human-gated register into the AmSC Data Catalog / production registry (Kong +
   PingAM). Who registers under which AmSC project is still an open ModCon question — do **not** treat a local
   `registry.sh push` as production publication. Ask ModCon DBS/BPSW before a shared-catalogue write.

## Parent vs submodule

| Put it here (hep-xcards) | Put it in mu2e-xcards |
|---|---|
| cryjax, hep-simlib, hep-simbench, hep-endpoints | Mu2e MCP servers, Mu2eBO, CRV/tracker/beam fastsim |
| Shared packages (scint-fibre-fastsim, nova-fastsim, ldmgen, …) | Mu2e facilities, Mu2e workflows |
| Cross-experiment model cards | Mu2e-only datasets when policy allows |

Draft `mu2e-cryjax` / `mu2e-hep-*` ids that briefly lived under mu2e-xcards are superseded by the parent ids above.

## License

Apache-2.0 (see `LICENSE`). Individual cards declare their own `license:` for the resource they describe.
