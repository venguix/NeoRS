function [ ] = smoothing( subject,c,FWHM )

input=[subject '/Output_files/filtered_BOLD_' num2str(c)];
output=[subject '/Output_files/smoothBOLD' num2str(c)];


%smoothing_cmd=['fslmaths ' input ' -s 4 ' output ];
smoothing_cmd=['fslmaths ' input ' -kernel gauss ' num2str(FWHM/2.3548) ' -fmean ' output ];
system(smoothing_cmd)

%The gaussian kernel takes its argument as sigma in mm instead of the FWHM
%divide your FWHM (in mm) by 2.3548 to get sigma


end
