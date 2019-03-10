%% Load data file and extract position data
%% Load data file and extract position data
clc
clear
close all

fPath = cd;
List = dir(fullfile(fPath, 'Raw*'));
List([List.isdir]) = [];
filename= List.name;
my_tdms_struct= TDMS_getStruct(filename);

numfields = numel(fieldnames(my_tdms_struct.DifferenceFrame));
Arr = zeros(770,0);

names = fieldnames(my_tdms_struct.DifferenceFrame);
for n = 4:numfields
	temp_data = transpose(my_tdms_struct.DifferenceFrame.(names{n}).data);
    Arr = [Arr, temp_data];
end
headers = cellstr(names(4:numfields));
mypath = 'D:\Behavioral_project\behavior_experiment_data\Analysis\Special_No_Stress';
new_filename = strrep(filename, '.tdms', '.csv');
csvwrite_with_headers(fullfile(mypath,new_filename), Arr, headers)