function [output] = intensity_normalization( subject,c,RS )

input=[subject '/Output_files/reoriented_' RS(c).name];
mask=[subject '/Output_files/bold_mask_' num2str(c) '.nii.gz'];
output=[subject '/Output_files/BOLD1000_' num2str(c) '.nii.gz'];

cmd=(['fslmaths ' input  ' -mas ' mask ' -ing 1000 ' output]);

system(cmd)






end