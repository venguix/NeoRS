function [atlas1mm,atlas3mm, ROI ] = setup_neors()

warning off

neors_path=which('main_neors');
neors_path=neors_path(1:end-13);

% Load Atlas
atlas=[neors_path '/atlases3/'];
ROI=[neors_path '/atlases3/ROI'];

atlas1mm=[atlas 'dhcp2tailarach_1.nii.gz'];
atlas3mm=[atlas 'dhcp2tailarach_3.nii.gz'];



end

