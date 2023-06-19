#!/bin/bash

# first argument is the installation directory
if [ ! -z "$1" ]; then
	INSTALLDIR=$1
else
	INSTALLDIR=${HOME}/miniconda3
fi

# get miniconda and install
UNAME_M="$(uname -m)" 
OS="$(uname)"

if [ "$OS" == "Linux" ]; then
	curl micro.mamba.pm/install.sh | bash
	~/.local/bin/micromamba shell init -s bash -p ~/micromamba
	source ~/.bashrc
elif [ "$OS" == "Darwin" ]; then
	curl micro.mamba.pm/install.sh | zsh
	./micromamba shell init -s zsh -p ~/micromamba
	source ~/.zshrc
else
	echo "Did not understand OS: $OS"
	exit 1
fi

# could write this to tmpdir...
ENV_URL="https://raw.githubusercontent.com/markolab/markolab-envs/main"
curl "${ENV_URL}/base.yml" -o ~/base.yml -s
curl "${ENV_URL}/datastack.yml" -o ~/datastack.yml -s
curl "${ENV_URL}/segmentation-cpu.yml" -o ~/segmentation-cpu.yml -s

# export MAMBA_ROOT_PREFIX=~/micromamba  # optional, defaults to ~/micromamba
# eval "$(./bin/micromamba shell hook -s posix)"

micromamba activate
micromamba install -f ~/base.yml -y
micromamba create -f ~/datastack.yml
micromamba create -f ~/segmentation-cpu.yml