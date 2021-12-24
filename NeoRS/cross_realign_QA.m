
cd('/Users/vicenteenguix/Desktop/premasucre_test/sub-3361783/func')
input=['sub-3361783_AP_bold.nii'];  
output=['cross_realignRS'];
filename=['outliers_.txt'];%outliers
mFD_all=[];
%%

mcflirt_cmd=['mcflirt -in ' input ' -out ' output ' -sinc_final -refvol 0 -smooth 0 -plots'];%-smooth 1 by default
system(mcflirt_cmd)

%%
options.motionparameters='cross_realignRS.par';
[FD,motion_detrended]=framewiseDisplacement(options)
save('FD_power.1D','FD','-ascii')
save('cross_realignRS_detrend.par','motion_detrended','-ascii')
mFD=mean(FD);
save('meanFD_power.1D','mFD','-ascii');

FD_maximum=max(FD); %variable F_max is for the maximum FD allowed (threshold)
save('maxFD.1D','FD_maximum','-ascii');

save('FD_vector.1D','FD','-ascii');
%% plots

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
saveas(gcf,'FD.png')
