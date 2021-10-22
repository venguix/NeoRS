function [  ] = corr_matrix( subject )

% input=[subject '/Output_files/SBC/timeseries/'];

% for i=1:31
% a(:,i)=load([input 'vol' num2str(i) '_timecourse.txt']);
% end
% 
% X=a;
% clims=[-0.5,0.5];
% Xlabelnames=[1:31];
% %Xlabelnames={'Language front.L','Language front.R','Language temp.L','Language temp.R','Motor MC.L','Motor MC.R','Motor SMA.L','Motor SMA.R','Visual V1.L','Visual V1.R','Visual VP.L','Visual VP.R','DMN MPFC','DMN PCC','DMN lat-parietal.L','DMN lat-parietal.R' ,'DMN lat-temporal.L','DMN lat-tamporal.R','DAN IPS.L','DAN IPS.R','DAN FEF.L' ,'DAN FEF-R' , 'VAN MPFC','VAN VFC.L','VAN VFC.R','VAN TPJ.L','VAN TPJ.R','FP parietal.L','FP parietal.R','FP lat-prefrontal.L','FP lat-prefrontal.R'};
% Ylabelnames={'Language front.L','Language front.R','Language temp.L','Language temp.R','Motor MC.L','Motor MC.R','Motor SMA.L','Motor SMA.R','Visual V1.L','Visual V1.R','Visual VP.L','Visual VP.R','DMN MPFC','DMN PCC','DMN lat-parietal.L','DMN lat-parietal.R' ,'DMN lat-temporal.L','DMN lat-tamporal.R','DAN IPS.L','DAN IPS.R','DAN FEF.L' ,'DAN FEF-R' , 'VAN MPFC','VAN VFC.L','VAN VFC.R','VAN TPJ.L','VAN TPJ.R','FP parietal.L','FP parietal.R','FP lat-prefrontal.L','FP lat-prefrontal.R'};
% 
% f = figure('visible','on');
% C=corrcoef(X);
% imagesc(C,clims),colormap jet,axis('square')
% colorbar
% set(gca, 'XTick', 1:1:31); % center x-axis ticks on bins
% set(gca, 'YTick', 1:1:31); % center y-axis ticks on bins
% set(gca, 'XTickLabel', Xlabelnames); % set x-axis labels
% set(gca, 'YTickLabel', Ylabelnames); % set y-axis labels
% title('Correlation Matrix', 'FontSize', 10); % set title


input=[subject '/Output_files/SBC/timeseries/'];

for i=1:31
a(:,i)=load([input 'vol' num2str(i) '_timecourse.txt']);
end

X=a;
clims=[-0.5,0.5];
myLabel={'Lan front.L','Lan front.R','Lan temp.L','Lan temp.R','Mot MC.L','Mot MC.R','Mot SMA.L','Mot SMA.R','Vis V1.L','Vis V1.R','Vis VP.L','Vis VP.R','DMN MPFC','DMN PCC','DMN LP.L','DMN LP.R' ,'DMN LT.L','DMN LT.R','DAN IPS.L','DAN IPS.R','DAN FEF.L' ,'DAN FEF-R' , 'VAN MPFC','VAN VFC.L','VAN VFC.R','VAN TPJ.L','VAN TPJ.R','FP Par.L','FP Par.R','FP L-pref.L','FP L-pref.R'};

f = figure('visible','on');
f.Position = [0 0 900 900];
C=corrcoef(X);
imagesc(C,clims),colormap jet,axis('square')
colorbar

tickvalues = 1:31;
x = zeros(size(tickvalues));
text(x, tickvalues, myLabel, 'HorizontalAlignment', 'right');
x(:) = length(C)+1;
text(tickvalues, x, myLabel, 'HorizontalAlignment', 'right','Rotation',60);

title('Correlation Matrix', 'FontSize', 12); % set title
axis off


saveas(gcf,[subject '/Output_files/Correlation_matrix.png'])



end

