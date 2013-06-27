% this is a SCRIPT set up to define the variables to run the bin_data
% function

% to run bin_data, call:
%bin_data(binning_style, number_of_bins, 
%starting_file_number, file_type_id, include_entropy, min_time, max_time, 
%number_of_readings, patient_data, patient_times);

%function [binning_return]=bin_data(binning_style, number_of_bins, 
%starting_file_number, file_type_id, include_entropy, max_time, 
%number_of_readings, patient_data, patient_times);


% example function call:
%bin_data(1, 10, 1, 0.01, 1, ,48, number_of_readings, patient_data, patient_times)
% if the times are in hours
%bin_data(2, 10, 1, 0.01, 1, ,48, number_of_readings, patient_data,
%
%patient_times)
%binning_style=1;
%number_of_bins=3;
%starting_file_number=1;
%file_type_id=0.1;

%linear bins
binning_style=1;
number_of_bins=10;
starting_file_number=1;
file_type_id=0; %has to be zero if using histo technique, if using kde, doesn't matter
include_entropy=1;
max_time=14; %if =-1 then you set the max time to the maximum absolute time in the record 
min_time=0.25; %if =-1, then the min time is set to 1;
% note that the number_of_readings, patient_data, patient_times are all set
% up by load_data;

%log bins
binning_style=2;
number_of_bins=10;
starting_file_number=1;
file_type_id=0; %has to be zero if using histo technique, if using kde, doesn't matter
include_entropy=1;
max_time=14; %if =-1 then you set the max time to the maximum absolute time in the record 
min_time=0.25; %if =-1, then the min time is set to 1;
% note that the number_of_readings, patient_data, patient_times are all set
% up by load_data;


