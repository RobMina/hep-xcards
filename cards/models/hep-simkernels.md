---
xCard:
  card_type: model
  version: '0.1'

id: hep-simkernels
name: hep-simkernels (Geant4-matched particle-matter kernels)
description: >-
  Experiment-agnostic Python package of Geant4-matched particle-matter kernels
  for fast simulation: muon restricted energy loss with Urban fluctuations, delta
  rays and Birks saturation (G4MuBetheBloch), electron and positron ionisation
  (Moller-Bhabha), e+- multiple scattering (WentzelVI / Goudsmit-Saunderson class
  II with Mott correction), Seltzer-Berger bremsstrahlung with 2BS angles,
  positron annihilation, muon bremsstrahlung, pair production and photonuclear
  losses, electron slab propagation (with a Pallas GPU kernel), straight-line
  transport and ray tracing through GDML geometry as convex pieces, helix and RK4
  stepping in field maps, and NIST materials with density-effect parameters. Each
  kernel reproduces a named Geant4 11.3.2 model with a NumPy reference and a JAX
  twin in float32 and float64, with deterministic GPU output. Experiments register
  their own materials and field-map scale through settings hooks. Public
  Apache-2.0 package at github.com/RobMina/hep-simkernels; bundles compact
  G4EMLOW Seltzer-Berger and G4MottData tables under the Geant4 licence.

science:
  - particle-physics
keywords:
  - hep-simkernels
  - geant4 matched physics
  - energy loss
  - multiple scattering
  - bremsstrahlung
  - seltzer-berger
  - muon radiative losses
  - slab propagation
  - gdml ray tracing
  - differentiable simulation
  - jax
  - gpu
  - float32
  - float64
  - fast simulation
  - experiment agnostic
  - high energy physics
  - genesis mission
  - open source
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '1.0.0'
last_updated: '2026-11-21'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/hep-simkernels
relationships:
  - type: compatible_with
    target: hep-simlib
    target_label: hep-simlib library store (checks the bundled tables)
  - type: compatible_with
    target: hep-simbench
    target_label: hep-simbench validation and benchmarking toolkit
  - type: compatible_with
    target: mu2e-tracker-fastsim
    target_label: Mu2e tracker fast simulation (registers the Mu2e materials)
  - type: compatible_with
    target: mu2e-beam-fastsim
    target_label: Mu2e beam fast simulation (stopping target and field maps)
  - type: compatible_with
    target: mu2e-crv-fastsim
    target_label: Mu2e CRV fast simulation

io_contract:
  input_modes:
    - application/json
    - application/xml
  output_modes:
    - application/json
  modalities:
    - tabular
    - arrays
  task_tags:
    - fast simulation
    - particle transport
    - energy loss
    - multiple scattering
    - geometry ray tracing

extension:
  kind: model
  architecture: >-
    Named Geant4 11.3.2 electromagnetic models re-implemented as NumPy references
    with JAX twins (jit, vmap; float32 or float64 via hepsimkernels.precision);
    GDML geometry decomposed into convex pieces for straight-line ray tracing;
    a Pallas GPU kernel of the slab stepper; bundled Geant4 data tables checked
    by manifest and content hash on load
  framework: JAX (GPU and CPU), NumPy
  base_model: ''
  training_datasets: []
  metrics: []
---

# hep-simkernels (Geant4-matched particle-matter kernels)

Public, experiment-agnostic kernels for fast simulations that need Geant4's charged-particle physics without running
Geant4. Code: [RobMina/hep-simkernels](https://github.com/RobMina/hep-simkernels) (Apache-2.0; bundled Geant4 data
under the Geant4 Software License, see NOTICE).

Archived on Zenodo: concept DOI [10.5281/zenodo.24418806](https://doi.org/10.5281/zenodo.24418806) (every version);
v0.1.0 is [10.5281/zenodo.24418807](https://doi.org/10.5281/zenodo.24418807).

## What it does

- `eloss`, `eioni`, `emsc`, `ebrem`, `eannihil`, `muradiative`: the named Geant4 models, NumPy reference and JAX twin.
- `eslab`, `slab_jax`: electron propagation through slabs, with a Pallas GPU kernel.
- `world`, `transport`, `crossings`: GDML geometry as convex pieces, ray tracing, sliced slab loss and correlated
  multiple scattering.
- `ehelix`: helix and RK4 stepping in constant or mapped fields.
- `materials`: NIST materials; `register()` and `add_cuts()` for an experiment's own.

## Intended use

- Device-resident transport stages of a fast simulation (any experiment), in float32 or float64.
- Studies that need Geant4-equivalent energy loss and scattering in a JAX program, for example design scans.

## Limitations and risks

- Only the models named in the README are implemented; hadronic interactions and optical physics are not.
- Gradients through the kernels are not tested; integer branches on traced values may block differentiation for
  some knobs.
- Agreement with Geant4 is checked in the package tests; public comparison reports against NIST, ESTAR and PDG
  tables are documented in the repository as they are completed.
