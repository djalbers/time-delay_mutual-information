% this is a script that estimates the TDMI, the inter-patient bias,
% and the intra-patient bias on a data file named
% glucose.data containing a population of individuals measured irregularly

%basic parameter settings
binning_style=1; %linear
number_of_bins=32; %for time 8 days, 4 bins per day
starting_file_number=1;

starting_file_id_TDMI=0.01; %file extention for the raw data binned
starting_file_id_INTRA_PATIENT_SHUFFLE=0.02; % file extension for
                                             % the intra-patient
                                             % shuffled data
starting_file_id_POPULATION_SHUFFLE=0.03; % file extension for the
                                          % inter-patient (i.e.,
                                          % population) shuffled data
include_entropy=1;
%max_time=691200; %8 days worth of seconds
max_time=11520; %8 days worth of minutes
                %max_time=14; %if =-1 then you set the max time to the maximum absolute time in the record
min_time=1; %was 0 %if =-1, then the min time is set to 1;
      
run_hist3=1; %to perform the histogram based calculation, set to 1
defNumber_of_bins_hist3=16;	
execution_path=pwd;
root_path=pwd;
nof=('/glucose.data');	
name_of_data_file=[root_path,nof];
home_directory=pwd;

%estimate the TDMI!
run_tdmi_basic(binning_style, number_of_bins, starting_file_number, starting_file_id_TDMI, starting_file_id_INTRA_PATIENT_SHUFFLE, starting_file_id_POPULATION_SHUFFLE, max_time, min_time, defNumber_of_bins_hist3, run_kde, run_hist3, execution_path, name_of_data_file, home_directory);






