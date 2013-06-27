% this is a script that runs the TDMI on a data file named
% glucose.data
% the setting are as per below and are adjustable.


root_path=pwd;
nof=('/glucose.data');	

name_of_data_file=[root_path,nof];
% bin-data settings
%linear bins
binning_style=1; %linear
number_of_bins=32; %for time 8 days, 4 bins per day
starting_file_number=1;
%file_type_id=1;
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

%function run_tdmi_basic(binning_style, number_of_bins, starting_file_number, starting_file_id_TDMI, ...
%starting_file_id_INTRA_PATIENT_SHUFFLE, starting_file_id_POPULATION_SHUFFLE, max_time, ...
% min_time, defNumber_of_bins_hist3, run_kde, run_hist3, execution_path, name_of_data_file, home_directory);

addpath ([execution_path, '/matlab_src']);

%data_file_name=[execution_path, '/', name_of_data_file];
data_file_name=name_of_data_file;

%log bins 
%binning_style=2;
%number_of_bins=10;
%starting_file_number=1;
%file_type_id=0; %has to be zero if using histo technique, if using kde, doesn't matter
%include_entropy=1;
%max_time=14; %if =-1 then you set the max time to the maximum absolute time in the record 
%min_time=0.25; %if =-1, then the min time is set to 1;
% note that the number_of_readings, patient_data, patient_times are all set
% up by load_data;

%%let's do 8 days, 4 bins a day, 691200 seconds in 8 days,
%%bin_data(1, 32, 1, 0.01, 1, 1, 691200, number_of_readings, patient_data, patient_times);

%%main_bias settings: only number_of_delays and starting_file_number 
defNumber_of_delays=number_of_bins; % normally this should be set to the number_of_bins
%defStarting_file_number_TDMI=0.01;
%defStarting_file_id_INTRA_PATIENT_SHUFFLE=0.02;
%defStarting_file_id_POPULATION_SHUFFLE=0.03;
defStarting_file_number_TDMI=starting_file_id_TDMI;
defStarting_file_id_INTRA_PATIENT_SHUFFLE=starting_file_id_INTRA_PATIENT_SHUFFLE;
defStarting_file_id_POPULATION_SHUFFLE=starting_file_id_POPULATION_SHUFFLE;
%defNumber_of_bins_hist3=16;

file_style=1;

load_data; %load the data

%bin the data for estimating the TDMI
bin_data(binning_style, number_of_bins, starting_file_number, starting_file_id_TDMI, include_entropy, ...
    min_time, max_time, number_of_readings, patient_data, patient_times, execution_path);
shuffle_patient_data;

% bin the INTRA-PATIENT SHUFFLED data
bin_data(binning_style, number_of_bins, starting_file_number, starting_file_id_INTRA_PATIENT_SHUFFLE, include_entropy, ...
    min_time, max_time, number_of_readings, patient_data_shuffled, patient_times, execution_path);

% bin the INTER-POPULATION shuffled data
bin_data(binning_style, number_of_bins, starting_file_number, starting_file_id_POPULATION_SHUFFLE, include_entropy, ...
    min_time, max_time, number_of_readings, patient_population_data_shuffled, patient_times, execution_path);

%run the TDMI estimator
if(run_hist3==1)
    main_bias_estimate_hist3;
end;
%average the bias estimates
average_BIAS;
create_bias_free_TDMI;




