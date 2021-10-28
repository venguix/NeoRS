function [  ] = confounds_regression( subject, workingDir,c,options,motion_censored_bold )

TR=options.TR;

motion_censored_bold=motion_censored_bold(1:end-7);

input=motion_censored_bold; %motion censoring before confounds reg FSL
%input=[subject '/Output_files/aligned_BOLD_' num2str(c)];%motion censoring during confounds reg AFNI
% REMEMBER TO CHANGE VARIABLE path2 LINE 125

%get mean
mean=([subject '/Output_files/mean_BOLD2.nii.gz']);
BOLD_mean_cmd=['fslmaths ' input ' -Tmean ' mean];
system(BOLD_mean_cmd)

%create time series txt files
csf_in=[subject '/Output_files/masks/CSF_mask.nii.gz']; % no Eroded
%csf_in=[subject '/Output_files/masks/CSF_mask_eroded.nii.gz'];
csf_out=[subject '/Output_files/csf.1D'];

wm_in=[subject '/Output_files/masks/WM_mask_eroded.nii.gz']; % Eroded
wm_out=[subject '/Output_files/wm.1D'];

global_in=[subject '/Output_files/masks/gm_mask.nii.gz'];
global_out=[subject '/Output_files/global.1D'];

%csf
cmd=['3dmaskave -mask ' csf_in ' -quiet ',input,'.nii.gz > ' csf_out];
unix(cmd);
%wm
cmd=['3dmaskave -mask ' wm_in ' -quiet ',input,'.nii.gz > ' wm_out];
unix(cmd);
%global signal (GM)
cmd=['3dmaskave -mask ' global_in ' -quiet ',input,'.nii.gz > ' global_out];
unix(cmd);

%MOTION PARAMETERS
motion_folder=[subject '/Output_files/Motion_Corrected_' num2str(c) '/'];
%6 motion parameters
out=[motion_folder 'motion.1D'];
unix(['1dcat ',motion_folder,'cross_realignRS.par > ' out]);
%12 motion parameters
Motion_Corrected=load([motion_folder,'cross_realignRS.par']);
derivative=Motion_Corrected(2:end,:)-Motion_Corrected(1:(end-1),:);
derivative1=cat(1,zeros(1,6),derivative);
parameters=[Motion_Corrected,derivative1];
save([motion_folder,'12_motion_parameters.1D'],'parameters','-ascii');
derivative=Motion_Corrected(2:end,:)-Motion_Corrected(1:(end-1),:);
derivative1=cat(1,zeros(1,6),derivative);
parameters=[Motion_Corrected,derivative1];
save([motion_folder,'12_motion_parameters.1D'],'parameters','-ascii');
%24 motion parameters
Motion_Corrected=load([motion_folder,'cross_realignRS.par']);
onetimebefore=cat(1,zeros(1,6),Motion_Corrected(1:(end-1),:));
parameters=[Motion_Corrected,onetimebefore,Motion_Corrected.^2,onetimebefore.^2];
save([motion_folder,'Friston24_motion_parameters.1D'],'parameters','-ascii');

% TIME SERIES FOLDER
path=([subject '/output_files/']);
cd(path)

confounders=['confounders'];
mkdir(confounders)

confounders2=['confounders/run' num2str(c)];
mkdir(confounders2)


a=dir('*.1D');
for j=1:length(a)
    movefile(a(j).name,confounders2);
end

cd(workingDir)

b1=[subject '/Output_files/Motion_Corrected_' num2str(c) '/Friston24_motion_parameters.1D'];
b2=[subject '/Output_files/Motion_Corrected_' num2str(c) '/12_motion_parameters.1D'];
b3=[subject '/Output_files/Motion_Corrected_' num2str(c) '/motion.1D'];

movefile(b1,[path '/' confounders2]);
movefile(b2,[path '/' confounders2]);
movefile(b3,[path '/' confounders2]);


% Create single txt file with all confounder vectors
cd(path)
cd(confounders2)
unix(['1dcat csf.1D wm.1D > csf_wm.1D']); %csf+wm
unix(['1dcat csf_wm.1D global.1D > csf_wm_global.1D']); %csf+wm+global signal
unix(['1dcat csf_wm_global.1D motion.1D > Total_6movement.1D']); %csf+wm+global+6 motion

unix(['1dcat global.1D motion.1D > global_motion.1D']); 
unix(['1dcat global.1D motion.1D csf.1D > no_wm.1D']);
unix(['1dcat csf_wm_global.1D 12_motion_parameters.1D > Total_12movement.1D']); %csf+wm+global+12 motion
unix(['1dcat csf_wm_global.1D Friston24_motion_parameters.1D > Total_24movement.1D']);%csf+wm+global+24 motion
cd(workingDir)

%Regression + BPF
%%%%%%%%% INPUT %%%%%%%%%%% 
reg_type='Total_24movement.1D';
%reg_type='Total_6movement.1D';
%reg_type='Total_12movement.1D';
%%%%%%%%%%%%%%%%%%%%%%%%%%%


bandpass=[0.01,0.1];
out2=[subject '/Output_files/filtered_BOLD_' num2str(c) '.nii.gz'];


%%%% FSL - MOTION CENSORING already performed %%%%%%%
path2=[path,confounders2 '/' reg_type]; %FSL motion censoring


%command10=['3dTproject -ort ' path2 ' -prefix ' out2 ' -passband ',num2str(bandpass(1)),' ',num2str(bandpass(2)),' -input ',input,'.nii.gz -dt ' num2str(TR)];
command10=['3dTproject -ort ' path2 ' -prefix ' out2 ' -passband ',num2str(bandpass(1)),' ',num2str(bandpass(2)),' -input ',input,'.nii.gz'];
unix(command10);








end

