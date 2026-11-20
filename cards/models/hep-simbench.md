---
xCard:
  card_type: model
  version: '0.1'

id: hep-simbench
name: hep-simbench (fast-vs-stock validation and benchmarking)
description: >-
  Experiment-agnostic validation and benchmarking toolkit for a fast simulation
  against its stock (full) simulation. For every commit it answers whether the
  fast arm is still right and how much faster it is, in both float32 and float64:
  validity from Offline-style histograms flagged against a reseeded-stock floor,
  yields with tolerances and a statistical-power rule, throughput as warm rate
  over the stock rate per single-core grid slot, a warm-rate timer with device
  synchronisation, an approximation registry with default/fast/fidelity presets,
  ROOT-histogram conversion, and Codabench results-submission bundles. NumPy-only
  scoring so a Codabench worker runs it unchanged. Experiment packages keep their
  task tables, converters and GPU launch settings and use this package for the
  rest; real stock references stay private. Public Apache-2.0 package at
  github.com/RobMina/hep-simbench.

science:
  - particle-physics
keywords:
  - hep-simbench
  - fast simulation validation
  - stock comparison
  - validity
  - throughput
  - codabench
  - mlcommons science
  - experiment agnostic
  - benchmarking
  - float32
  - float64
  - high energy physics
  - genesis mission
  - open source
  - approximation registry
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '1.0.0'
last_updated: '2026-11-20'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/hep-simbench
relationships:
  - type: compatible_with
    target: hep-simlib
    target_label: hep-simlib response libraries and component banks
  - type: compatible_with
    target: mu2e-crv-fastsim
    target_label: Mu2e CRV fast simulation
  - type: compatible_with
    target: mu2e-beam-fastsim
    target_label: Mu2e beam fast simulation
  - type: compatible_with
    target: mu2e-tracker-fastsim
    target_label: Mu2e tracker fast simulation
  - type: compatible_with
    target: mu2e-genesis-benchmarks
    target_label: Mu2e Genesis AI benchmark suite (uses this scorer)
  - type: compatible_with
    target: nova-fastsim
    target_label: NOvA ND fast simulation

io_contract:
  input_modes:
    - application/json
    - application/x-root
  output_modes:
    - application/json
  modalities:
    - tabular
    - metrics
  task_tags:
    - validation
    - benchmarking
    - fast versus stock
    - codabench scoring

extension:
  kind: model
  architecture: >-
    Histogram and yield scorer with reseeded-stock floor and dual-dtype contract;
    warm-rate bench timer; approximation registry; ROOT-to-hists converters;
    Codabench bundle builder; synthetic reference for tests and dry runs
  framework: NumPy (Python)
  base_model: ''
  training_datasets: []
  metrics: []
---

# hep-simbench (fast-vs-stock validation and benchmarking)

Public, experiment-agnostic package for fast-versus-stock scoring.
Code: [RobMina/hep-simbench](https://github.com/RobMina/hep-simbench) (Apache-2.0).

## What it does

- `hepsimbench.score`: validity and throughput of a fast arm against stock on the same generated events, both
  float precisions required.
- `hepsimbench.bench`: warm-rate timer with device synchronisation and experiment hooks.
- `hepsimbench.approximations`: declare every model that stands in for stock, with levels and presets.
- `hepsimbench.from_root`, `codabench`, `synthetic`: convert Offline histograms, build Codabench bundles, and ship a
  synthetic example with no experiment content.

## Rules the package keeps

- Both float32 and float64 are required for every workflow.
- Real stock references are experiment data and stay out of public repositories.
- Cost per event is scored only with a private flag and never on a public leaderboard.

## Intended use

- Commit-gate and Codabench scoring for Geant4-free or hybrid fast simulations in any experiment.
- Shared vocabulary for validity, throughput and approximation provenance.

## Limitations and risks

- The package does not ship experiment references; without a floor the flag threshold defaults to a fixed chi2/ndf
  cut.
- Throughput needs a declared stock rate per grid slot (or a Geant4-host baseline rate) in the reference.
