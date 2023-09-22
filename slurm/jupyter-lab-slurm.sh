#!/bin/bash
# --job-name name of job
# -o output file
# --partition partition (i.e. queue)
# --ntasks number of tasks in job (split across nodes)
# --cpus-per-task (number of procs per task, set ntasks to 1 for 1 node)
# --mem memory
# --time walltime
# -A charge account
#SBATCH --job-name jupyterlab-markolab
#SBATCH -o slurm-%x-%j.out
#SBATCH --partition cpu-small
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=jmarkowitz30@gatech.edu
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 15
#SBATCH --mem 60GB
#SBATCH --time 2-00:00:00
#SBATCH -A gts-jmarkowitz30-paid
#SBATCH -q inferno

source ${HOME}/conda_activate # we symlinked this from conda/bin
#. ${HOME}/markolab-utilities/pace/shell/jupyter-lab-pace.sh # script that kicks off jupyter
. ${HOME}/bin/jupyter-lab-pace.sh
