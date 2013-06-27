%this SCRIPT sets up the end points for the bins used by the mean_measurement_value_of_patients script:
mx_days=1;
mn_days=0;
number_of_bins_24h=24;

%0.0417 = hours
%0.167 1/6th of a day
%0.25 quarter days
%min_time=0.0417
%max_time=14
%336 bins is a bin an hour
% min_time = 0.167
% 84 bins for 14 days
% 28 bins for quarter days
%number_of_bins=3;
%starting_file_number=1;
%file_type_id=0.1;

clear end_points_of_bins_24h;


length_of_bin_24h=(mx_days-mn_days)/number_of_bins_24h;

% assign linear bin sizes...
for i=1:number_of_bins_24h;
    end_points_of_bins_24h(i)=i*length_of_bin_24h;
end;

clear length_of_bin;
clear number_of_bins; 
clear mn_days; 
clear mx_days;
%clear number_of_bins_24h;
clear length_of_bin_24h;

