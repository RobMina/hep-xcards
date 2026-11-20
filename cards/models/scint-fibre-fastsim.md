---
xCard:
  card_type: model
  version: '0.1'

id: scint-fibre-fastsim
name: scint-fibre-fastsim (shared scintillator + WLS fibre optics)
description: >-
  Planned experiment-agnostic package for scintillator-strip and cell geometry
  plus wavelength-shifting fibre optical Monte Carlo that builds response tables
  for HEP fast simulation. Common optical interface with separate experiment
  backends (Mu2e CRV SiPM versus NOvA ND APD); hardware-agnostic JAX backends
  (NVIDIA, AMD, Intel). Tables publish through hep-simlib manifests. Physics
  lineage from Mu2e CRVStandalone and crvfastsim.lookupgen.core; documentation
  and test structure patterned after lumen without forking lumen's tallymap or
  CUDA-only stack. Parametric module geometry is intended for Mu2eBO
  CRV-module-geometry design campaigns. Public Apache-2.0 repo name locked as
  RobMina/scint-fibre-fastsim; create on GitHub only after the Candidate G /
  extraction-candidates wiki gate. Not yet published.

science:
  - particle-physics
keywords:
  - scint-fibre-fastsim
  - wavelength shifting fibre
  - scintillator optics
  - optical monte carlo
  - sipm
  - apd
  - jax
  - experiment agnostic
  - fast simulation
  - high energy physics
  - genesis mission
  - hep-simlib
  - cosmic ray veto
  - nova near detector
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '0.1.0'
last_updated: '2026-11-20'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: ''
relationships:
  - type: requires
    target: hep-simlib
    target_label: hep-simlib for table manifests and stores
  - type: compatible_with
    target: hep-simbench
    target_label: hep-simbench for optical-table validation
  - type: compatible_with
    target: mu2e-crv-fastsim
    target_label: Mu2e CRV fast simulation (SiPM adapter)
  - type: compatible_with
    target: nova-fastsim
    target_label: Planned NOvA ND fast simulation (APD adapter)

io_contract:
  input_modes:
    - application/json
    - application/x-gdml
  output_modes:
    - application/x-hdf5
    - application/x-npz
    - application/json
  modalities:
    - tabular
    - simulation
  task_tags:
    - optical monte carlo
    - fibre transport
    - response table generation

extension:
  kind: model
  architecture: >-
    Shared geometry families and device fibre/WLS transport; experiment adapters
    for photosensors and offline table formats; hep-simlib-backed table assembly
  framework: JAX (device-agnostic), NumPy
  base_model: ''
  training_datasets: []
  metrics: []
---

# scint-fibre-fastsim (planned)

Experiment-agnostic scintillator + WLS-fibre optical package planned as
`RobMina/scint-fibre-fastsim` (Apache-2.0). **GitHub create is gated** on the
Candidate G row in the expdesign extraction-candidates wiki; do not treat this
card as a live public package until that repo exists.

## What it will own

- Strip/cell + WLS fibre optical MC → response tables; toy geometries; Geant4 compare drivers.
- Common optical interface; separate Mu2e (SiPM) and NOvA (APD) backends.
- Hardware-agnostic JAX/XLA paths (no NVIDIA-only photon-loop hard dependency).

## What it will not own

- Offline / NOvASoft digi; Mu2e-internal table binaries; private full GDML worlds.
- Generators or event records (see `ldmgen`); site job adapters (see `hep-endpoints`).

## Intended consumers

- `mu2e-fastsim` CRV response / lookupgen path.
- `nova-fastsim` ND cell optics when available.
- Mu2eBO parametric CRV-module geometry campaigns (Candidate G / sprint G).
