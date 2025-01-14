#!/bin/bash
#SBATCH -p short
#SBATCH --export=ALL
#SBATCH -N 1
#SBATCH -n 28
#SBATCH --exclusive
#SBATCH --job-name=matlab_testcase_2
#SBATCH --output=output/testcase_2.txt

mkdir -p output src

echo "========================================================"
echo "Job Name: matlab_testcase_2"
echo "Job ID: $SLURM_JOB_ID"
echo "Job Node: $(hostname)"
echo "Start Time: $(date)"
echo "========================================================"

echo "Step 1: Creating test MATLAB script"
cat << EOF > src/test_computation.m
n = 5000;
A = rand(n);
B = rand(n);
tic
C = A * B;
time = toc;
fprintf('Matrix multiplication time: %f seconds\n', time);
exit;
EOF

echo "Step 2: Running computation test"
module load matlab/R2024b
matlab -nodisplay -nosplash -nodesktop -r "run('src/test_computation.m')"

if [ $? -eq 0 ]; then
    echo "Step 2 Completed: Basic computation test successful."
else
    echo "Step 2 Failed: Basic computation test failed."
    echo "End Time: $(date)"
    exit 1
fi

echo "========================================================"
echo "Exiting Compute Node: $(hostname)"
echo "End Time: $(date)"
echo "========================================================"
