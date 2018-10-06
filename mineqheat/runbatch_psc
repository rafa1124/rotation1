#!/bin/bash
#SBATCH -N 16
#SBATCH --tasks-per-node=2
#SBATCH --cpus-per-task=14
#SBATCH -t 04:00:00
#SBATCH -p RM

#
set echo
set -x
# Load the needed modules
#This job is to be submitted to the RM or LM partitions.
#It corresponds to the highly scalable version of NAMD.
#If you wish to run on GPUs use the GPU version.
#To use this script you only need to change the number of 
#nodes you want to run at (SBATCH -N ). Leave the commnand line
# as is here, it has been optimized. 
#module load namd defaults to namd/2.12_cpu

module load namd
cd $SLURM_SUBMIT_DIR

mpirun -np $SLURM_NTASKS namd2 +ppn 12 +pemap 1-6,15-20,8-13,22-27 +commap 0,14,7,21 11heat.conf >& 11heat.log
