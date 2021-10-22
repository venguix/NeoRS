function [T2] = gunzip_T2(subject)


T2=dir([subject '/anat/*T2w.nii.gz']);
T2_2=dir([subject '/anat/*T2w.nii']);
T2(strncmp({T2.name}, '.', 1)) = [];
T2_2(strncmp({T2_2.name}, '.', 1)) = [];

a=length(T2_2);

if a > 0
    display('T2 files already uncompressed')
    T2=T2_2.name(1:end-4);

else
    display('Uncompressing T2 file')
    T2=T2.name(1:end-7); 
    gunzip([subject '/anat/' T2 '.nii.gz']) 
    unix(['rm ' subject '/anat/' T2 '.nii.gz'])
end


end

