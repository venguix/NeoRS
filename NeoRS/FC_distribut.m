function [] = FC_distribut(subject)

filename=([subject '/Output_files/final_BOLD.nii.gz']);
mask_path=([subject '/Output_files/bold_mask_1.nii.gz']);

nii=load_nii(filename);
mask=load_nii(mask_path);

mask2=mask.img;
img=nii.img;


a=reshape(img, 48*64*48, []);
data=a;
data( ~any(data,2), : ) = [];  %delete rows with value 0

%%
data2=data;
data3=data;

%%
for i=1:25
X = randi(size(data2,1),2000);
Y = randi(size(data3,1),2000);
X1=X(:,1);
Y1=Y(:,1);
data2(X1,:)=[];
data3(Y1,:)=[];
end
%%
data2(10000:end,:)=[];
data3(10000:end,:)=[];
%%
[R,pval] = corr(data2',data3');
Rvec= diag (R);

%%
[a0,b0]=hist(Rvec,20);
x=b0;y=a0;
[mx loc]=max(a0);
center=b0(loc);


%%
f = fit(x.',y.','gauss2');
pd = fitdist(b0','Normal')
y2 = pdf(pd,b0');
hold on
plot(b0',y2,'LineWidth',2);title('High motion FC');xlabel('FC distribution (r)'),legend('off')



%%
%plot(f,x,y)
%hold on
%plot(f,x,y); title('High motion FC');xlabel('FC distribution (r)'),legend('off')

end