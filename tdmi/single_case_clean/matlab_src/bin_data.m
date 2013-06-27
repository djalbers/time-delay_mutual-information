function [binning_return]=bin_data(binning_style, number_of_bins, starting_file_number, file_type_id, include_entropy, ...
    min_time, max_time, number_of_readings, patient_data, patient_times, execution_path);
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

% running the binning programs iteratively

%we have to deal with whether we will glue all patients together
% or not...

% choose the binning style
% binning can be: 1 - linear bins, 2 - log scale bins
%binning_style=1;

% choose the grid style tau=1, delta t =2, or tau_delta_t_grid = 3
grid_style=2;

if(max_time==-1) %then automatically set the maximum time
    mt=max(patient_times);
    %mt2=max(mt);
    %maximum_time=ceil(mt2);
    maximum_time=max(mt);
else %use the user defined maximum time
    maximum_time=max_time;
end;
    
if(min_time==-1)
    minimum_time=1;
else
    minimum_time=min_time;
end;

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
number_of_patients=max(size(patient_data(1,:)));

if(binning_style==1)          
    for(i=1:number_of_patients)
        lab_data=patient_data(1:number_of_readings(i),i);
        %lab_data=patient_data(1:number_of_readings(1),1);
        lab_times=patient_times(1:number_of_readings(i),i);
        linear_binning_success=linear_binning_of_data_fn(minimum_time, maximum_time, number_of_bins, starting_file_number, file_type_id, ...
            include_entropy, lab_data, lab_times, execution_path);
        
    end;
elseif(binning_style==2)
    for(i=1:number_of_patients)
        lab_data=patient_data(1:number_of_readings(i),i);
        %lab_data=patient_data(1:number_of_readings(1),1);
        lab_times=patient_times(1:number_of_readings(i),i);
        LN_binning_success=LN_binning_of_data_fn(minimum_time, maximum_time, number_of_bins, starting_file_number, file_type_id, ...
            include_entropy, lab_data, lab_times, execution_path);
    end;
end;

end
