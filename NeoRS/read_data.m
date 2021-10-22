function [ data ] = read_data( )
% Read data
data = dir();
data(strncmp({data.name}, '.', 1)) = [];

for i=1:length(data)
new_dir=data(i).name;
mkdir([new_dir '/Output_files']) %create folder for outputs
end



end

