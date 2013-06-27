%function [load_data_return]=load_data(data_file_name, load_file_at_once, file_style);

%these are now in the run script
%data_file_name='data.foo.real';
%load_file_at_once=1;
%file_style=1;


%loading the patient data into a data-structure:
% patient_data
% patient_times

%note: you have to choose if you can load the whole
% data file in at one time...  for more information see:
% http://www.mathworks.com/support/tech-notes/1100/1110.html
%load_file_at_once=1;
% 1 => load the file at once
% 2 => load the file in pieces


% 1. choose the file style
%   1. file style: patient #; time; value
%   2. file stlye: time; value
%   3. file style: value
%file_style=1;

%we have to deal with whether we will glue all patients together
% or not...

if(file_style==1)
    %let's begin reading in data
    % there will be two while loops here
    % while loop one --- while we are not at the end of the file
    % while loop two --- while the patient is the same
    
    %fid=fopen('data.foo.real','rt'); 
    fid=fopen(data_file_name,'rt'); 
    if(load_file_at_once==1)
        data = fscanf(fid,'%f \t %f \t %f \n', [3 inf]);
        data=data';
        total_number_of_data_points=max(size(data));
        %total_number_of_data_points=5;
        % now we have to partitaion the data up by patient --- this is 
        % assuming
            
        %%%%%%%%%%%% FIRST, load the data
        j = 1;
        i=1;
        %[m,n]=size(A);
        [m,n]=size(data);
        
        % patient_data -- all the patient data
        % patient times -- all the patient times
        % number_of_readings -- the number of data points for each
        % patient
        
        while (j<m+1)
            %a = A(j,1);
            a = data(j,1);
            
            %v = (A(:,1)==a);
            v = (data(:,1)==a);
            nv = sum(v);
            B = zeros(m,nv);
            
            B(j:(j+nv-1),:) = eye(nv);
            
            C = data'*B;
            %A1 is the block of patients
            A1 = C';
            cut_patient_numbers=[0 0; 1 0; 0 1];
            isolated_patients=A1*cut_patient_numbers;
            % A1 is what we use for binning, or really, the
            % second two rows of A1
            number_of_readings(i)=max(size(isolated_patients(:,1)));
            patient_data(1:number_of_readings(i),i)=isolated_patients(:,2);
            mt=min(isolated_patients(:,1));
            patient_times(1:number_of_readings(i),i)=isolated_patients(:,1) -mt +1;
           
                       
            j=j+nv;
            i=i+1;
            clear v nv B C A1
        end; % end for the while loop
       
      
    elseif(load_file_at_once==2)
        i=0;
        % FEOF is used as the
        % loop control to read
        % until the file ends:    
        while(~feof(fid))
            i = i+1;
            % FSCANF is used to
            % read in data one
            %  character at a time :
            data = fscanf(fid,'%f \t %f \t %f \n', [3 inf]);
            data=data';
            total_number_of_data_points=max(size(data));
            if(~isempty(data)) %if data is NOT empty
            
                % the data is stored in
                % vector 'a' :
                a(i, 1) = data(i, 1);
                a(i, 2) = data(i, 2);
                a(i, 3) = data(i, 3);
            end;
        end; % end of end of file while loop
    end; % end of the if loop to open the data file...
    fclose(fid);
  
    
elseif(file_style==2)
  
end;

%end;
