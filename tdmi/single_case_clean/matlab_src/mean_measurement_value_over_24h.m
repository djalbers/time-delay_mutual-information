%this SCRIPT creates a figure of the normalized 24 hour mean value of 
% a CCR lab value, accompanied by it's standard deviation.

%matlab labels (row, column)

%note: this will break if there is only one point in the bin

%for i=2:number_of_readings;
%    foo(:,i)=patient_times(:,i)-floor(patient_times(:,i));
%end;

clear foo;
clear foo2;
clear foo3;
clear foo4;
clear number_of_lines_in_foo2;
clear identifier_matrix;
clear size_of_id_matrix;
clear cutting_matrix;
clear number_of_binning_points_foo;
clear means_24h;
clear stds_24h;

foo(:,1)=data(:,2)-floor(data(:,2));
foo(:,2)=data(:,3);

foo2=sortrows(foo);

number_of_lines_in_foo2=size(foo2, 1);

%end_points_of_bins_24h;

number_of_binning_points_foo=size(end_points_of_bins_24h,2);

%means_24h(1,1)=0;
%means_24h(1,2)=0;
%stds_24h(1,1)=0;
%stds_24h(1,2)=0;

%let us handle the i=1 case independently
identifier_matrix=(foo2(:,1)>0 & foo2(:,1)<=end_points_of_bins_24h(1));
identifier_matrix=[identifier_matrix identifier_matrix]; % creates a matrix of the same size of
% foo2 with 1's at the points we want to bin
size_of_id_matrix=sum(identifier_matrix(:,1)); % we just sum the 1's in the id matrix
foo3=foo2.*identifier_matrix; % multiply point by point
foo3=sortrows(foo3); %move the non-zero elements to the bottom
cutting_matrix(1:number_of_lines_in_foo2-size_of_id_matrix,1:size_of_id_matrix)=zeros(number_of_lines_in_foo2-size_of_id_matrix,size_of_id_matrix);
%    size(cutting_matrix);
cutting_matrix(number_of_lines_in_foo2-size_of_id_matrix+1:number_of_lines_in_foo2, 1:size_of_id_matrix)=eye(size_of_id_matrix, size_of_id_matrix);
foo4=(foo3'*cutting_matrix)';
means_24h(1,1)=end_points_of_bins_24h(1);
means_24h(1,2)=mean(foo4(:,2));
stds_24h(1,1)=end_points_of_bins_24h(1);
stds_24h(1,2)=std(foo4(:,2));
clear foo3;
clear foo4;
clear identifier_matrix;
clear size_of_id_matrix;
clear cutting_matrix;


for i=2:number_of_binning_points_foo;
    identifier_matrix=(foo2(:,1)>end_points_of_bins_24h(i-1) & foo2(:,1)<=end_points_of_bins_24h(i));
    identifier_matrix=[identifier_matrix identifier_matrix]; % creates a matrix of the same size of 
    % foo2 with 1's at the points we want to bin
    size_of_id_matrix=sum(identifier_matrix(:,1)); % we just sum the 1's in the id matrix
    foo3=foo2.*identifier_matrix; % multiply point by point
    foo3=sortrows(foo3); %move the non-zero elements to the bottom
    cutting_matrix(1:number_of_lines_in_foo2-size_of_id_matrix,1:size_of_id_matrix)=zeros(number_of_lines_in_foo2-size_of_id_matrix,size_of_id_matrix);
%    size(cutting_matrix);
    cutting_matrix(number_of_lines_in_foo2-size_of_id_matrix+1:number_of_lines_in_foo2, 1:size_of_id_matrix)=eye(size_of_id_matrix, size_of_id_matrix);
    foo4=(foo3'*cutting_matrix)';
    means_24h(i,1)=end_points_of_bins_24h(i);
    means_24h(i,2)=mean(foo4(:,2));
    stds_24h(i,1)=end_points_of_bins_24h(i);
    stds_24h(i,2)=std(foo4(:,2));
    clear foo3;
    clear foo4;
    clear identifier_matrix;
    clear size_of_id_matrix;
    clear cutting_matrix;
    
end;

figure();
errorbar(means_24h, stds_24h);



clear foo;
clear foo2;
clear foo3;
clear foo4;
clear number_of_lines_in_foo2;
clear identifier_matrix;
clear size_of_id_matrix;
clear cutting_matrix;
clear number_of_binning_points_foo;

