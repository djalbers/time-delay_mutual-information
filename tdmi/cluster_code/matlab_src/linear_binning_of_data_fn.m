function [binning_return]=linear_binning_of_data(minimum_time, maximum_time, number_of_bins, starting_file_number, file_type_id, ...
    include_entropy, lab_data, lab_times, execution_path);


% this function takes:
%minimum_time=0; % smallest time-interval, normally set to zero
%maximum_time=2600000; 
%maximum_time=10; % longest time interval resolved
%number_of_bins=10; % the total number of bins the data will be placed into
%starting_file_number=1; % the beginning file number...
%file_type_id=0.01; % the decimal identifier for the binning



% two methods - one is to read in all the patient data, and glue it
% together, the other is to read in the patient data one at a time

% read in a single patient and bin
% decide how to calculate, either by (i) individual patient, or by (ii)
% glued patients
% if (i) then calculate what you want and save it;
% if (ii) continue to read in and aggregate the patients, then calculate
% what you want for the whole group


% variables needed: minimum_time, maximum_time, number_of_bins,
% number_of_delays, starting_file_number

% 1. read in the lab data for a single patient
% 2. read in the time data for a single patient
% 3. create an array that has the end delta-t's for the bins
% 4. note that you have to create a file for each time-bin
% 5. for i=1 to the number_of_data_points - number_of_bins do the
% following:
%  for each point, start a counter, and if the delta-t is less than the end
%  point of a bin, dump out the point, if it is greater that the end of the
%  point of the bin, then advance the bin you are dumping into, and dump
%  out the opint

% then, decide if you will process the data, or just continue to glue
% patients together and THEN process the data
%clear all;


size_of_bin=(maximum_time-minimum_time)/number_of_bins;

%size_of_bin=532.5;

% assign linear bin sizes...
for i=1:number_of_bins;
    bin_end_point(i)=i*size_of_bin;
end;


%lab_data=load('lab.foo');
number_of_data_points=length(lab_data);
%lab_times=load('lab_times.foo');

if(include_entropy==1)
    for i=1:number_of_data_points;
        clear foo_name;
        foo_name=0+file_type_id;
        clear foo_file_name_tmp;
        foo_file_name_tmp=num2str(foo_name);
        %these next line is due to cluster requirements
        foo_file_name=[execution_path, '/', foo_file_name_tmp]; 
        fid=fopen(foo_file_name,'a');
        fprintf(fid,'%12.8f \t %12.8f \n',lab_data(i), lab_data(i));
        status=fclose(fid);
    end;
end;


for i=1:number_of_data_points;
    j=1;
    last_bin_min=0;
    for k=(i+1):number_of_data_points;
        if(j<number_of_bins)
            if((lab_times(k)-lab_times(i))<=bin_end_point(j))
                %bump out by appending
                clear foo_name;
                foo_name=starting_file_number+j-1+file_type_id;
                clear foo_file_name_tmp;
                foo_file_name_tmp=num2str(foo_name);
                %these next line is due to cluster requirements
                foo_file_name=[execution_path, '/', foo_file_name_tmp];
                fid=fopen(foo_file_name,'a');
                fprintf(fid,'%12.8f \t %12.8f \n',lab_data(i), lab_data(k));
                status=fclose(fid);
            elseif((lab_times(k)-lab_times(i))>bin_end_point(j))
                while((lab_times(k)-lab_times(i))>bin_end_point(j) & j<number_of_bins)
                    j=j+1;
                end;
                if(j<number_of_bins)
                    clear foo_name;
                    foo_name=starting_file_number+j-1+file_type_id;
                    clear foo_file_name_tmp;
                    foo_file_name_tmp=num2str(foo_name);
                    foo_file_name=[execution_path, '/', foo_file_name_tmp];
                    fid=fopen(foo_file_name,'a');
                    fprintf(fid,'%12.8f \t %12.8f \n',lab_data(i), lab_data(k));
                    status=fclose(fid);
                elseif(j>=number_of_bins & (lab_times(k)-lab_times(i))<=bin_end_point(j) & (lab_times(k)-lab_times(i))>bin_end_point(j-1))
                    %bump out by appending
                    clear foo_name;
                    foo_name=starting_file_number+j-1+file_type_id;
                    clear foo_file_name_tmp;
                    foo_file_name_tmp=num2str(foo_name);
                    foo_file_name=[execution_path, '/', foo_file_name_tmp];
                    fid=fopen(foo_file_name,'a');
                    fprintf(fid,'%12.8f \t %12.8f \n',lab_data(i), lab_data(k));
                    status=fclose(fid);
                    
                end;
            end;
        elseif(j>=number_of_bins)
            if((lab_times(k)-lab_times(i))<=bin_end_point(j) & (lab_times(k)-lab_times(i))>bin_end_point(j-1))
                %bump out by appending
                clear foo_name;
                foo_name=starting_file_number+j+file_type_id;
                clear foo_file_name_tmp;
                foo_file_name_tmp=num2str(foo_name);
                foo_file_name=[execution_path, '/', foo_file_name_tmp];
                fid=fopen(foo_file_name,'a');
                fprintf(fid,'%12.8f \t %12.8f \n',lab_data(i), lab_data(k));
                status=fclose(fid);
            end;
        end;
    end;
      
end;
   
binning_return=0;
   
