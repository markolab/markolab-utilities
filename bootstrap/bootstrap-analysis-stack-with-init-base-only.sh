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

MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-${OS_STRING}-${UNAME_M}.sh";
curl "${MINICONDA_URL}" -o ~/miniconda.sh -s
bash ~/miniconda.sh -b -p $INSTALLDIR

# could write this to tmpdir...
ENV_URL="https://raw.githubusercontent.com/markolab/markolab-envs/main"
curl "${ENV_URL}/base.yml" -o ~/base.yml -s

source ${INSTALLDIR}/bin/activate
conda env update --file ~/base.yml --prune
conda init bash 

# symlink at the activation script, easy to source post-login
# ln -s ${INSTALLDIR}/bin/activate ${HOME}/conda_activate
