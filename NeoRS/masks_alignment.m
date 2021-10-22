function [  ] = masks_alignment( subject )

output=[subject '/Output_files/masks'];
mkdir(output)

reference=[subject '/Output_files/anat2std3'];

masks=dir([subject '/Segmentations/Phase1/c*']);

input1=[subject '/Segmentations/Phase1/' masks(1).name];
input2=[subject '/Segmentations/Phase1/' masks(2).name];
input3=[subject '/Segmentations/Phase1/' masks(3).name];
input4=[subject '/Segmentations/Phase1/' masks(4).name];
input5=[subject '/Segmentations/Phase1/' masks(5).name];
input6=[subject '/Segmentations/Phase1/' masks(6).name];


 align_cmd=(['flirt -in ' input3  ' -ref ' reference '  -out ' output '/CSF_prob.nii  -init ' reference '.mat -applyxfm ']);
 system(align_cmd)
 align_cmd=(['flirt -in ' input2  ' -ref ' reference '  -out ' output '/WM_prob.nii  -init ' reference '.mat -applyxfm ']);
 system(align_cmd)
 align_cmd=(['flirt -in ' input1  ' -ref ' reference '  -out ' output '/Cortex_prob.nii  -init ' reference '.mat -applyxfm ']);
 system(align_cmd)

 align_cmd=(['flirt -in ' input4  ' -ref ' reference '  -out ' output '/gm1_prob.nii  -init ' reference '.mat -applyxfm ']);
 system(align_cmd)
 align_cmd=(['flirt -in ' input5  ' -ref ' reference '  -out ' output '/gm2_prob.nii  -init ' reference '.mat -applyxfm ']);
 system(align_cmd)
 align_cmd=(['flirt -in ' input6  ' -ref ' reference '  -out ' output '/gm3_prob.nii  -init ' reference '.mat -applyxfm ']);
 system(align_cmd)


%Binarization
binarize_cmd=['fslmaths ' output '/CSF_prob.nii -thr 0.5 -bin ' output '/CSF_mask'];
system(binarize_cmd)
binarize_cmd=['fslmaths ' output '/Cortex_prob.nii -thr 0.35 -bin ' output '/Cortex_mask'];%0,35
system(binarize_cmd)
binarize_cmd=['fslmaths ' output '/WM_prob.nii -thr 0.5 -bin ' output '/WM_mask'];
system(binarize_cmd)

binarize_cmd=['fslmaths ' output '/gm1_prob.nii -thr 0.7 -bin ' output '/gm1_mask'];%0,7
system(binarize_cmd)
binarize_cmd=['fslmaths ' output '/gm2_prob.nii -thr 0.7 -bin ' output '/gm2_mask'];%0,7
system(binarize_cmd)
binarize_cmd=['fslmaths ' output '/gm3_prob.nii -thr 0.7 -bin ' output '/gm3_mask'];%0,7
system(binarize_cmd)

%Total gray matter
cmd=['fslmaths ' output '/gm1_mask  -add ' output '/gm2_mask -bin ' output '/gm_mask'];
system(cmd)
cmd=['fslmaths ' output '/gm_mask  -add ' output '/gm3_mask -bin ' output '/gm_mask'];
system(cmd)
cmd=['fslmaths ' output '/gm_mask  -add ' output '/Cortex_mask -bin ' output '/gm_mask'];
system(cmd)

%inverse masks
binarize_cmd=['fslmaths ' output '/WM_prob.nii -thr 0.5 -binv ' output '/WM_mask_inv'];
system(binarize_cmd)
binarize_cmd=['fslmaths ' output '/CSF_prob.nii -thr 0.5 -binv ' output '/CSF_mask_inv'];
system(binarize_cmd)

%erode mask - 1 voxel erosion
cmd=['fslmaths ' output '/CSF_mask -kernel 3D -ero ' output '/CSF_mask_eroded'];
system(cmd)
cmd=['fslmaths ' output '/WM_mask -kernel 3D -ero ' output '/WM_mask_eroded'];
system(cmd)

display('Masks have been successfully created')


end

