function [ out] = mask_functional( subject, a )

input=[subject '/Output_files/aligned_BOLD_' num2str(a)];
out=[subject '/Output_files/bold_mask_' num2str(a) '.nii.gz'];

cmd=(['3dAutomask -dilate 0 -prefix ' out ' ' input '.nii.gz']);
unix(cmd)



end

