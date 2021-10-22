function [] = reorient( subject,options,RS,n,T2 )


input_T2=[subject '/anat/' T2];
output_T2=[subject '/Output_files/reoriented_T2'];

reorient_t2_cmd=['fslreorient2std ' input_T2 ' ' output_T2];
system(reorient_t2_cmd)
display('T2 successfully reoriented')



for i=1:n
    
input_RS=[subject '/func/' RS(i).name];
output_RS=[subject '/Output_files/reoriented_' RS(i).name];

reorient_rs_cmd=['fslreorient2std ' input_RS ' ' output_RS];
system(reorient_rs_cmd)
display(['BOLD run ' num2str(i) ' successfully reoriented'])

end


 

 
end

