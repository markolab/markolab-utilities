#!/bin/bash

# first argument is the installation directory
if [ ! -z "$1" ]; then
	INSTALLDIR=$1
else
	INSTALLDIR=${HOME}/miniconda3
fi

# get miniconda and install
UNAME_M="$(uname -m)" 
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${UNAME_M}.sh";
curl "${MINICONDA_URL}" -o ~/miniconda.sh -s
bash ~/miniconda.sh -b -p $INSTALLDIR

# could write this to tmpdir...
ENV_URL="https://raw.githubusercontent.com/markolab/markolab-envs/main"
curl "${ENV_URL}/base.yml" -o ~/base.yml -s
curl "${ENV_URL}/datastack.yml" -o ~/datastack.yml -s

source ${INSTALLDIR}/bin/activate
conda env update --file ~/base.yml --prune
conda env create -f ~/datastack.yml
conda init bash