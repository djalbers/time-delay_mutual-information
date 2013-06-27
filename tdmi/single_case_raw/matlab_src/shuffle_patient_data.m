%this is a script, because it creates a new global data structure:
% patient_data_shuffled
% this can't be used until after load_data is run

number_of_patients=max(size(patient_data(1,:)));

%this is the INTRA-patient shuffle and constructs the data for the
%POPULATION_WIDE shuffle
clear last_index;
clear patient_population_data_shuffled;
clear patient_population_data_to_shuffle;
clear patient_population_data_long_string;
clear patient_population_string_shuffled;
last_index=1;

for(i=1:number_of_patients)
    %data_unshuffled=load(file_number);
    data_unshuffled=patient_data(1:number_of_readings(i),i);
    data_size=max(size(data_unshuffled(:,1)));

    %data_to_shuffle(:,1)=dlmread(file_number, '\t', [0 0 (data_size-1) 0]);
    data_to_shuffle(:,1)=data_unshuffled;
    data_to_shuffle(:,2)=randn(data_size,1);
    
    data_shuffled=sortrows(data_to_shuffle, 2);
    %dlmwrite('shuffled_data', data_shuffled(:,1), 'precision', 6);
    patient_data_shuffled(1:number_of_readings(i),i)=data_shuffled(:,1);
    clear data_unshuffled;
    clear data_size;
    clear data_to_shuffle;
    clear data_shuffled;
    
    %construct data stucture for population-wide shuffle
    index_foo=last_index-1+number_of_readings(i);
    patient_population_data_long_string(last_index:index_foo)=patient_data(1:number_of_readings(i),i).';
    last_index=index_foo+1;
    
end;

%this is the POPULATION-WIDE shuffle
data_size=max(size(patient_population_data_long_string));
patient_population_data_to_shuffle(:,1)=patient_population_data_long_string.';
patient_population_data_to_shuffle(:,2)=randn(data_size,1);

patient_population_string_shuffled=sortrows(patient_population_data_to_shuffle, 2);

last_index=1;
for(i=1:number_of_patients)
    index_foo=last_index-1+number_of_readings(i);
    patient_population_data_shuffled(1:number_of_readings(i),i)=patient_population_string_shuffled(last_index:index_foo);
    last_index=index_foo+1;
end;

clear index_foo;
clear last_index;
clear patient_population_data_to_shuffle;
clear patient_population_data_long_string;
clear patient_population_string_shuffled;


