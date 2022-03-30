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
                               func/ sub-xxx1_task-rest_AP_run_001_bold.nii
                               fmap/ sub-xxx1_AP_se-epi.nii

  - Open main_neors.m and modify the INPUTS to adapt them to your data
  - You can now RUN Neors

## NeoRS workflow
[alt tag](https://github.com/venguix/NeoRS/blob/main/doc/workflow.png)

## Example final results
### Seed-Based Correlations
![alt tag](https://github.com/venguix/NeoRS/blob/main/doc/SBC_RSN.png)

## Data for testing purposes
https://drive.google.com/file/d/1gu7-GqO1x4nY50biMaGpfukvlgnWaGBw/view?usp=sharing

[Baby Connectome Project] Howell, B. R., Styner, M. A., Gao, W., Yap, P. T., Wang, L., Baluyot, K., . . . Elison, J. T. (2019). The UNC/UMN Baby Connectome Project (BCP): An overview of the study design and protocol development. Neuroimage, 185, 891-905. doi:10.1016/j.neuroimage.2018.03.049

if you plan to use the BCP data, please contact Dr. Elison (jtelison@umn.edu).

## Acknowledgements
We would like to thank Dr. C Smyser, Dr. J Neil and Dr. C Rogers from the Washington University – School of Medicine, for sharing their regions-of-interest for this project.

We would also like to thank Dr. J Elison for letting us use the neonatal data from the Baby Connectome Project.


#### If you used NeoRS in your research please make sure that you reference:

1. [NeoRS]

2. [Seeds] Smyser, C. D., Snyder, A. Z., Shimony, J. S., Mitra, A., Inder, T. E., & Neil, J. J. (2016). Resting-State Network Complexity and Magnitude Are Reduced in Prematurely Born Infants. Cereb Cortex, 26(1), 322-333. doi:10.1093/cercor/bhu251



