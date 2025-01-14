#!/bin/bash
#SBATCH -p short
#SBATCH --export=ALL
#SBATCH -N 1
#SBATCH -n 28
#SBATCH --exclusive
#SBATCH --job-name=matlab_testcase_1
#SBATCH --output=output/testcase_1.txt

mkdir -p output src

echo "========================================================"
echo "Job Name: matlab_testcase_1"
echo "Job ID: $SLURM_JOB_ID"
echo "Job Node: $(hostname)"
echo "Start Time: $(date)"
echo "========================================================"

echo "Step 1: Loading MATLAB module and verifying version"
module load matlab/R2024b
matlab -nodisplay -nosplash -nodesktop -r "ver; exit" &> /dev/null

if [ $? -eq 0 ]; then
    echo "Step 1 Completed: MATLAB module loaded successfully."
    echo "MATLAB Version:"
    matlab -nodisplay -nosplash -nodesktop -r "ver; exit"
else
    echo "Step 1 Failed: Unable to load MATLAB module."
    echo "End Time: $(date)"
    exit 1
fi

echo "========================================================"
echo "Exiting Compute Node: $(hostname)"
echo "End Time: $(date)"
echo "========================================================"
