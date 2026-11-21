---
xCard:
  card_type: model
  version: '0.1'

id: ldmgen
name: ldmgen (shared LDM event record and generator adapters)
description: >-
  Experiment-neutral interface for light-dark-matter event generators: adapters
  for BdNMC, MadDump, PETITE, G4DarkBreM and related tools, comparison utilities,
  and exporters into detector chains. Agreed shared record keeps ldmgen/1 HDF5
  for analysis, adapters and compare; public interchange is HepMC3 plus a thin
  LdmHepMC attribute profile; experiment entry points (HEPEVT/TextFileGen,
  edep-sim, Mu2e GenParticle) are sinks only. Not merged into nova-fastsim or
  mu2e-fastsim. Public Apache-2.0 package at github.com/RobMina/ldmgen. Private
  NOvA geometry and site trees stay outside this package. No secrets in this card.

science:
  - particle-physics
keywords:
  - ldmgen
  - light dark matter
  - hepmc3
  - ldmhepmc
  - event record
  - bdnmc
  - maddump
  - petite
  - g4darkbrem
  - textfilegen
  - experiment agnostic
  - high energy physics
  - genesis mission
  - hdf5
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '0.1.0'
last_updated: '2026-11-21'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/ldmgen
relationships:
  - type: compatible_with
    target: nova-fastsim
    target_label: NOvA ND fast simulation (consumer)
  - type: compatible_with
    target: hep-simlib
    target_label: hep-simlib (orthogonal library contract)

io_contract:
  input_modes:
    - application/json
    - text/plain
    - application/x-hdf5
  output_modes:
    - application/x-hdf5
    - application/x-hepmc3
    - text/plain
  modalities:
    - tabular
    - simulation
  task_tags:
    - event generation
    - event record interchange
    - dark matter generators

extension:
  kind: model
  architecture: >-
    Common Python interface over multiple LDM generators; ldmgen/1 HDF5 analysis
    record; HepMC3/LdmHepMC public export; experiment-specific sink exporters
  framework: Python (NumPy/HDF5); HepMC3 Asciiv3 for public interchange
  base_model: ''
  training_datasets: []
  metrics: []
---

# ldmgen (shared LDM event record)

Experiment-neutral generator interface and event-record layer for light dark
matter studies across NOvA, DUNE and (later) Mu2e.

Archived on Zenodo: concept DOI [10.5281/zenodo.24418808](https://doi.org/10.5281/zenodo.24418808) (every version);
v0.1.1 is [10.5281/zenodo.24418809](https://doi.org/10.5281/zenodo.24418809).

**Public package:** [RobMina/ldmgen](https://github.com/RobMina/ldmgen) (Apache-2.0).

## Layers (agreed 2026-11-20)

| Layer | Choice |
|---|---|
| Analysis / adapters / compare | `ldmgen/1` HDF5 |
| Public interchange | HepMC3 + thin LdmHepMC profile |
| Experiment entry | Sinks only: HEPEVT / TextFileGen / edep-sim / Mu2e GenParticle |
| Rejected as shared LDM record | EDM4hep / PODIO / LCIO / LHEH5 |

## What it does

- Per-generator adapters and side-by-side compare.
- `to-hepmc3` / `to-hepevt` public sinks (no private geometry).
- Optional exporters into NOvA (`bdnmc-nova` / TextFileGen) and DUNE (`bdnmc-dune` / edep-sim) chains.

## What it does not do

- Detector fast simulation (see `nova-fastsim`, Mu2e fastsim cards).
- Optical library generation (see `scint-fibre-fastsim`).
- Site job submission (see `hep-endpoints`).
- Ship NOvA surveyed geometry or private frame JSON.

## Limitations and risks

- Chain exporters need optional deps and site-provided frame configs.
- LdmHepMC attribute list is v0 (freeze later).
- Mu2e GenParticle sink not yet implemented.
