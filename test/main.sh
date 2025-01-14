#!/bin/bash

echo "Starting MATLAB module test cases..."

# Create directories if they don't exist
mkdir -p output src

# Submit all test cases
echo "Submitting test case 1 - Module loading test"
sbatch testcase1_matlab.sh

echo "Submitting test case 2 - Basic computation test"
sbatch testcase2_matlab.sh

echo "Submitting test case 3 - Parallel computing test"
sbatch testcase3_matlab.sh

echo "All test cases submitted. Check output directory for results."
