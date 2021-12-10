%% SETUP
clear all; clc
[atlas1mm,atlas3mm, ROI ] = setup_neors();
%% INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Activate or deactivate functions: 1=On; 0=Off
options.slicetimingcorrection=1; %Slice timing correction
options.fmap = 0; %Functional distortion correction

%Inputs definition
workingDir=('/Users/vicenteenguix/Desktop/premasucre_test'); % Path where data is located
options.TR=3;%Repetition time of the RS sequence in seconds
options.motion=12; %Number of motion parameters-> 6,12 or 24
options.slice_order=5; %1: bottom up, 2: top down, 3: interleaved+bottom up, 4: interleaved+top down, 5:automatically read json file
options.FWHM=6; %FWMH for functional gaussian smoothing
options.radius=35; %Head radius
options.FD_max=0.25; % Framewise displacement threshold
options.n_core=2; %Number of cores for parallel computing
%parpool(options.n_core);

cd (workingDir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RUN 
[data ] = read_data();
i=1;
%%
%for i=1:length(data)
   
    subject=data(i).name;
    
    % MANTIS preparation
    %T2=gunzip_T2(subject)
    [T2,nRS,RS] = gunzip_data(subject);

    %%
    % Data reorientation to standard
    reorient(subject,RS,nRS,T2)
    % Image Registration - Anatomical to Atlas
    [alignedT2] = anat2std( subject,atlas1mm,atlas3mm);
    % T2 skull stripping
    [scT2] = skull_stripping( subject )
    % Mantis segmentation
    try
        segmentation_mantis2(workingDir,subject); %Mantis segmentation (error in mac but still ok)
    end

    % align masks and binarize
    masks_alignment( subject )

    for n=1:nRS
        %Slice Timing Correction
        [slcRS]=slice_timing2(subject, options, RS,n );
    end

    for n=1:nRS
        %Cross realignment
        [FD,output,motion_detrended,position,mFD_all] = cross_realign2( subject,workingDir,options,RS,n);%  Frame displacement
    end

       % REMOVE RUNS WITH mean FD > 0.25 mm
       [badRuns,nRS,old_nRS] = remove_high_motion( subject,RS )
       
    if nRS > 0     
            % UNWARPING
            % -inindex: 1 for AP, 2 for PA
            fmap2(subject,RS,nRS,options,badRuns,old_nRS) %remember to put the "datain.txt" in the fmap folder if there is no json file
            % BOLD to template
            epi2std2(subject,old_nRS,options,badRuns)
            %epi2std(subject,old_nRS,options,badRuns)
        
            % DENOISING
            for n=1:old_nRS
                if badRuns(n) == 0
                %Create brain mask
                [ bold_mask ] = mask_functional( subject,n );
                % Whole brain mode value of 1000 - Normalization
                %[BOLD1000] = intensity_normalization( subject,c,motion_censored_bold );
                % Motion censoring
                [motion_censored_bold]=motion_censoring(subject,n);
                %confound regression
                confounds_regression( subject, workingDir,n,options,motion_censored_bold)
                %confounds_regression2( subject, workingDir,n,options,motion_censored_bold)
                % Spatial smoothing
                smoothing(subject,n,options);
                % Mask final bold
                [final_bold] = mask_final( subject,n );
                end
            end


        % MERGE ALL RUNS in a single file
        merge_bold_runs(subject,nRS)

        % Seed Based Correlation
        SBC(subject,ROI);

        %Correlation matrix
        corr_matrix( subject )

        % MERGE SEEDS
        merge_seeds( subject )
 
    else
        display('Subject data is not enough to be processed')
    end

%end