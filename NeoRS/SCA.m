function [out]=SCA(ts,D,ref,seed,output)

% Set up FSL environment
setenv( 'FSLDIR', '/usr/local/fsl');
fsldir = getenv('FSLDIR');
fsldirmpath = sprintf('%s/etc/matlab',fsldir);
path(path, fsldirmpath);
clear fsldir fsldirmpath;

% Load seed ROI timeseries:
T = load(ts);

% Load BOLD dataset:
[img,dims] = read_avw(D);
img = reshape(img,dims(1)*dims(2)*dims(3),dims(4));

% Perform correlation:
out = corr(T,img');
out = reshape(out',dims(1),dims(2),dims(3),1);
out(isnan(out)==1) = 0;

% Perform r to z transform:
out = 0.5*log((1+out)./(1-out));

% Save output image:
name=[output '/SCA_' seed ];
%save_avw(out,'SCA_result','f',[2 2 2 1])
save_avw(out,name,'f',[2 2 2 1])
ref_path=ref;
cmd=['/usr/local/fsl/bin/fslcpgeom ' ref_path ' ' name];
system(cmd)

%p-value from z-score ->VTE
p_one = 2*normcdf(out);
p_two = normcdf(out);