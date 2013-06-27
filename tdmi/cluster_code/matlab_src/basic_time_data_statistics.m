% plot a histogram of all the patient data points in the loaded data as
% well as a histogram for the times --- and give a number characterizing
% the length of the record
number_of_bins_for_time_histo=50;
number_of_bins_for_data_histo=50;
number_of_bins_for_time_separation_histo=50;

%clear all the variables we define here!!!
clear time_separations_series;
clear time_separations;

min_times_for_histo=min(data(:,2));
times_for_histo=data(:,2)-min_times_for_histo;
time_histo=figure('Name', 'Histogram of times');
hist(times_for_histo, number_of_bins_for_time_histo);
total_time_of_ensemble_record=max(data(:,2)) - min(data(:,2));
%assuming the time is in hours
total_time_length_of_ensemble_record_years=total_time_of_ensemble_record/365;
total_time_length_of_ensemble_record_days=total_time_of_ensemble_record;
total_time_length_of_ensemble_record_hours=total_time_of_ensemble_record*24;

min_data_for_histo=min(data(:,3));
data_for_histo=data(:,3)-min_data_for_histo;
data_histo=figure('Name', 'Histogram of data');
hist(data_for_histo, number_of_bins_for_data_histo);
total_data_width_of_ensemble_record=max(data(:,2)) - min(data(:,2));

clear n;
n=size(patient_data);
number_of_patients=n(2);
clear n;

%also, do the distribution of separation times...  that will be a bit
%harder
%generate time-seperations
for i=1:max(number_of_readings)-1;
    time_separations(i,:)=patient_times(i+1,:)-patient_times(i,:);
    %if(time_seperations(i,:)~=0)
    %    time_separations_series(j)=time_seperations(i,:);
    %    j=j+1;
    %end;
end;

%generate the time-separations as a series
k=1;
for j=1:number_of_patients-1;
    %n=size(time_separations(1:(number_of_readings(j)-1)),j);
    if(number_of_readings(j)>1)
        time_separations_series(k:k+number_of_readings(j)-2)=time_separations(1:(number_of_readings(j)-1),j);
        k=k+number_of_readings(j)-1;
    end;
    %j=j+1;
    
end;
clear j;
clear k;

%clear_time_sep_foo;

time_sepatation_histo=figure('Name', 'Histogram of times between readings');
hist(time_separations_series, number_of_bins_for_time_separation_histo);


%plot the readings by time of day AND the mean of the variable normalized
%1. make the bins by time of day
%2. create the normalized patient data structure;
%3. bin the patients by time and create the plots

calculate_bin_end_points_for_24h_period;
create_normailzed_patients;
mean_measurement_value_over_24h;


clear number_of_bins_for_time_histo;
clear number_of_bins_for_data_histo;
clear number_of_bins_for_time_separation_histo;
clear times_for_histo;
clear data_for_histo;
clear min_times_for_histo;
clear min_data_for_histo;
