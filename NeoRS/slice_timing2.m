function [output]=slice_timing2(subject, options, RS,n )

TR=num2str(options.TR);


input=[subject '/Output_files/reoriented_' RS(n).name];
output=[subject '/Output_files/slc_' RS(n).name];


if options.slicetimingcorrection == 1
    
    
    if options.slice_order==1
        disp('Slice order is bottom-up..')
        command=['slicetimer -i ',input,' -o ',output,' -r ',TR];
        system(command);
        display(['Successful slice timing correction option 1 Run ' num2str(n)])
    elseif options.slice_order==2
        disp('Slice order is top-down..')
        command=['slicetimer -i ',input,' -o ',output,' --down -r ',TR];
        system(command);
        display(['Successful slice timing correction option 2 Run ' num2str(n)])
    elseif options.slice_order==3
        disp('Slice order is interleaved and bottom up..')
        command=['slicetimer -i ',input,' -o ',output,' --odd -r ',TR];
        system(command);
        display(['Successful slice timing correction option 3 Run ' num2str(n)])
    elseif options.slice_order==4
        disp('Slice order is interleaved and top down..')
        command=['slicetimer -i ',input,' -o ',output,' --odd --down -r ',TR];
        system(command);
        display(['Successful slice timing correction option 4 Run ' num2str(n)])
    elseif options.slice_order==5 %custom
        slc_name=RS(n).name(1:end-4);%CORREGIR
        fileName = [subject '/func/' slc_name '.json']; % filename in JSON extension
        json_file = loadjson(fileName); % dedicated for reading files as text
        slicetiming=json_file.SliceTiming';
        slice_order=[subject '/func/slice_order.txt'];
        dlmwrite(slice_order, slicetiming,'delimiter',' ')
        command=['slicetimer -i ',input,' -o ',output,' -r ',TR,' --ocustom=',slice_order];
        system(command);
        display(['Successful slice timing correction option 5 Run ' num2str(n)])
    end
    
    

else
display(['Skipping slice timing correction run ' num2str(n)])
end

end

