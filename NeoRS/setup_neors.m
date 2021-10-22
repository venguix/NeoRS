function [atlas, ROI ] = setup_neors(neors_path)

warning off

% set FSL environment
setenv( 'FSLDIR', '/usr/local/fsl');
fsldir = getenv('FSLDIR');
fsldirmpath = sprintf('%s/etc/matlab',fsldir);
path(path, fsldirmpath);
clear fsldir fsldirmpath;

setenv('FSLOUTPUTTYPE', 'NIFTI_GZ'); 
nifti_tools_path=[neors_path '/NIfTI_20140122'];
addpath(nifti_tools_path)

% Load Atlas
atlas=[neors_path '/atlases/atlases_st_louis/'];
ROI=[neors_path '/atlases/ROI'];


end

