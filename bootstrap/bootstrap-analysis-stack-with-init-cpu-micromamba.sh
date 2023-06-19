#!/bin/bash

# could write this to tmpdir...
ENV_URL="https://raw.githubusercontent.com/markolab/markolab-envs/main"
curl "${ENV_URL}/base.yml" -o ~/base.yml -s
curl "${ENV_URL}/datastack.yml" -o ~/datastack.yml -s
curl "${ENV_URL}/segmentation-cpu.yml" -o ~/segmentation-cpu.yml -s

export MAMBA_ROOT_PREFIX=~/micromamba  # optional, defaults to ~/micromamba
eval "$(./bin/micromamba shell hook -s posix)"

micromamba activate
micromamba install -f ~/base.yml -y
micromamba create -f ~/datastack.yml -y
micromamba create -f ~/segmentation-cpu.yml -y