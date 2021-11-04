function [badRuns,nRS,old_nRS] = remove_high_motion( subject,RS )

old_nRS=length(RS);

for a=1:length(RS)
mFD_all(a)=load([subject '/Output_files/Motion_Corrected_' num2str(a) '/meanFD_power.1D']);
end
    
badRuns = mFD_all > 0.25
RS(badRuns) = []
nRS=length(RS);






end