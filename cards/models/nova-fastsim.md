---
xCard:
  card_type: model
  version: '0.1'

id: nova-fastsim
name: nova-fastsim (NOvA ND JAX fast simulation)
description: >-
  NOvA Near Detector experiment package parallel to mu2e-fastsim: JAX host
  profiles, ND response and calibration, LDM orchestration examples, and site
  configuration. Depends on shared HEP libraries (hep-simlib, hep-simbench,
  hep-endpoints, cryjax, scint-fibre-fastsim) and on separate generators (BdNMC,
  ldmgen, bdnmc-nova); does not merge generators into this package. Private
  geometry and FCL live in a companion nova-fastsim-inputs bundle (follow-up).
  Event interchange follows the shared LDM record (ldmgen/1 HDF5 for analysis;
  HepMC3 plus LdmHepMC for public; HEPEVT/TextFileGen as sinks). Float32 and
  float64 on every public path. Public Apache-2.0 package at
  github.com/RobMina/nova-fastsim (scaffold: core profile present; calib/ldm/
  beamline stubs; on-device ND response later).

science:
  - particle-physics
keywords:
  - nova-fastsim
  - nova near detector
  - jax
  - fast simulation
  - light dark matter
  - hep-simlib
  - experiment package
  - high energy physics
  - genesis mission
  - float32
  - float64
  - textfilegen
  - calibration
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '0.2.0'
last_updated: '2026-11-20'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/nova-fastsim
relationships:
  - type: requires
    target: hep-simlib
    target_label: hep-simlib (nova profile and libraries)
  - type: requires
    target: hep-simbench
    target_label: hep-simbench scoring
  - type: requires
    target: hep-endpoints
    target_label: hep-endpoints for UVA/EAF/grid jobs
  - type: compatible_with
    target: cryjax
    target_label: cryjax cosmic sampler
  - type: compatible_with
    target: scint-fibre-fastsim
    target_label: scint-fibre-fastsim fibre optical tables
  - type: compatible_with
    target: ldmgen
    target_label: ldmgen shared event record and exporters
  - type: references
    target: mu2e-crv-fastsim
    target_label: Parallel packaging pattern to Mu2e fastsim

io_contract:
  input_modes:
    - application/x-hepmc3
    - application/x-hdf5
    - application/json
    - text/plain
  output_modes:
    - application/x-hdf5
    - application/json
    - text/plain
  modalities:
    - tabular
    - simulation
  task_tags:
    - detector fast simulation
    - ldm orchestration
    - calibration

extension:
  kind: model
  architecture: >-
    Experiment package with core profile/dtype, calib, thin LDM orchestration,
    beamline hooks, examples and benchmarks; private inputs companion; depends
    on hep-sim* and external generators
  framework: JAX (device-agnostic), NumPy
  base_model: ''
  training_datasets: []
  metrics: []
---

# nova-fastsim

NOvA ND JAX fast-simulation experiment package.
Code: [RobMina/nova-fastsim](https://github.com/RobMina/nova-fastsim) (Apache-2.0).

## Architecture (who owns what)

```text
nova-fastsim              │  mu2e-fastsim  │  bdnmc-dune
  profiles, ND response, examples, site.env
  private: nova-fastsim-inputs (follow-up)
        │
hep-simlib / hep-simbench / hep-endpoints / cryjax / scint-fibre-fastsim
        │
BdNMC + ldmgen + bdnmc-nova  (not merged into this package)
```

## Locked decisions

- Generators stay separate; this package depends on them.
- Calibration via hep-simlib runs in parallel with LDM example work.
- TextFileGen remains stock NOvASoft (orchestrate; do not rewrite).
- Shared event record: see the `ldmgen` card.

## Status

Scaffold: `core/` profile + dtype present; `calib/`, `ldm/`, `beamline/` stubs; examples point at the existing
bdnmc-nova / UVA two-stage chain; container def is a stub. On-device ND response is a later phase. Private GDML/FCL
never belong in the public tree.
