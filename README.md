# env_for_jedi-bundle

## Environment for build jedi-bundle release/skylab-v8 at CPTEC's EGEON cluster

To set the environment to build and run JCSDA jedi-bundle release/skylab-v8 at CPTEC's EGEON cluster it was created these bash shell scripts.

The scripts have step by step steps to build and to run JCSDA jedi-bundle at CPTEC's EGEON cluster using libraries builded with GNU9 compiler, respectively, How_to_build_jedi-bundle-skylab-8.sh and environ_to_jedi-skylab-8.sh .

**Usually, you should use the JEDI apps in a processing node in queue or interactively (using sbatch in case of EGEON cluster).**

The environ_to_jedi-skylab-8.sh must run in the begining of your job submition script, or at the shell terminal if you are running in an interactive JOB, to provide the environment needed to run the applications. I

The jedi-bundle release/skylav-v8 can be downloaded from JCSDA git repository ( https://github.com/JCSDA/jedi-bundle ) with the commands:
```
cd $HOME
mkdir -p jedi && cd jedi
git clone -b release/skylab-v8 https://github.com/JCSDA/jedi-bundle.git jedi-bundle  
```

### Copy the script How_to_build_mpas-bundle-2.0.0.sh to $HOME/jedi.

To build jedi-bundle use:

```
source How_to_build_mpas-bundle-2.0.0.sh 
```

**This will take several hours, usually not less than 8 hours if you keep the How_to... script with 
```make -j8```  
Don´t use more than -j8 on the headnode to avoid slowdown the entire cluster.**  


## Libraries needed :
The libraries needed to build jedi-bundle are alread built with jedi-stack (https://github.com/JCSDA/jedi-stack) with adustments of versions and others sets needed at EGEON cluster. Those libraries are in directories of user __*jose.aravequia*__, but are open to every  EGEON cluster user. The libraries are loaded by module load by the shell scripts. 
