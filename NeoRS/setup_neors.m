function [atlas1mm,atlas3mm, ROI ] = setup_neors()

warning off

neors_path=which('main_neors');
neors_path=neors_path(1:end-13);

% Load Atlas
% atlas=[neors_path '/atlases/atlases_st_louis/'];
% ROI=[neors_path '/atlases/ROI'];

atlas=[neors_path '/atlases3/'];
ROI=[neors_path '/atlases3/ROI'];

%atlas1mm=[atlas 'term_N10_t2w_on_711-2N_111.nii.gz']; %ST. LOUIS
%atlas3mm=[atlas 'term_N10_t2w_on_711-2N_333.nii.gz'];

atlas1mm=[atlas 'dhcp2tailarach_1.nii.gz']; %DHCP
atlas3mm=[atlas 'dhcp2tailarach_3.nii.gz'];

%atlas1mm=[atlas 'template_chusj.nii.gz']; %CHUSJ 
%atlas3mm=[atlas 'template_chusj_3mm.nii.gz'];



end

