---
xCard:
  card_type: agent
  version: '0.1'

id: hep-endpoints
name: hep-endpoints (experiment-neutral HEP compute job adapters)
description: >-
  Experiment-agnostic Python library that runs batch jobs on HEP compute
  endpoints through one small interface (submit, status, fetch, cancel) over
  Slurm reached by SSH, Fermilab Elastic Analysis Facility JupyterHub GPU
  slices driven with a hub token, and FNAL jobsub_lite on the grid. Standard-
  library only (optional websocket client for the EAF terminal). Holds no
  experiment names, site paths, user names or accounts: every site setting comes
  from arguments or HEPEP_* environment variables, and the experiment package
  supplies its job environment through hooks. Durable submission intents and
  per-handle locks fence Slurm and jobsub so a lost reply never double-submits.
  Public Apache-2.0 package at github.com/RobMina/hep-endpoints.

science:
  - particle-physics
keywords:
  - hep-endpoints
  - slurm
  - jobsub
  - fermilab eaf
  - elastic analysis facility
  - batch jobs
  - hpc adapters
  - experiment agnostic
  - iri
  - gpu jobs
  - high energy physics
  - genesis mission
  - open source
  - job recovery
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '1.0.0'
last_updated: '2026-11-21'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/hep-endpoints
relationships:
  - type: compatible_with
    target: mu2e-fastsim-mcp
    target_label: Mu2e fast simulation MCP server (uses these adapters)
  - type: compatible_with
    target: mu2e-mu2ebo
    target_label: Mu2eBO (fastsimkit endpoint adapters)
  - type: compatible_with
    target: nova-fastsim
    target_label: NOvA ND fast simulation
  - type: runs_on
    target: mu2e-uva-hpc
    target_label: UVA Rivanna/Afton (slurm_ssh example)
  - type: runs_on
    target: mu2e-fnal-eaf
    target_label: Fermilab EAF (eaf adapter)
  - type: runs_on
    target: mu2e-fermigrid
    target_label: FermiGrid (jobsub adapter)

io_contract:
  input_modes:
    - application/x-sh
    - application/json
    - text/plain
  output_modes:
    - application/json
    - application/octet-stream
  modalities:
    - tabular
  task_tags:
    - job submission
    - hpc orchestration
    - endpoint adapter

extension:
  kind: agent
  skills:
    - Submit an idempotent batch job by handle on Slurm over SSH, EAF or jobsub (submit)
    - Poll job status with durable intent reconciliation (status)
    - Fetch a completed job's output directory (fetch)
    - Cancel a running or queued job (cancel)
    - Admit resources against site budget and device limits without contacting the site (admit_resources)
    - Declare GPU-type tables and auto MIG-slice selection for Slurm sites
  capabilities:
    streaming: false
    push_notifications: false
    state_transition_history: true
  protocol_version: ''
---

# hep-endpoints (experiment-neutral HEP compute job adapters)

Public, experiment-agnostic package for HEP batch adapters.
Code: [RobMina/hep-endpoints](https://github.com/RobMina/hep-endpoints) (Apache-2.0).

Archived on Zenodo: concept DOI [10.5281/zenodo.24418701](https://doi.org/10.5281/zenodo.24418701) (every version);
v0.1.0 is [10.5281/zenodo.24418702](https://doi.org/10.5281/zenodo.24418702).

## What it does

One interface over three backends:

| Endpoint | Where jobs run |
|---|---|
| `slurm_ssh` | any Slurm cluster reachable with `ssh` (key or Kerberos) |
| `eaf` | Fermilab EAF JupyterHub server on an A100 MIG slice |
| `jobsub` | FNAL grid through jobsub_lite |

Records live in a local state directory so a restarted caller finds its jobs. Slurm and jobsub fence every dispatch
with a durable intent and a per-handle lock.

## How to use it

Install the package, set the `HEPEP_*` variables (or constructor arguments) for the chosen endpoint, and call
`hependpoints.get("slurm_ssh"|"eaf"|"jobsub", ...)`. The experiment package owns accounts, workdirs, images and
job environments; this package never embeds them.

Offline tests use fakes for Slurm, JupyterHub and jobsub; CI needs no site credentials.

## Limitations

- Not a facility card: it describes the adapter library, not Rivanna, EAF or FermiGrid themselves.
- Credentials (SSH keys, hub tokens, jobsub roles) stay in the caller's environment; never in this card or the
  public repository.
- One EAF job runs at a time on the user's single slice; later submits queue.
