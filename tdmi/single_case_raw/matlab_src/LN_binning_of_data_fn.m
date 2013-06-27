function [LN_binning_success]=LN_binning_of_data(minimum_time, maximum_time, number_of_bins, starting_file_number, file_type_id, ...
    include_entropy, lab_data, lab_times, execution_path);


%minimum_time=0.1; % smallest time-interval, can't be zero
%maximum_time=2600000; 
%maximum_time=10; % longest time interval resolved
%number_of_bins=10; % the total number of bins the data will be placed into
%starting_file_number=1; % the beginning file number...
%file_type_id=0.02; % the decimal identifier for the binning

size_of_bin=(log(maximum_time)-log(minimum_time))/number_of_bins;
%fprintf('%f \n', size_of_bin);
% assign logrithmic bin sizes...
for i=1:number_of_bins;
    bin_end_point(i)=exp(i*size_of_bin);
    %fprintf('%f \n', bin_end_point(i));
    if(minimum_time<1)
        bin_end_point(i)=bin_end_point(i)*minimum_time;
    end;
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
                foo_name=starting_file_number+j-1+file_type_id;
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

LN_binning_success=1;           
            