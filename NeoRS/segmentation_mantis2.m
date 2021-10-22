function [ ] = segmentation_mantis2(workingDir,subject)
%%
path2=([workingDir subject '/Segmentations/scT2.nii,1']);


%Mantis

matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'Structural scans';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {{path2}};
%matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {{'/Users/vicenteenguix/Desktop/canabis_bebes/sub-001/Segmentations/scT2.nii,1'}};
matlabbatch{2}.spm.tools.mantis.phasefolders.vols(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{3}.spm.tools.mantis.neonatetemplate = struct([]);
matlabbatch{4}.spm.tools.mantis.phase1.channel.vols(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{4}.spm.tools.mantis.phase1.channel.biasreg = 0.001;
matlabbatch{4}.spm.tools.mantis.phase1.channel.biasfwhm = 60;
matlabbatch{4}.spm.tools.mantis.phase1.channel.write = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(1).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 1', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{1}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(1).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(1).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(1).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(2).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 2', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{2}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(2).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(2).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(2).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(3).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 3', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{3}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(3).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(3).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(3).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(4).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 4', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{4}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(4).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(4).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(4).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(5).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 5', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{5}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(5).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(5).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(5).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(6).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 6', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{6}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(6).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(6).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(6).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(7).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 7', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{7}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(7).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(7).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(7).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(8).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 8', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{8}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(8).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(8).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(8).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(9).tpm(1) = cfg_dep('Path for all components of the neonate template: Neonate template channel 9', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{9}));
matlabbatch{4}.spm.tools.mantis.phase1.tissue(9).ngaus = 2;
matlabbatch{4}.spm.tools.mantis.phase1.tissue(9).native = [1 0];
matlabbatch{4}.spm.tools.mantis.phase1.tissue(9).warped = [0 0];
matlabbatch{4}.spm.tools.mantis.phase1.warp.mrf = 0;
matlabbatch{4}.spm.tools.mantis.phase1.warp.cleanup = 0;
matlabbatch{4}.spm.tools.mantis.phase1.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{4}.spm.tools.mantis.phase1.warp.affreg = 'mni';
matlabbatch{4}.spm.tools.mantis.phase1.warp.fwhm = 0;
matlabbatch{4}.spm.tools.mantis.phase1.warp.samp = 3;
matlabbatch{4}.spm.tools.mantis.phase1.warp.write = [1 1];
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Mantis: Phase 1 tissue classification: Seg Params', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','param', '()',{':'}));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{1}));
matlabbatch{6}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Mantis: Phase 1 tissue classification: c1 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{1}, '.','c', '()',{':'}));
matlabbatch{6}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{1}));
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Mantis: Phase 1 tissue classification: c3 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{3}, '.','c', '()',{':'}));
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{1}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Mantis: Phase 1 tissue classification: c2 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{2}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(2) = cfg_dep('Mantis: Phase 1 tissue classification: c4 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{4}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(3) = cfg_dep('Mantis: Phase 1 tissue classification: c5 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{5}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(4) = cfg_dep('Mantis: Phase 1 tissue classification: c6 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{6}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(5) = cfg_dep('Mantis: Phase 1 tissue classification: c7 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{7}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(6) = cfg_dep('Mantis: Phase 1 tissue classification: c8 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{8}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files(7) = cfg_dep('Mantis: Phase 1 tissue classification: c9 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{9}, '.','c', '()',{':'}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{1}));
matlabbatch{9}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Mantis: Phase 1 tissue classification: Forward Deformations', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{9}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{1}));
matlabbatch{10}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Mantis: Phase 1 tissue classification: Inverse Deformations', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','invdef', '()',{':'}));
matlabbatch{10}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{1}));
matlabbatch{11}.spm.tools.mantis.wscsf.vols(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{11}.spm.tools.mantis.wscsf.parent(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{':'}));
matlabbatch{11}.spm.tools.mantis.wscsf.target(1) = cfg_dep('Folders for phases - image files get placed here: Phase2 subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase2', '()',{':'}));
matlabbatch{12}.spm.tools.mantis.wmclean.vols(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{12}.spm.tools.mantis.wmclean.parent(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{':'}));
matlabbatch{12}.spm.tools.mantis.wmclean.target(1) = cfg_dep('Folders for phases - image files get placed here: Phase2 subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase2', '()',{':'}));
matlabbatch{13}.spm.tools.mantis.neonatefirstnorm = struct([]);
matlabbatch{14}.spm.tools.mantis.defs.def(1) = cfg_dep('Move/Delete Files: Moved/Copied Files', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.tools.mantis.defs.fnames(1) = cfg_dep('Path for all components of the neonate firstnorm: Neonate firstnorm', substruct('.','val', '{}',{13}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{':'}));
matlabbatch{14}.spm.tools.mantis.defs.saveusr(1) = cfg_dep('Folders for phases - image files get placed here: Phase2 single subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase2', '()',{1}));
matlabbatch{14}.spm.tools.mantis.defs.interp = 4;
matlabbatch{15}.spm.tools.mantis.maketpm.vols(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{15}.spm.tools.mantis.maketpm.parent(1) = cfg_dep('Folders for phases - image files get placed here: Phase1 subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase1', '()',{':'}));
matlabbatch{15}.spm.tools.mantis.maketpm.target(1) = cfg_dep('Folders for phases - image files get placed here: Phase2 subfolder', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outpathphase2', '()',{':'}));
% matlabbatch{16}.spm.tools.mantis.tissueclassif2.vols(1) = cfg_dep('Morphogical clean up of White matter: Clean up of white matter', substruct('.','val', '{}',{12}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','wmclean', '()',{':'}));
% matlabbatch{16}.spm.tools.mantis.tissueclassif2.tmaps(1) = cfg_dep('Make subject specific template: Subject template', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tissuemap', '()',{':'}));
% matlabbatch{17}.spm.tools.mantis.hardseg1.vols(1) = cfg_dep('Move/Delete Files: Moved/Copied Files', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
% matlabbatch{17}.spm.tools.mantis.hardseg1.structural(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
% matlabbatch{18}.spm.tools.mantis.hardseg2.vols(1) = cfg_dep('Final spm segmentation: Classification with patient specific template c1', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','patientspecifictemplateseg', '{}',{1}));
% matlabbatch{18}.spm.tools.mantis.hardseg2.structural(1) = cfg_dep('Named File Selector: Structural scans(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
% matlabbatch{18}.spm.tools.mantis.hardseg2.hardseg1(1) = cfg_dep('Hard segmentation of phase 1: Hard seg phase 1 - GM', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','hard1', '()',{':'}));


spm_jobman('run', matlabbatch);

end

