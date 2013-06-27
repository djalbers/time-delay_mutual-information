%need to: set number of bins for the hist3, set all the variables, set the

run_kde=1; %to preform the KDE calculation, set to 1
run_hist3=1; %to perform the histogram based calculation, set to 1

% bin-data settings
%linear bins
binning_style=1;
number_of_bins=32; 
starting_file_number=1;
%file_type_id=1;
starting_file_id_TDMI=0.01;
starting_file_id_INTRA_PATIENT_SHUFFLE=0.02;
starting_file_id_POPULATION_SHUFFLE=0.03;
include_entropy=1;
max_time=691200;
%max_time=14; %if =-1 then you set the max time to the maximum absolute time in the record 
min_time=1; %was 0
%min_time=0.25; %if =-1, then the min time is set to 1;
% note that the number_of_readings, patient_data, patient_times are all set
% up by load_data;

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

%let's do 8 days, 4 bins a day, 691200 seconds in 8 days,
%bin_data(1, 32, 1, 0.01, 1, 1, 691200, number_of_readings, patient_data, patient_times);

%main_bias settings: only number_of_delays and starting_file_number 
defNumber_of_delays=10; % normally this should be set to the number_of_bins
defStarting_file_number_TDMI=0.01;
defStarting_file_id_INTRA_PATIENT_SHUFFLE=0.02;
defStarting_file_id_POPULATION_SHUFFLE=0.03;
defNumber_of_bins_hist3=16;

data_file_name='aggregated_patient_file.data';
load_data;
%in the regular data
%bin_data(1, 10, 1, 0.01, 1, 0, 10, number_of_readings, patient_data, patient_times);
%bin_data(binning_style, number_of_bins, starting_file_number, file_type_id, include_entropy, min_time, max_time, number_of_readings, patient_data, patient_times);
bin_data(binning_style, number_of_bins, starting_file_number, starting_file_id_TDMI, include_entropy, min_time, max_time, number_of_readings, patient_data, patient_times);
shuffle_patient_data;
% bin the INTRA-PATIENT SHUFFLED data
bin_data(binning_style, number_of_bins, starting_file_number, starting_file_id_INTRA_PATIENT_SHUFFLE, include_entropy, min_time, max_time, number_of_readings, patient_data_shuffled, patient_times);
%bin_data(1, 10, 1, 0.02, 1, 0, 10, number_of_readings, patient_data_shuffled, patient_times);
% bin the INTER-POPULATION shuffled data
bin_data(binning_style, number_of_bins, starting_file_number, starting_file_id_POPULATION_SHUFFLE, include_entropy, min_time, max_time, number_of_readings, patient_population_data_shuffled, patient_times);
%bin_data(1, 10, 1, 0.03, 1, 0, 10, number_of_readings, patient_population_data_shuffled, patient_times);
%run the TDMI estimator
if(run_kde==1)
    main_bias_estimate_KDE;
end;
if(run_hist3==1)
    main_bias_estimate_hist3;
end;
%average the bias estimates
average_BIAS;
create_bias_free_TDMI;
