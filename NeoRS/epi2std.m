function [ ] = epi2std(subject, nRS,options)

for c=1:nRS 
    
    if options.fmap == 1
    input=[subject '/Output_files/Unwarped_' num2str(c) '.nii.gz'];
    else
    input=[subject '/Output_files/Motion_corrected_' num2str(c) '/cross_realignRS.nii.gz'];
    end

output=[subject '/Output_files/RS_splited' num2str(c)];

%split 4D nifti file into different volumes
folder_bold_split_cmd=['mkdir ' subject '/Output_files/RS_splited' num2str(c)];
system(folder_bold_split_cmd)

Split_bold_cmd=['fslsplit ' input ' '  output '/RS_'];
system(Split_bold_cmd)


%Registration begins
input2=[subject '/Output_files/RS_splited' num2str(c)];
output2=[subject '/Output_files/RS_aligned' num2str(c)];
reference=[subject '/Output_files/anat2std3'];

n=dir(input2);
n(strncmp({n.name}, '.', 1)) = [];

% BOLD to T2 (3x3x3)
folder_bold_aligned_cmd=['mkdir ' output2];
system(folder_bold_aligned_cmd)
 
tic
 parfor ii=1:length(n)
 align_cmd=(['flirt -in ' input2 filesep n(ii).name ' -ref ' reference '  -out ' output2 '/RS_' num2str(ii) ' -dof 12 -noresampblur']);
 system(align_cmd)
 end  
 toc
 
%Merge BOLD
out=[subject '/Output_files/aligned_BOLD_' num2str(c) ];
in=[subject '/Output_files/RS_aligned' num2str(c) '/RS_*'];
Merge_bold_cmd=['fslmerge -t ' out ' ' in];
system(Merge_bold_cmd)
 
end




end

