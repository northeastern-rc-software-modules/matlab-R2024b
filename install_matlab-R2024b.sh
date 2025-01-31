#!/bin/bash
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p rc
#SBATCH -w d0004
#SBATCH -t 8:00:00

# Setting up the environment
source env_matlab-R2024b.sh

# Creating the src directory for the installed application
mkdir -p $SOFTWARE_DIRECTORY

# Installing $SOFTWARE_NAME/$SOFTWARE_VERSION
# Installing MATLAB R2024b
cd $SOFTWARE_DIRECTORY
wget https://www.mathworks.com/mpm/glnxa64/mpm
chmod 775 mpm
cp $CURRENT_PATH/mpm_input_r2024b.txt .
./mpm install --inputfile mpm_input_r2024b.txt

# Creating modulefile
touch $SOFTWARE_VERSION
echo "#%Module" >> $SOFTWARE_VERSION
echo "module-whatis	 \"Loads $SOFTWARE_NAME/$SOFTWARE_VERSION module." >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "This module was built on $(date)" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "MATLAB (https://www.mathworks.com/) is a numerical computing suite." >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "The script used to build this module can be found here: $GITHUB_URL" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "To load the module, type:" >> $SOFTWARE_VERSION
echo "module load $SOFTWARE_NAME/$SOFTWARE_VERSION" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "\"" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "conflict	 $SOFTWARE_NAME" >> $SOFTWARE_VERSION
echo "prepend-path	 PATH $SOFTWARE_DIRECTORY/bin" >> $SOFTWARE_VERSION
echo "prepend-path       PATH $SOFTWARE_DIRECTORY/bin/glnxa64" >> $SOFTWARE_VERSION
echo "prepend-path       LD_LIBRARY_PATH $SOFTWARE_DIRECTORY/runtime/glnxa64" >> $SOFTWARE_VERSION
echo "prepend-path       LD_LIBRARY_PATH $SOFTWARE_DIRECTORY/bin/glnxa64" >> $SOFTWARE_VERSION
echo "module             add OpenJDK/22.0.2" >> $SOFTWARE_VERSION
echo "prepend-path       MLM_LICENSE_FILE $CLUSTER_DIRECTORY/$SOFTWARE_NAME/nunet.lic" >> $SOFTWARE_VERSION
echo "append-path        PATH $CLUSTER_DIRECTORY/$SOFTWARE_NAME/support_packages/matlab_parallel_server/bin" >> $SOFTWARE_VERSION
echo "prepend-path       MATLABPATH $CLUSTER_DIRECTORY/$SOFTWARE_NAME/support_packages/matlab_parallel_server/scripts" >> $SOFTWARE_VERSION
echo "prepend-path       MATLAB_CLUSTER_PROFILES_LOCATION $CLUSTER_DIRECTORY/$SOFTWARE_NAME/support_packages/matlab_parallel_server/scripts" >> $SOFTWARE_VERSION

# Moving modulefile
mkdir -p $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME
cp $SOFTWARE_VERSION $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME/$SOFTWARE_VERSION
cp $SOFTWARE_VERSION $CURRENT_PATH
