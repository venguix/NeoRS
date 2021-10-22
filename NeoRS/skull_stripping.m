function [output] = skull_stripping( subject )

segmentations=[subject '/Segmentations'];
system(['mkdir ' segmentations])

input=[subject '/Output_files/anat2std1.nii.gz'];
output=[subject '/segmentations/scT2'];

 sk_cmd=['bet2 ' input ' ' output ' -o -m -r 70 -w 1.5'];% -m : generate brain mask 
 sk_cmd=system(sk_cmd)
 
 gunzip([subject '/segmentations/scT2.nii.gz'])
 system(['rm ' subject '/segmentations/scT2.nii.gz'])

end