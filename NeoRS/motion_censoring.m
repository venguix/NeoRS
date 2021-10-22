function [out] = motion_censoring( subject,a)

input=[subject '/Output_files/aligned_BOLD_' num2str(a)];
%input=BOLD1000;

%Regression of motion outliers FSL
in=([subject '/Output_files/Motion_Corrected_' num2str(a) '/outliers_' num2str(a) '.txt' ]);
out=([subject '/Output_files/motion_censored_RS_' num2str(a) '.nii.gz']);
cmd2=(['fsl_glm -i ' input ' -d ' in ' --out_res=' out]);
system(cmd2)

end

