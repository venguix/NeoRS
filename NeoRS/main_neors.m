%% INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Path where NeoRS folder is located
neors_path=('/Users/vicenteenguix/Documents/MATLAB/NeoRS');
addpath(neors_path)

workingDir=('/Users/vicenteenguix/Desktop/BCP_babies_processed_4/');

options.TR=0.8;%Repetition time of the RS sequence in seconds
options.motion=24;
options.slicetimingcorrection=1;
options.slice_order=5; %1: bottom up, 2: top down, 3: interleaved+bottom up, 4: interleaved+top down, 5:automatically read json file
options.sct=1;
options.resliceRS=0;
options.radius=35;
options.fmap = 1;
options.best_volumes = 0;
options.n_core=2;
FD_max=0.25;
mFD_all=[];
FWHM=6; %for functional gaussian smoothing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd (workingDir)
[atlas, ROI ] = setup_neors(neors_path);
[data ] = read_data( );

atlas1mm=[atlas 'term_N10_t2w_on_711-2N_111.nii.gz'];
atlas3mm=[atlas 'term_N10_t2w_on_711-2N_333.nii.gz'];

%options.n_core=1;
%parpool(options.n_core);
%% RUN 
for i=1:length(data)
   
    subject=data(i).name;
    RS=dir([subject '/func/*bold.nii*']);
    RS(strncmp({RS.name}, '.', 1)) = [];
    nRS=length(RS);

    T2=dir([subject '/anat/*T2w.nii*']);
    T2(strncmp({T2.name}, '.', 1)) = [];
    T2=T2.name(1:end-4);

    % MANTIS preparation
    gunzip_T2(subject)

    % Data reorientation to standard
    reorient(subject,options,RS,nRS,T2)
    % Image Registration - Anatomical to Atlas
    [alignedT2] = anat2std( subject,atlas1mm,atlas3mm);
    % T2 skull stripping
    [scT2] = skull_stripping( subject )
    % Mantis segmentation
    try
        segmentation_mantis2(workingDir,subject) %Mantis segmentation (error in mac but still ok)
    end

    % align masks and binarize
    masks_alignment( subject )

    for n=1:nRS
        %Slice Timing Correction
        [slcRS]=slice_timing2(subject, options, RS,n );
    end

    for n=1:nRS
        %Cross realignment
        [FD,output,ts,rms,position,mFD_all] = cross_realign2( subject,workingDir,options,RS,n, FD_max, mFD_all);%  Frame displacement
    end

    % REMOVE RUNS WITH mean FD > 0.25 mm
    rowsToDelete = mFD_all > 0.25
    RS(rowsToDelete) = []
    nRS=length(RS);

    if nRS > 0

        % UNWARPING
        % -inindex: 1 for AP, 2 for PA
        fmap2(subject,RS,nRS,options) %remember to put the "datain.txt" if there is no json file
        % BOLD to template
        epi2std(subject,nRS,options)

        %Best volumes selection
        if options.best_volumes == 1
            [minmoysection,indice,section]=best_volumes_selection(FD,subject,nRS)
        else
            display('Skipping best volumes selection')
        end

        % DENOISING
        for n=1:nRS
            %Create brain mask
            [ bold_mask ] = mask_functional( subject,n );
            % Whole brain mode value of 1000 - Normalization
            %[BOLD1000] = intensity_normalization( subject,c,motion_censored_bold );
            % Motion censoring
            [motion_censored_bold]=motion_censoring(subject,n);
            %confound regression
            confounds_regression( subject, workingDir,n,options,motion_censored_bold)
            % Spatial smoothing
            smoothing(subject,n,FWHM);
            % Mask final bold
            [final_bold] = mask_final( subject,n );
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

end