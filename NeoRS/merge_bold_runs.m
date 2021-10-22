function [] = merge_bold_runs(subject,nRS)

processed=dir([subject '/Output_files/final_BOLD*']);
c=size(processed,1);
%If  not working maybe need to add .nii.gz at the end of each output

if c == nRS
   display('All runs were successfully processed')
 if nRS == 1
  cmd=(['mv ' subject '/Output_files/final_BOLD1.nii.gz ' subject '/Output_files/final_BOLD.nii.gz']);
  system(cmd)
  display(['Total number of runs ' num2str(nRS)])
 end

 if nRS > 1
    
      display(['Total number of runs ' num2str(nRS)])
      in1=[subject '/Output_files/final_BOLD1'];
      in2=[subject '/Output_files/final_BOLD2'];
      out=[subject '/Output_files/final_BOLD'];

      Merge_bold_cmd=['fslmerge -t ' out ' ' in1 ' ' in2];
      system(Merge_bold_cmd)
 end
      
 if nRS > 2
    display('Running merging step 2')
    
    for n=3:nRS
    in3=[subject '/Output_files/final_BOLD' num2str(n)];
    Merge_bold_cmd=['fslmerge -t ' out ' ' out ' ' in3];
    system(Merge_bold_cmd)
    end
     
 end
 
else
  display('Few runs were used')  
  if c == 1
    cmd=(['mv ' subject '/Output_files/' processed(1).name ' ' subject '/Output_files/final_BOLD.nii.gz']);
     system(cmd)
     display(['Total number of valid runs ' num2str(c)])
  end
   
  if c > 1
    
      display(['Total number of valid runs ' num2str(c)])
      in1=[subject '/Output_files/' processed(1).name];
      in2=[subject '/Output_files/' processed(2).name];
      out=[subject '/Output_files/final_BOLD'];

      Merge_bold_cmd=['fslmerge -t ' out ' ' in1 ' ' in2];
      system(Merge_bold_cmd)
  end
   
  if c > 2
    display('Running merging step 2')
    
    for n=3:c
    in3=[subject '/Output_files/' processed(n).name];
    Merge_bold_cmd=['fslmerge -t ' out ' ' out ' ' in3];
    system(Merge_bold_cmd)
    end
     
  end
    






end

