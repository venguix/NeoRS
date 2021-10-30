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
 1. In the terminal: chmod a+x neors.sh
 2. Right click in the file neors.sh > open with > other > all applications > Terminal (always open with)
 3. Double click neors.sh to open matlab and the script

Note: to setup matlab to be easily opened via terminal:
1. nano .bash_profile
2. export PATH=/Applications/MATLAB_R2015a.app/bin/:$PATH  -> Use your Matlab path
3. Quit the bash_profile
4. Still in the terminal: source ~/.bash_profile

### 3. Before running the the pipeline, remember:

  - Data must be nifti format
  - Data must be in BIDS structure: https://bids.neuroimaging.io
 
              Data/  sub-xxx1/ anat/ sub-xxx1_T2w.nii
                               fmap/ sub-xxx1_task-rest_AP_run_001_bold.nii
                               func/ sub-xxx1_AP_se-epi.nii

  - Open main_neors.m and modify the INPUTS to adapt them to your data
  - You can now RUN Neors

## NeoRS workflow
![alt tag](https://github.com/venguix/NeoRS/blob/main/doc/workflow.png)

## Example final results
### Seed-Based Correlations
![alt tag](https://github.com/venguix/NeoRS/blob/main/doc/SBC_RSN.png)

