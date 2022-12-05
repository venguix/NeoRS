function [brain_volume,pixel_x,pixel_y,pixel_z, output] = brain_volume_neors( subject )

input=[subject '/Output_files/reoriented_T2'];
output=[subject '/Output_files/brain_volT2'];



sk_cmd=['bet2 ' input ' ' output ' -o -m -r 35 -f 0.2 -w 1.5 '];% -m : generate brain mask
sk_cmd=system(sk_cmd)
%
input_mask=[output '_mask.nii.gz'];
gunzip(input_mask)
input_mask=[output '_mask.nii'];


mask = load_nii(input_mask);
mask_bin=mask.img;

%figure(1),imshow3D(mask_bin, [0 1], 106 )
pixel_x=mask.original.hdr.dime.pixdim(2);
pixel_y=mask.original.hdr.dime.pixdim(3);
pixel_z=mask.original.hdr.dime.pixdim(4);
%
mask_bin=mat2gray(mask_bin);
%figure(1),imshow3D(mask_bin, [0 1], 106 )
w = find(mask_bin==1);
w=length(w);
% brain volume (in mm3)
px_volume=pixel_x*pixel_y*pixel_z;
brain_volume=px_volume*w;
% brain volume (in dm3)
brain_volume=px_volume*w/1000000;

if brain_volume<=0.18 %27w
 display('Based on total brain volume the baby age is: <=27 weeks')
end

if brain_volume>0.18 && brain_volume<=0.25 %30w
 display('Based on total brain volume the baby age is: 28-30 weeks')
end

if brain_volume>0.25 && brain_volume<=0.35 %34w
 display('Based on total brain volume the baby age is: 31-34 weeks')
end

if brain_volume>0.35 && brain_volume<=0.5%38w
    display('Based on total brain volume the baby age is: 35-38 weeks')
end

if brain_volume>0.5%term
    display('Based on total brain volume the baby age is: term')
end



end

