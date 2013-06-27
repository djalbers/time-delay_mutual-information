function aggregate_multiple_patients_in_single_file(number_of_files, execution_path)

%delete('aggregated_patient_file.data');
%delete('aggregated_patient_file_raw.data');

%number_of_files=1;

for(i=1:number_of_files)
    foo_name_data=num2str(i);
    i_t=i+0.01;
    foo_name_time=num2str(i_t);
    fid1 = fopen([execution_path, '/', foo_name_data], 'r');
    clear data;
    data = fscanf(fid1, '%g \n', [1 inf]); 
    %data=load(foo_name_data);
    %data=data';
    fid2 = fopen([execution_path, '/', foo_name_time], 'r');
    clear time;
    time = fscanf(fid2, '%g \n', [1 inf]); 
    %time=load(foo_name_time);
    data_points=max(size(data));
    time_points=max(size(time));
    if(data_points == time_points)
        for(j=1:data_points)
            time_adjusted=time(j)-time(1)+1;
            fid=fopen([execution_path, '/aggregated_patient_file.data'], 'a+');
            fidr=fopen([execution_path, '/aggregated_patient_file_raw.data'], 'a+');
            fprintf(fidr, '%g \t %g \t %g \n', i, time_adjusted, data(j));
            if(data(j)<500 && data(j)>10)
               fprintf(fid, '%g \t %g \t %g \n', i, time_adjusted, data(j)); 
            end;
            fclose(fidr);
            fclose(fid);
        end;
    end;
    fclose(fid1);
    fclose(fid2);
    
end;
