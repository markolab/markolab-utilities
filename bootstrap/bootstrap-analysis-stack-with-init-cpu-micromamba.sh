#!/bin/bash

# could write this to tmpdir...
ENV_URL="https://raw.githubusercontent.com/markolab/markolab-envs/main"
curl "${ENV_URL}/base.yml" -o ~/base.yml -s
curl "${ENV_URL}/datastack.yml" -o ~/datastack.yml -s
curl "${ENV_URL}/segmentation-cpu.yml" -o ~/segmentation-cpu.yml -s

sudo curl -Ls "https://micro.mamba.pm/api/micromamba/linux-64/latest" | tar -xvj bin/micromamba
sudo mv bin/micromamba /bin/
mkdir ~/micromamba
export MAMBA_ROOT_PREFIX=~/micromamba  # optional, defaults to ~/micromamba
eval "$(/bin/micromamba shell hook -s posix)" # now we should be good...

micromamba activate
micromamba install -f ~/base.yml -y
micromamba create -f ~/datastack.yml -y
micromamba create -f ~/segmentation-cpu.yml -y