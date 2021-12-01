function [FD,output,motion_detrended,position,mFD_all] = cross_realign2( subject,workingDir,options,RS,n)

mFD_all=[];

if options.slicetimingcorrection == 1
input=[subject '/Output_files/slc_' RS(n).name];
display('Coregistering slc BOLD ...')
else
 input=[subject '/Output_files/reoriented_' RS(n).name];  
end 
 

output=[subject '/Output_files/cross_realignRS'];


folder=[subject '/Output_files/Motion_Corrected_' num2str(n)];
mkdir('./',folder);

mcflirt_cmd=['mcflirt -in ' input ' -out ' output ' -sinc_final -mamotion_detrended -plomotion_detrended -refvol 0 -smooth 0'];%-smooth 1 by default
system(mcflirt_cmd)


system(['mv ' output '.mat ' subject '/Output_files/Motion_Corrected_' num2str(n) '/cross_realignRS.mat'])
system(['mv ' output '.par ' subject '/Output_files/Motion_Corrected_' num2str(n) '/cross_realignRS.par'])
system(['mv ' output '.nii.gz ' subject '/Output_files/Motion_Corrected_' num2str(n) '/cross_realignRS.nii.gz'])


cd(folder)
options.motionparameters='cross_realignRS.par';
[FD,motion_detrended]=framewiseDisplacement(options)
save('FD_power.1D','FD','-ascii')
save('cross_realignRS_detrend.par','motion_detrended','-ascii')
mFD=mean(FD);
save('meanFD_power.1D','mFD','-ascii');

FD_maximum=max(FD); %variable F_max is for the maximum FD allowed (threshold)
save('maxFD.1D','FD_maximum','-ascii');

save('FD_vector.1D','FD','-ascii');


f = figure('visible','off');
subplot(3,1,1),hold on
plot(motion_detrended(:,1),'-b')
plot(motion_detrended(:,2),'-g')
plot(motion_detrended(:,3),'-r')
legend('x','y','z')
title('Estimated rotation (radians)')

subplot(3,1,2), hold on
plot(motion_detrended(:,4),'-b')
plot(motion_detrended(:,5),'-g')
plot(motion_detrended(:,6),'-r')
legend('x','y','z')
title('Estimated translation (mm)')

subplot(3,1,3),
plot(FD,'-b'),title('Framewise Displacement'),legend('FD')


% Number of frames with lower FD than 0.25 mm 
N=length(motion_detrended);
count=0;
position=[];

FD_max=options.FD_max;

for ii=1:N
  if FD(ii)>FD_max
      count=count+1;
      position(count)=ii;
  end 
end

save('bad_frames.1D','count','-ascii');

%Create motion censoring matrix
bad_frames=zeros(N,count+5);
bad_frames(1,1)=1;
bad_frames(2,2)=1;
bad_frames(3,3)=1;
bad_frames(4,4)=1;
bad_frames(5,5)=1;

for p=1:count
  pos=position(p);
  bad_frames(pos,p+5)=1;
end

filename=['outliers_' num2str(n) '.txt'];
dlmwrite(filename, bad_frames,'delimiter',' ')
time_good=count*options.TR;
total_time=N*options.TR;

fprintf(' Acquisition time = %d sec \n Total number of frames = %d \n Time of good frames = %d sec \n Number of bad frames = %d \n',total_time,N,time_good,count);
saveas(gcf,'FD.png')

cd (workingDir)
 
mFD_all(n)=mFD;

end

