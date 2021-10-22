function [ ] = SBC(subject,ROI)

input=[subject '/Output_files/final_BOLD'];
output=[subject '/Output_files/SBC'];
output_t=[output '/timeseries'];
ref=[subject '/Output_files/mean_BOLD2'];
mkdir(output)
mkdir(output_t)

for aa=1:31
seed=['vol' num2str(aa)]
%Extract timeseries of the seed
Extract_timeseries_cmd=['fslmeants -i ' input ' -o ' output_t filesep seed '_timecourse.txt -m ' ROI filesep seed '_bin'];
system(Extract_timeseries_cmd)
%SBC
ts=[output_t filesep seed '_timecourse.txt'];
[out]=SCA(ts,input,ref,seed,output);
end



end

