function [ ] = fmap2(subject,RS,nRS,options,badRuns,old_nRS)

if options.fmap == 0
    display('Skipping Unwarping steps')
else
    
%Datain.txt
%for AP -> [0 -1 0 TotalReadoutTime]
%for PA -> [0 1 0 TotalReadoutTime]
fileName = dir([subject '/func/*.json']); % filename in JSON extension
fileName(strncmp({fileName.name}, '.', 1)) = [];% dedicated for reading files as text
file=[subject '/func/' fileName(1).name];

json_file = loadjson(file);

readout_time=json_file.TotalReadoutTime;

datain_file=[subject '/fmap/datain.txt'];
datain=[ 0 -1 0 readout_time; 0 1 0 readout_time];

dlmwrite(datain_file, datain,'delimiter',' ')

% 2.Split nii in 1 volume
in=dir([subject '/fmap/*nii*']);
in(strncmp({in.name}, '.', 1)) = [];

idx_AP = ~cellfun('isempty',strfind({in.name},'AP'));
idx_PA = ~cellfun('isempty',strfind({in.name},'PA'));

AP_index = find(idx_AP==1);
PA_index = find(idx_PA==1);


in_AP=[subject '/fmap/' in(AP_index(1)).name];
out_AP=[subject '/fmap/AP_1'];
cmd=['fslroi ' in_AP ' ' out_AP ' 0 1']; 
system(cmd)


in_PA=[subject '/fmap/' in(PA_index(1)).name];
out_PA=[subject '/fmap/PA_1'];
cmd=['fslroi ' in_PA ' ' out_PA ' 0 1']; 
system(cmd)


% 3.Merge in 1 file both blips
out_b0=[subject '/fmap/b0'];
cmd=['fslmerge -t ' out_b0 ' ' out_AP ' ' out_PA ];
system(cmd)

% 4. Topup
datain=[subject '/fmap/datain.txt'];
fout=[subject '/fmap/myfieldmap'];
iout=[subject '/fmap/se_epi_unwarped'];
cmd=['topup --imain=' out_b0 ' --datain=' datain ' --config=b02b0.cnf --fout=' fout ' --iout=' iout ];
system(cmd)

%AP
topup=[subject '/fmap/b0_results'];
%Añadir al nombre: b0_results_movpar.txt, b0_results_fieldcoef.nii.gz
name1=[subject '/fmap/b0_fieldcoef.nii.gz'];
name2=[subject '/fmap/b0_movpar.txt'];
newName1=[subject '/fmap/b0_results_fieldcoef.nii.gz'];
newName2=[subject '/fmap/b0_results_movpar.txt'];
cmd1=['cp ' name1 ' ' newName1 ];
cmd2=['cp ' name2 ' ' newName2 ];
system(cmd1)
system(cmd2)

for n=1:old_nRS
    if badRuns(n) == 0
    data_in=[subject '/Output_files/Motion_Corrected_' num2str(n) '/cross_realignRS.nii.gz'];
    data_out=[subject '/Output_files/Unwarped_' num2str(n)];

    if any(strfind(RS(n).name,'AP'))
    index=1
    else 
    index=2
    end

    cmd=['applytopup --imain=' data_in ' --inindex=' num2str(index) ' --datain=' datain ' --topup=' topup ' --out=' data_out ' --method=jac --interp=spline'];
    system(cmd)
    display(['Unwarped run ' num2str(n)])
    end


end

end

end

