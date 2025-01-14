#!/bin/bash
#SBATCH -p short
#SBATCH --export=ALL
#SBATCH -N 1
#SBATCH -n 28
#SBATCH --exclusive
#SBATCH --job-name=matlab_testcase_3
#SBATCH --output=output/testcase_3.txt

mkdir -p output src

echo "========================================================"
echo "Job Name: matlab_testcase_3"
echo "Job ID: $SLURM_JOB_ID"
echo "Job Node: $(hostname)"
echo "Start Time: $(date)"
echo "========================================================"

echo "Step 1: Creating parallel test script"
cat << EOF > src/parallel_test.m
pool = parpool('local');
n = 1000;
A = distributed(rand(n));
B = distributed(rand(n));
tic
C = A * B;
time = toc;
fprintf('Parallel computation time: %f seconds\n', time);
delete(pool);
exit;
EOF

echo "Step 2: Running parallel test"
module load matlab/R2024b
matlab -nodisplay -nosplash -nodesktop -r "run('src/parallel_test.m')"

if [ $? -eq 0 ]; then
    echo "Step 2 Completed: Parallel computing test successful."
else
    echo "Step 2 Failed: Parallel computing test failed."
    echo "End Time: $(date)"
    exit 1
fi

echo "========================================================"
echo "Exiting Compute Node: $(hostname)"
echo "End Time: $(date)"
echo "========================================================"
