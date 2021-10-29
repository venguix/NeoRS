function [atlas1mm,atlas3mm, ROI ] = setup_neors()

warning off

neors_path=('/Users/vicenteenguix/Desktop/NeoRS/NeoRS');
addpath(genpath(neors_path));

% Load Atlas
atlas=[neors_path '/atlases/atlases_st_louis/'];
ROI=[neors_path '/atlases/ROI'];

atlas1mm=[atlas 'term_N10_t2w_on_711-2N_111.nii.gz'];
atlas3mm=[atlas 'term_N10_t2w_on_711-2N_333.nii.gz'];

end

