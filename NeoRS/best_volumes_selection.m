function [minmoysection,indice,section]=best_volumes_selection(FD,subject,nRS)

FD=load([subject '/Output_files/Motion_Corrected_1/FD_vector.1D']);

mult=ones(numel(FD),1);
section=100;
mult(section+1:end)=0;

meanFD_section=[];

i=1;
Moy=(mult.*FD);
Moy(Moy==0) = [];
meanSection=mean(Moy);
meanFD_section(i)=meanSection;

for i=2:numel(FD)-section+1
    mult(i-1)=0;
    mult(section+i-1)=1;
    
    Moy=(mult.*FD);
    Moy(Moy==0) = [];
    meanSection=mean(Moy);
    meanFD_section(i)=meanSection;
 
end

minmoysection=min(meanFD_section);%la meilleure des moyennes
indice = find(meanFD_section==minmoysection);%numero de la section
 fprintf('la meilleure des moyennes est %f, le numero de la section est %d', minmoysection,indice)

newFD=FD(indice:indice+section-1);

% Number of frames with lower FD than 0.25 mm (need +/-100)
N=length(newFD);
count=0;
position=[];

FD_max=0.25;

for ii=1:N
  if newFD(ii)>FD_max
      count=count+1;
      position(count)=ii;
  end 
end


%Create motion censoring matrix
bad_frames=zeros(N,count);


for p=1:count
  pos=position(p);
  bad_frames(pos,p)=1;
end

n=1;

%filename=([subject '/Output_files/Motion_Corrected_' num2str(n) '/New_outliers_' num2str(n) '.txt']);
filename=([subject '/Output_files/Motion_Corrected_' num2str(n) '/outliers_' num2str(n) '.txt']);
dlmwrite(filename, bad_frames,'delimiter',' ')

% Merge new Volumes

system(['mkdir ' subject '/Output_files/New_RS_aligned' num2str(n) ])

for c=indice:indice+section-1
in=[subject '/Output_files/RS_aligned' num2str(n) '/RS_' num2str(c) '.nii.gz'];  
out=[subject '/Output_files/New_RS_aligned' num2str(n) '/RS_' num2str(c) '.nii.gz']; 
cmd=['cp ' in ' ' out];
system(cmd)
end


%out=[subject '/Output_files/New_aligned_BOLD_' num2str(n) ];
out=[subject '/Output_files/aligned_BOLD_' num2str(n) ];
in=[subject '/Output_files/New_RS_aligned' num2str(n) '/RS_*'];
Merge_bold_cmd=['fslmerge -t ' out ' ' in];
system(Merge_bold_cmd)

%6 parameters motion new file
motion6=load([subject '/Output_files/Motion_Corrected_' num2str(n) '/cross_realignRS.par']);


New_motion=motion6;
New_motion(1:indice-1,:)=[];
New_motion(section+1:end,:)=[];


%filename2=([subject '/Output_files/Motion_Corrected_' num2str(n) '/New_cross_realignRS.par']);
filename2=([subject '/Output_files/Motion_Corrected_' num2str(n) '/cross_realignRS.par']);
dlmwrite(filename2, New_motion,'delimiter',' ')


























end