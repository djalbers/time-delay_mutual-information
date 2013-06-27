%find the binning sizes:
max_time=14;
min_time=0.25;
number_of_bins=56;


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


length_of_bin=(maximum_time-minimum_time)/number_of_bins;

% assign linear bin sizes...
for i=1:number_of_bins;
    end_points_of_bins(i)=i*length_of_bin;
end;

clear length_of_bin;
clear number_of_bins; 
clear min_time; 
clear max_time;
