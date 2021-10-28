# NeoRS: Neonatal resting state fMRI preprocessing toolbox

Allows spatial normalization, skull stripping, T2w segmentation, functional cross-realignment, slice timing correction, unwarping, functional denoising and 1st level analysis based on seeds.


## Installation 
### NeoRS has been developed for Mac or Linux 

#### 1. Before using NeoRS you need to install:
	· FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/MacOsX
	· SPM12: https://www.fil.ion.ucl.ac.uk/spm/software/download/ 
	· Mantis: http://developmentalimagingmcri.github.io/mantis/installation/
	· AFNI: https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/steps_mac.html

#### 2. The easiest way to setup the environment is by launching Matlab from your terminal every time you want to use NeoRS.
To do it easily, we have created a shell script:
 - Open the file neors.sh and change to path where Matlab app and NeoRS are located -> save the file
 - Right click in the file neors.sh > open with > other > all applications > Terminal (always open with)
 - You launch Matlab with the NeoRS script opened by just double-clicking in the file neors.sh
Note: you can move this file to your desktop for example

Now you are ready to use the toolbox.

Before running the first baby remember that

  - Data must be nifti format
  - Data must be in BIDS structure: https://bids.neuroimaging.io
 
              Data/  sub-xxx1/ anat/ sub-xxx1_T2w.nii
                               fmap/ sub-xxx1_task-rest_AP_run_001_bold.nii
                               func/ sub-xxx1_AP_se-epi.nii
 

## Setting up NeoRS
 - Put the atlases folder inside the NeoRS folder
 - In the main NeoRS script called main_neors.m you need to set the path where NeoRS folder is located (this only needs to be changed once)
 - Then, every time you want to process a different dataset the path where the data is located needs to be modified in the variable workingDir
(i.e. ('/Volumes/TOSHIBA_HD/BCP_babies_processed_4/');
- In the INPUTS section of the script you can modify the variables to adjust them to your data
- You can then run the RUN section of the pipeline 

## NeoRS workflow
![alt tag](https://github.com/venguix/NeoRS/blob/main/doc/workflow.png)
