#!/bin/bash
# © Copyright 2024 INPE
# This software is licensed under the terms of the Apache Licence Version 2.0 which can be obtained at
# http://www.apache.org/licenses/LICENSE-2.0.
#
# environment set to run apps of JEDI-BUNDLE (release/skylab-v8) at EGEON
#

# This indicate where libraries from jedi-stack are installed 
export JEDI_OPT=/mnt/beegfs/jose.aravequia/opt-gnu

export CMAKE_PREFIX_PATH=/mnt/beegfs/jose.aravequia/opt-gnu/core/jedi-cmake
export jedi_cmake_ROOT=/mnt/beegfs/jose.aravequia/opt-gnu/core/jedi-cmake
# Set Compiler and MPI 
export JEDI_COMPILER=gnu9/9.4.0
export JEDI_MPI=openmpi4/4.1.1

## to make available the core modules :

module use $JEDI_OPT/modulefiles/core

# Load GNU compiler so this version is the first to be found (without is the system found 8.5.1 first)
#                                           To be sure use "gcc --version". It returns :
#                                           gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)
module purge
module load gnu9/9.4.0

export CC=/opt/ohpc/pub/compiler/gcc/9.4.0/bin/gcc
export CXX=/opt/ohpc/pub/compiler/gcc/9.4.0/bin/g++
export FC=/opt/ohpc/pub/compiler/gcc/9.4.0/bin/gfortran
export F77=/opt/ohpc/pub/compiler/gcc/9.4.0/bin/gfortran

## Load JEDI compiler and MPI modules 

module load jedi-gnu9/9.4.0
module load jedi-openmpi4/4.1.1

##   LOAD THE LIBRARIES MODULES

module load ecbuild/ecmwf-3.8.4 
module load cmake/3.20.0
module load szip/2.1.1    
module load udunits/2.2.28    
module load zlib/1.2.11
module load lapack/3.8.0  
module load boost-headers/1.68.0
module load eigen/3.3.7   
module load hdf5/1.12.0
module load netcdf/4.7.4 
module load nccmp/1.8.7.0 
module load nceplibs/fv3

## make MKL avail
source /opt/intel/oneapi/mkl/2022.1.0/env/vars.sh

###          skylab-v8  #  rel 2.0.0   >>  rel. 1.0.0   ##  skylab-v8
export ver_ec=1.24.4    #   1.23.0     ##  1.16.0       ##   1.24.4    
export ver_fc=0.11.0    #   0.9.5      ##  0.9.2        ##   0.11.0 
export ver_atlas=0.36.0 #   0.31.1     ##  0.24.1       ##   0.36.0

module load eckit/ecmwf-$ver_ec
module load fckit/ecmwf-$ver_fc
module load atlas/ecmwf-$ver_atlas 
module load cgal/5.0.4
module load fftw/3.3.8
export FFTW_INCLUDES=${FFTW_DIR}/include
export FFTW_LIBRARIES=${FFTW_DIR}/lib
module load bufr/noaa-emc-12.0.0 
module load pybind11/2.11.0 
module load gsl_lite/0.37.0  
module load pio/2.5.1-debug
module load json/3.9.1 json-schema-validator/2.1.0
module load odc/ecmwf-1.4.6

### Not sure that 3 lines below are needed (once MKL is available from OneAPI)
module load gmp/6.2.1
module load mpfr/4.2.1
module load lapack/3.8.0

module load git-lfs/2.11.0
module load ecflow/5.5.3

conda deactivate

### Python is used in ctest 
module load python-3.9.15-gcc-9.4.0-f466wuv

###
### User can adjust the 3 lines below to its case
export JEDI_ROOT=${HOME}/jedi
export JEDI_SRC=${JEDI_ROOT}/jedi-bundle   ## path to jedi-bundle (skylab-v8) was download from git
export JEDI_BUILD=${JEDI_ROOT}/build_jedi-bundle-gnu   ## path to build the JEDI-bundle package

ulimit -s unlimited
ulimit -v unlimited

export PIO_TYPENAME_VALID_VALUES=netcdf,netcdf4p,netcdf4c,pnetcdf;
export PIO_VERSION_MAJOR=2;

module load  esmf/v8.6.0
export ESMFMKFILE=${ESMF_ROOT}/lib/esmf.mk

module load  fms/jcsda-release-stable
### export fms_DIR=/mnt/beegfs/jose.aravequia/opt-gnu/gnu9-9.4.0/openmpi4-4.1.1/fms/jcsda-release-stable/lib64/cmake/fms
export fms_DIR=$FMS_ROOT/lib64/cmake/fms
export CGAL_DIR=$CGAL_ROOT                 # Path to directory containing CGALConfig.cmake
export Eigen3_DIR=$EIGEN3_PATH             # Path to directory containing Eigen3Config.cmake
export FFTW_PATH=$FFTW_DIR
export Qhull_DIR=${JEDI_OPT}/gnu9-9.4.0/openmpi4-4.1.1/qhull
## export nlohmann_json_DIR=/mnt/beegfs/jose.aravequia/opt/core/json/3.9.1/include/nlohmann
export nlohmann_json_DIR=${JEDI_OPT}/core/json/3.9.1/lib/cmake/nlohmann_json
export CODE=$JEDI_SRC
export BUILD=$JEDI_BUILD

GMP_DIR=${JEDI_OPT}/gnu9-9.4.0/gmp-6.2.1
export GMP_INC=$GMP_DIR/include
export GMP_LIB=$GMP_DIR/lib
export GMP_LIBRARIES=$GMP_LIB
export GMP_INCLUDE_DIR=$GMP_INC

## ecbuild will redirect URL downloads for coefficients and test-data to the local mirror (copy):
export ECBUILD_DOWNLOAD_BASE_URL=file:///mnt/beegfs/jose.aravequia/mirror-mpas-bundle

### The libraries created  building jedi-bundle must be accessible, then add it to LD_LIBRARY_PATH :
export LD_LIBRARY_PATH=${JEDI_BUILD}/lib:${LD_LIBRARY_PATH}

cd $JEDI_BUILD
## Run the tests that are built with mpas
## ctest
