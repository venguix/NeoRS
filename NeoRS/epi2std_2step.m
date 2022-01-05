function [ ] = epi2std_2step(subject,old_nRS,options,badRuns,T2)

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

   
    reference1=([subject '/anat/' T2]);
    %Registration 3mm begins
    output=[subject '/Output_files/RS_aligned_mean' num2str(c)];
    output2=[subject '/Output_files/aligned_BOLD_' num2str(c)];
    reference=[subject '/Output_files/anat2std3']; %%ATLAS
    
    
    % BOLD to T2 (to raw T2w)
    align_cmd=(['flirt -in ' mean ' -ref ' reference1 ' -omat ' output '.mat -dof 6 -noresampblur']);
    system(align_cmd) 
    
    align_cmd=(['flirt -in ' input  ' -ref ' reference1 '  -out ' output2 ' -init ' output '.mat -applyxfm -noresampblur']);%-noresampblur
    system(align_cmd)
 
    
    % BOLD to T2 (3x3x3)
    align_cmd=(['flirt -in ' output2  ' -ref ' reference '  -out ' output2 ' -init ' output '.mat -applyxfm ']);%-noresampblur
    system(align_cmd)
    end
end



end

