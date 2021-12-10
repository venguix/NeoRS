function [ ] = epi2std2(subject,old_nRS,options,badRuns)

for c=1:old_nRS 
    
  if badRuns(c) == 0
    if options.fmap == 1
    input=[subject '/Output_files/Unwarped_' num2str(c) '.nii.gz'];
    else
    input=[subject '/Output_files/Motion_Corrected_' num2str(c) '/cross_realignRS.nii.gz'];
    end

    mean=([subject '/Output_files/mean_BOLD' num2str(c) '.nii.gz']);
    BOLD_mean_cmd=['fslmaths ' input ' -Tmean ' mean];
    system(BOLD_mean_cmd)

    %Registration begins
    output=[subject '/Output_files/RS_aligned_mean' num2str(c)];
    output2=[subject '/Output_files/aligned_BOLD_' num2str(c)];
    reference=[subject '/Output_files/anat2std3']; %%ATLAS

    % BOLD to T2 (3x3x3)
    align_cmd=(['flirt -in ' mean ' -ref ' reference ' -omat ' output '.mat -out ' output ' -dof 12 -noresampblur ']);
    system(align_cmd) 
    display('meanBOLD aligned')

    align_cmd=(['flirt -in ' input  ' -ref ' reference '  -out ' output2 ' -init ' output '.mat -noresampblur -applyxfm ']);
    system(align_cmd)
    end
end



end

