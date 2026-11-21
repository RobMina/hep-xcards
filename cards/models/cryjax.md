---
xCard:
  card_type: model
  version: '0.1'

id: cryjax
name: cryjax (CRY 1.7 cosmic-ray showers on JAX)
description: >-
  Experiment-agnostic Python package that runs the LLNL CRY 1.7 cosmic-ray shower
  model on JAX devices (CPU or GPU) beside a C++ reference behind a small C ABI.
  It parses the official CRY release tables with SHA-256 checks, draws whole raw
  showers in one jitted program (primary energy and live time, multiplicity,
  species, energies, delays, angles, charges, lateral positions), and compares
  device versus native backends on independent shards with rate and spectrum
  ratios and per-bin tests. Raw showers only, in CRY's frame: detector projection,
  energy cuts and acceptance belong to the experiment. Fail-closed on unknown or
  malformed tables; explicit float32 and float64; reproducible per seed and shape.
  First user is Mu2e Geant4-free fast simulation; other HEP experiments may import
  the sampler the same way. Public Apache-2.0 package at github.com/RobMina/cryjax
  (CRY's own licence applies to CRY and reproduced parts).

science:
  - particle-physics
keywords:
  - cryjax
  - cry
  - cosmic ray showers
  - cosmic ray generator
  - jax
  - gpu simulation
  - experiment agnostic
  - fast simulation
  - high energy physics
  - genesis mission
  - open source
  - llnl cry
  - shower library
sensitivity: general
developed_by:
  - HEP Genesis tooling
version: '1.0.0'
last_updated: '2026-11-21'
license:
  spdx_id: Apache-2.0
  name: Apache License 2.0
  url: https://github.com/RobMina/cryjax
relationships:
  - type: compatible_with
    target: mu2e-crv-fastsim
    target_label: Mu2e CRV fast simulation (first experiment user)
  - type: compatible_with
    target: mu2e-tracker-fastsim
    target_label: Mu2e tracker fast simulation
  - type: compatible_with
    target: nova-fastsim
    target_label: NOvA ND fast simulation (cosmic path)

io_contract:
  input_modes:
    - application/octet-stream
    - application/json
  output_modes:
    - application/x-hdf5
    - application/json
  modalities:
    - tabular
    - simulation
  task_tags:
    - cosmic ray generation
    - shower sampling
    - device simulation

extension:
  kind: model
  architecture: >-
    CRY 1.7 tables loaded and checksummed in NumPy; one jitted JAX program draws
    raw showers on device; optional ctypes binding to a C++ CRY 1.7 shim for the
    native reference; comparison tools for device versus native on independent
    shards
  framework: JAX (GPU and CPU), NumPy, optional SciPy for compare
  base_model: ''
  training_datasets: []
  metrics: []
---

# cryjax (CRY 1.7 cosmic-ray showers on JAX)

Public, experiment-agnostic package for HEP fast simulation. Code:
[RobMina/cryjax](https://github.com/RobMina/cryjax). Apache-2.0 for the package; CRY's BSD-style licence and
DOE notice apply to CRY and to the parts that reproduce it. cryjax is not produced or endorsed by LLNL.

Archived on Zenodo: concept DOI [10.5281/zenodo.24418660](https://doi.org/10.5281/zenodo.24418660) (every version);
v0.1.1 is [10.5281/zenodo.24418661](https://doi.org/10.5281/zenodo.24418661).

## What it does

- Strict parser of the official CRY 1.7 release tables (admitted by SHA-256; tables are not redistributed).
- `DeviceSource` / `raw(...)`: whole raw showers on a JAX device in float32 or float64.
- `CrySource`: the C++ CRY 1.7 reference through a small C ABI shim.
- `cryjax.compare`: device versus native (or any two settings) on independent shards.

Both backends return showers in CRY's frame (metres, MeV, seconds). Experiment code owns projection onto a detector,
energy cuts and acceptance.

## Intended use

- Cosmic-ray primary generation for Geant4-free or hybrid fast simulations that need a device-side CRY sampler.
- Statistical agreement checks between the JAX device path and the C++ reference.

## Limitations and risks

- Raw showers only; not a full detector simulation.
- Device and C++ streams agree statistically, not bit for bit.
- Unknown tables, other subbox sizes, malformed contents and particle-pool overflow raise; nothing is clipped or
  replaced by a fallback.
- Some high-altitude CRY release tables contain negative PDF weights; cryjax refuses to build a CDF from those PDFs
  and documents which PDFs are affected.
