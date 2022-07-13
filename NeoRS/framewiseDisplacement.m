function [FD,data_detrended]=framewiseDisplacement(options)
    
    motion = load(options.motionparameters);
    
    data=double(motion);
    data_detrended=detrend(data); %linear-demean; demean and detrend as per Power et al 2014

        radius=35;
        % radians into motion in mm
        r=data_detrended(:,1:3); % rotations columns 1,2,3
        r=radius*r;
        data_detrended(:,1:3)=r;

    d_data_detrended=diff(data_detrended);
    d_data_detrended=[zeros(1,size(d_data_detrended,2)); d_data_detrended];  % first element is a zero, as per Power et al 2014
    FD=sum(abs(d_data_detrended),2);
     
    
end
    
    