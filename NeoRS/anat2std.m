function [output_1mm] = anat2std( subject,atlas1mm,atlas3mm)


input=[subject '/Output_files/reoriented_T2'];
output_1mm=[subject '/Output_files/anat2std1'];

output=[subject '/Output_files/anat2std3'];

    
% T2 to Atlas (1x1x1 mm)
cmd=['flirt -in ' input  ' -ref ' atlas1mm ' -omat ' output_1mm '.mat -out ' output_1mm ' -dof 12  -noresampblur -noclamp'];
system(cmd)

% T2 to Atlas (3x3x3 mm)
cmd=['flirt -in ' output_1mm  ' -ref ' atlas3mm ' -omat ' output '.mat -out ' output ' -dof 12  -noresampblur -noclamp'];
system(cmd)



end

