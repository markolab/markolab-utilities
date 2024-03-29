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
	OS_STRING="Linux"
elif [ "$OS" == "Darwin" ]; then
	OS_STRING="MacOSX"
else
	echo "Did not understand OS: $OS"
	exit 1
fi

# fall back to python 3.10, 3.11 not supported by pace's version of glibc
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py310-23.5.2-0-${OS_STRING}-${UNAME_M}.sh";
curl "${MINICONDA_URL}" -o ~/miniconda.sh -s
bash ~/miniconda.sh -b -p $INSTALLDIR

# could write this to tmpdir...
ENV_URL="https://raw.githubusercontent.com/markolab/markolab-envs/main"
curl "${ENV_URL}/base.yml" -o ~/base.yml -s
curl "${ENV_URL}/datastack.yml" -o ~/datastack.yml -s
curl "${ENV_URL}/segmentation-cpu.yml" -o ~/segmentation-cpu.yml -s

source ${INSTALLDIR}/bin/activate
conda env update --file ~/base.yml --prune
conda env create -f ~/datastack.yml
conda env create -f ~/segmentation-cpu.yml

# DO NOT ALTER BASHRC
# conda init bash 

# symlink at the activation script, easy to source post-login
ln -s ${INSTALLDIR}/bin/activate ${HOME}/conda_activate
