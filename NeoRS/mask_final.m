function [output] = mask_final( subject,c )

input=[subject '/Output_files/smoothBOLD' num2str(c)];
output=[subject '/Output_files/final_BOLD' num2str(c)];

mask=[subject '/Output_files/bold_mask_' num2str(c)];

mask_cmd=['fslmaths ' input ' -mas ' mask ' ' output];
system(mask_cmd)


end

