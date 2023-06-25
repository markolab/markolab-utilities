#!/bin/bash

# first argument is the installation directory
if [ ! -z "$1" ]; then
	INSTALLDIR=$1
else
	INSTALLDIR=${HOME}/miniconda3
fi

if [ -z ${CUDA_VERSION_MAJOR} ]; then
	CUDA_VERSION_VERBOSE=$(cat /usr/local/cuda/version.json | jq -r '.["cuda"].version')
	CUDA_VERSION_MAJOR=$(echo ${CUDA_VERSION_VERBOSE} | cut -d. -f1)
	CUDA_VERSION_MINOR=$(echo ${CUDA_VERSION_VERBOSE} | cut -d. -f2)
	CUDA_VERSION=${CUDA_VERSION_MAJOR}.${CUDA_VERSION_MINOR}
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
curl "${ENV_URL}/datastack.yml" -o ~/datastack.yml -s
curl "${ENV_URL}/segmentation-cuda-${CUDA_VERSION_MAJOR}_${CUDA_VERSION_MINOR}.yml" -o ~/segmentation-cuda-${CUDA_VERSION_MAJOR}_${CUDA_VERSION_MINOR}.yml -s

source ${INSTALLDIR}/bin/activate
conda env update --file ~/base.yml --prune
conda env create -f ~/datastack.yml
conda env create -f ~/segmentation-cuda-${CUDA_VERSION_MAJOR}_${CUDA_VERSION_MINOR}.yml
conda init bash