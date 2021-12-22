function [atlas1mm,atlas3mm, ROI ] = setup_neors()

warning off

neors_path=which('main_neors');
neors_path=neors_path(1:end-13);

% Load Atlas
% atlas=[neors_path '/atlases/atlases_st_louis/'];
% ROI=[neors_path '/atlases/ROI'];
atlas=[neors_path '/atlases2/'];
ROI=[neors_path '/atlases2/ROI3mm'];


%atlas1mm=[atlas 'term_N10_t2w_on_711-2N_111.nii.gz'];
%atlas3mm=[atlas 'term_N10_t2w_on_711-2N_333.nii.gz'];

atlas1mm=[atlas 'template_T2_44.nii'];
atlas3mm=[atlas 'template_T2_44_3mm.nii'];

end

