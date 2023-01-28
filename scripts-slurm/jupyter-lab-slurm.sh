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
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 10
#SBATCH --mem 50GB
#SBATCH --time 2-00:00:00
#SBATCH -A gts-jmarkowitz30

source ${HOME}/pace-scripts/conda_activate
. ${HOME}/pace-scripts/jupyter-lab-pace.sh
