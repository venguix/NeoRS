function [f1,nRS,RS] = gunzip_data(subject)


T2=dir([subject '/anat/*T2w.nii*']);
T2(strncmp({T2.name}, '.', 1)) = [];


[p1,f1,e1]=fileparts(T2.name);
try
gunzip([subject '/anat/' f1 '.nii.gz']) 
system(['rm ' subject '/anat/' f1 '.nii.gz'])
end
display('Uncompressed T2')

RS=dir([subject '/func/*bold.nii*']);
RS(strncmp({RS.name}, '.', 1)) = [];
nRS=length(RS);

for n=1:nRS
[p,f,e]=fileparts(RS(n).name);
try
gunzip([subject '/func/' f '.nii.gz'])
system(['rm ' subject '/func/' f '.nii.gz'])
end
display('Uncompressed BOLD')

end

end