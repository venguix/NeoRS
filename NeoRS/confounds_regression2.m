function [  ] = confounds_regression2( subject, workingDir,c,options,motion_censored_bold )

TR=options.TR;

motion_censored_bold=motion_censored_bold(1:end-7);

input=motion_censored_bold; %motion censoring before confounds reg FSL


%get mean
mean=([subject '/Output_files/mean_BOLD2.nii.gz']);
BOLD_mean_cmd=['fslmaths ' input ' -Tmean ' mean];
system(BOLD_mean_cmd)

%create time series txt files
csf_in=[subject '/Output_files/masks/CSF_mask.nii.gz']; % no Eroded
%csf_in=[subject '/Output_files/masks/CSF_mask_eroded.nii.gz'];
csf_out=[subject '/Output_files/csf.txt'];

wm_in=[subject '/Output_files/masks/WM_mask_eroded.nii.gz']; % Eroded
wm_out=[subject '/Output_files/wm.txt'];

global_in=[subject '/Output_files/masks/gm_mask.nii.gz'];
global_out=[subject '/Output_files/global.txt'];

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
out=[motion_folder 'motion.txt'];
unix(['1dcat ',motion_folder,'cross_realignRS_detrend.par > ' out]);
%12 motion parameters
Motion_Corrected=load([motion_folder,'cross_realignRS_detrend.par']);
derivative=Motion_Corrected(2:end,:)-Motion_Corrected(1:(end-1),:);
derivative1=cat(1,zeros(1,6),derivative);
parameters=[Motion_Corrected,derivative1];
save([motion_folder,'12_motion_parameters.txt'],'parameters','-ascii');
derivative=Motion_Corrected(2:end,:)-Motion_Corrected(1:(end-1),:);
derivative1=cat(1,zeros(1,6),derivative);
parameters=[Motion_Corrected,derivative1];
save([motion_folder,'12_motion_parameters.txt'],'parameters','-ascii');
%24 motion parameters
Motion_Corrected=load([motion_folder,'cross_realignRS_detrend.par']);
onetimebefore=cat(1,zeros(1,6),Motion_Corrected(1:(end-1),:));
parameters=[Motion_Corrected,onetimebefore,Motion_Corrected.^2,onetimebefore.^2];
save([motion_folder,'Friston24_motion_parameters.txt'],'parameters','-ascii');

% TIME SERIES FOLDER
path=([subject '/output_files/']);
cd(path)

confounders=['confounders'];
mkdir(confounders)

confounders2=['confounders/run' num2str(c)];
mkdir(confounders2)


a=dir('*.txt');
for j=1:length(a)
    movefile(a(j).name,confounders2);
end

cd(workingDir)

b1=[subject '/Output_files/Motion_Corrected_' num2str(c) '/Friston24_motion_parameters.txt'];
b2=[subject '/Output_files/Motion_Corrected_' num2str(c) '/12_motion_parameters.txt'];
b3=[subject '/Output_files/Motion_Corrected_' num2str(c) '/motion.txt'];

movefile(b1,[path '/' confounders2]);
movefile(b2,[path '/' confounders2]);
movefile(b3,[path '/' confounders2]);


% Create single txt file with all confounder vectors
cd(path)
cd(confounders2)
unix(['1dcat csf.txt wm.txt > csf_wm.txt']); %csf+wm
unix(['1dcat csf_wm.txt global.txt > csf_wm_global.txt']); %csf+wm+global signal
unix(['1dcat csf_wm_global.txt motion.txt > Total_6movement.txt']); %csf+wm+global+6 motion

unix(['1dcat global.txt motion.txt > global_motion.txt']); 
unix(['1dcat global.txt motion.txt csf.txt > no_wm.txt']);
unix(['1dcat csf_wm_global.txt 12_motion_parameters.txt > Total_12movement.txt']); %csf+wm+global+12 motion
unix(['1dcat csf_wm_global.txt Friston24_motion_parameters.txt > Total_24movement.txt']);%csf+wm+global+24 motion
cd(workingDir)

%Regression + BPF
%%%%%%%%% INPUT %%%%%%%%%%% 
reg_type='Total_24movement.txt';
%reg_type='Total_6movement.txt';
%reg_type='Total_12movement.txt';
%%%%%%%%%%%%%%%%%%%%%%%%%%%


bandpass=[0.01,0.1];
out2=[subject '/Output_files/filtered_BOLD_' num2str(c) '.nii.gz'];


%%%% FSL - MOTION CENSORING already performed %%%%%%%
path2=[path,confounders2 '/' reg_type]; %FSL motion censoring


%FSL regression
regression_cmd=['fsl_glm -i ' input ' -d ' path2 ' --out_res=' out2 ];
system(regression_cmd)

% BPF
BPF=[100/TR 10/TR];
BPF_cmd=['fslmaths ' out2 ' -bptf ' num2str(BPF(1)) ' ' num2str(BPF(2)) ' ' out2];
system(BPF_cmd)

%AFNI regression
command10=['3dTproject -ort ' path2 ' -prefix ' out2 ' -passband ',num2str(bandpass(1)),' ',num2str(bandpass(2)),' -input ',input,'.nii.gz'];
%unix(command10);

end

