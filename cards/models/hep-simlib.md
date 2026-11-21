---
xCard:
  card_type: model
  version: '0.1'

id: hep-simlib
name: hep-simlib (HEP response libraries and component banks)
description: >-
  Experiment-agnostic NumPy package for checked response libraries and component
  interaction banks in HEP fast simulation. It gives response tables, shower
  libraries, donor pools, fitted parametrisations and recorded Geant4 component
  trials one contract: manifests (axes, outputs, provenance, train/held-out
  split, dtype and RNG conventions, domain and validation status), content-hash
  checked .npz stores, out-of-domain policies that refuse before any random
  draw, float32 and float64 twins, a fidelity vocabulary from bit-identical to
  not validated, and exact replay of whole correlated component trials in any
  rigid placement with a field-free vacuum handoff. Includes a standalone Geant4
  recorder for GDML components and a C++ BankModel host so the same bank can run
  in a JAX chain and behind a G4VFastSimulationModel. Holds no experiment names
  or libraries: an experiment installs a profile and keeps its own libraries.
  Public Apache-2.0 package at github.com/RobMina/hep-simlib.

science:
  - particle-physics
keywords:
  - hep-simlib
  - response library
  - component bank
  - shower library
  - geant4 fast simulation
  - library manifest
  - content hash
  - provenance
  - experiment agnostic
  - fast simulation
  - high energy physics
  - genesis mission
  - open source
  - g4vfastsimulationmodel
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '1.0.0'
last_updated: '2026-11-21'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/hep-simlib
relationships:
  - type: compatible_with
    target: hep-simbench
    target_label: hep-simbench validation and benchmarking toolkit
  - type: compatible_with
    target: mu2e-crv-fastsim
    target_label: Mu2e CRV fast simulation (Mu2e profile)
  - type: compatible_with
    target: mu2e-beam-fastsim
    target_label: Mu2e beam fast simulation
  - type: compatible_with
    target: mu2e-tracker-fastsim
    target_label: Mu2e tracker fast simulation
  - type: compatible_with
    target: nova-fastsim
    target_label: NOvA ND fast simulation (nova profile)
  - type: compatible_with
    target: scint-fibre-fastsim
    target_label: scint-fibre-fastsim optical tables

io_contract:
  input_modes:
    - application/x-hdf5
    - application/x-npz
    - application/json
  output_modes:
    - application/x-hdf5
    - application/x-npz
    - application/json
  modalities:
    - tabular
    - simulation
  task_tags:
    - response library
    - component bank
    - surrogate simulation
    - library validation

extension:
  kind: model
  architecture: >-
    Manifested library store with content hashes and domain accounting; component
    interaction banks that replay recorded Geant4 trials in rigid placements;
    optional Geant4 recorder and header-only C++ BankModel for a second host
  framework: NumPy (optional JAX twins; Geant4 for recorder and BankModel)
  base_model: ''
  training_datasets: []
  metrics: []
---

# hep-simlib (HEP response libraries and component banks)

Public, experiment-agnostic package for HEP fast-simulation libraries.
Code: [RobMina/hep-simlib](https://github.com/RobMina/hep-simlib) (Apache-2.0).

Archived on Zenodo: concept DOI [10.5281/zenodo.24418708](https://doi.org/10.5281/zenodo.24418708) (every version);
v0.1.0 is [10.5281/zenodo.24418709](https://doi.org/10.5281/zenodo.24418709).

## What it does

- Library core: manifests, `.npz` store with schema and content-hash checks, axes with units and frames,
  out-of-domain policies (`refuse`, `clip`, `nan`), registry and download cache, float32/float64, provenance and
  fidelity vocabulary.
- Component banks: whole Geant4 trials of one finite component (particle tree, deposits, first-boundary exits,
  null outcomes) replayed exactly in any rigid placement.
- Recorder: standalone Geant4 application that records GDML components into capture tables for bank conversion.
- C++ host: `BankModel` as a `G4VFastSimulationModel` on the component envelope (one library, two hosts).

An experiment package calls `hepsimlib.profile.configure(...)` once and keeps its own libraries and subsystem list.

## Intended use

- Shared contract for response tables and component banks across experiments and subsystems.
- Bit-checked loading and validation of libraries used by Geant4-free or hybrid fast simulations.

## Limitations and risks

- The package ships no experiment libraries or physics data.
- Physics validation of component banks against full Geant4 on moved and rotated components is experiment work;
  the package provides the contract, recorder and tests on synthetic banks.
- Capture converters that read experiment-specific Geant4 frameworks stay in the experiment package.
