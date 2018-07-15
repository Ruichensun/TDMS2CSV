%% Load data file and extract position data
%% Load data file and extract position data
clc
clear
close all

fPath = cd;
List = dir(fullfile(fPath, 'Processed*'));
List([List.isdir]) = [];
for i = 1:length(List)
    filename= List(i).name;
    
    try
        my_tdms_struct= TDMS_getStruct(filename);
    
    catch
        warning(['cannot open file: ',filename])
        continue
    end
          
    data_fly_position_interim = my_tdms_struct.Measured_Data.Fly_position.data;
    %data_fly_transient_speed_interim= my_tdms_struct.Measured_Data.Fly_transient_speed.data;
    data_laser_status_interim = my_tdms_struct.Measured_Data.Laser_status.data;
    %data_center_of_mass_interim = my_tdms_struct.Measured_Data.Center_of_mass.data;
    data_fly_position = transpose(data_fly_position_interim);
    %data_center_of_mass = transpose(data_center_of_mass_interim);
    data_laser_status = transpose(data_laser_status_interim);
    data = [data_fly_position,data_laser_status]; %,data_center_of_mass, data_laser_status];
    headers_interim = {'fly position','laser status'};%;'center of mass';'laser status'};
    headers = cellstr(headers_interim);
    new_filename = strrep(filename, '.tdms', '.csv');
    %generatedfilename = [new_filename '.csv'];
    %mypath='D:\Behavioral_project\Behavior Experiment Data\Analysis\YP_051617\analysis\Special_No_Stress';
    mypath='D:\Behavioral_project\Behavior Experiment Data\Sorted_data_experimenter\JD\Mutants\CSV';
    csvwrite_with_headers(fullfile(mypath,new_filename), data, headers)
end

