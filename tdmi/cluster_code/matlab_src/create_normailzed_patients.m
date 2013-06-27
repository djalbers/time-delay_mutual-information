%this SCRIPT creates a data structure with normalized patients --- the
%patients are normalized to mean zero and unit variance.
%matlab labels (row, column)

%patients_means=mean(patient_data(1:number_of_readings(:), :));
%patients_stds=std(patient_data(1:number_of_readings(:), :));
%patient_data_normalized=(patient_data(1:number_of_readings(:), :)-patients_means(:))/patients_std(:);

clear patients_means;
clear patients_stds;
clear patient_data_normalized;

for i=1:number_of_patients;
    patients_means(i)=mean(patient_data(1:number_of_readings(i), i));
    patients_stds(i)=std(patient_data(1:number_of_readings(i), i));
    patient_data_normalized(1:number_of_readings(i),i)=(patient_data(1:number_of_readings(i), i)-patients_means(i))/patients_stds(i);
end;

