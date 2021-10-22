function vol = bramila_detrend(cfg)
% INPUT
cfg.detrend_type='linear-demean';
cfg.write = 0;

%   cfg.infile = location where the subject NII file (4D)
%   cfg.vol = input can be a 4D volume, if this exists, then infile is not loaded but used as ID (optional)
%   cfg.write = 0 (default 0, set to 1 if you want to store the volume)
%   cfg.detrend_type = type of detrend, default is 'linear-nodemean', others are: 'linear-demean', 'spline', 'polynomial-(no)demean'
%   cfg.TR = TR (mandatory if detrend spline is used)
% OUTPUT
%   vol = a 4D volume detrended

if(isfield(cfg,'vol'))
	data=cfg.vol;
	% add check that it's a 4D vol
elseif(isfield(cfg,'infile'))
	nii=load_nii(cfg.infile);
	data=nii.img;
end
data=double(data);
type='linear-nodemean';
if(isfield(cfg,'detrend_type'))
    type=cfg.detrend_type;
end
% resize the data into a 2-dim matrix, time in first dimension
kk=size(data);
if(length(kk)==4)
    T=kk(4);
    tempdata=reshape(data,[],T);
    tempdata=tempdata';
    fprintf('Detrending data...');
else
    T=kk(1);
    tempdata=data;
end
m=mean(tempdata,1);
switch type
    case 'linear-demean'
        tempdata=detrend(tempdata);
       
    case 'linear-nodemean'
        tempdata=detrend(tempdata);
        for row=1:T
            tempdata(row,:)=tempdata(row,:)+m;
        end
    case 'spline'
        error('not implememented')
        % add here code
    case   'polynomial-demean'
        tempdata=detrend_extended(tempdata,2);  
    case   'polynomial-nodemean'
        tempdata=detrend_extended(tempdata,2);
        for row=1:T
            tempdata(row,:)=tempdata(row,:)+m;
        end 
	case 'Savitzky-Golay'
		% see http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3929490/
		if(T*cfg.TR>=240) 
			SGlen=round(240/cfg.TR); 
		else
			SGlen=T; % if we have less than 4 minutes, let's use all the data
		end
		disp(['Performing Savitzky-Golay detrending over ' num2str(SGlen) ' timepoints']);
		
		if(mod(SGlen,2)==0) SGlen=SGlen-1; end % it needs to be odd
		trend=sgolayfilt(tempdata,3,SGlen);
		for v=1:size(tempdata,2) % foreach voxel
			if(var(trend(:,v))==0) continue; end
			[aa bb res]=regress(tempdata(:,v),[trend(:,v)  ones(T,1)]);
			tempdata(:,v)=res;
		end
		for row=1:T
            tempdata(row,:)=tempdata(row,:)+m;
        end		  
end
% resize the data back
if(length(kk)==4)
    tempdata=tempdata';
    vol=reshape(tempdata,kk);
    fprintf(' done\n');
else
    vol=tempdata;
    
end
if cfg.write==1 || nargout<1
    cfg.outfile=bramila_savevolume(cfg,vol,'EPI volume after detrending','mask_detrend.nii');
end
