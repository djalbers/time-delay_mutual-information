
for(i=1:1)
  for(j=1:10) 
      %addpath('/home/dja7001/matlab_utilities');                                                                                                                                                                                                           
      cd([pwd, '/', int2str(i), '.', int2str(j)]);       
      
      root_path=pwd;
      root_path_slash=([root_path, '/']); 
      
      addpath(root_path);
      
      %select and set the scheduler

      TDMI_glucose_schd = findResource('scheduler','type','torque');
      
      %set the paths for where to run, home, where to execute, etc.
      
      %execution_path=root_path_slash;
      execution_path=root_path;
      path_for_output=root_path_slash;
      %home_directory=('/home/dja7001');
      home_directory=pwd;
      
      %set the output directory
      set(TDMI_glucose_schd, 'DataLocation', char(path_for_output));
      set(TDMI_glucose_schd, 'HasSharedFilesystem', true);
      set(TDMI_glucose_schd, 'ClusterMatlabRoot', '\share\apps\matlab\');
      %set(agg_patient_schd, 'ClusterSize', 10);
      %set(TDMI_glucose_schd, 'SubmitArguments', '-m aeb -l nodes=1,mem=5gb');
      set(TDMI_glucose_schd, 'SubmitArguments', '-l nodes=1,mem=2gb');
      %define a job
      
      TDMI_glucose_jobs=createJob(TDMI_glucose_schd);
      
      %now, you have to let the job know where the exacutables and such are
      %so you need to create a cell array of strings, 
      p={path_for_output, [execution_path, '/matlab_src'], [home_directory, '/matlab_utilities']};
      set(TDMI_glucose_jobs, 'PathDependencies', p);
      
      %define the arguments sent to the function
      number_of_call_parameters=14;
      
      %define the call parameters
      
      nof=('/glucose.data');	
      %name_of_data_file=char(strcat(char(execution_path, nof)));
      name_of_data_file=[root_path,nof];
      % bin-data settings
      %linear bins
      binning_style=1; %linear
      number_of_bins=32; %for time 8 days, 4 bins per day
      starting_file_number=1;
      %file_type_id=1;
      starting_file_id_TDMI=0.01;
      starting_file_id_INTRA_PATIENT_SHUFFLE=0.02;
      starting_file_id_POPULATION_SHUFFLE=0.03;
      %max_time=691200; %8 days worth of seconds
      max_time=11520; %8 days worth of minutes
                      %max_time=14; %if =-1 then you set the max time to the maximum absolute time in the record
      min_time=1; %was 0
      
      run_kde=1; %to preform the KDE calculation, set to 1
      run_hist3=1; %to perform the histogram based calculation, set to 1
      defNumber_of_bins_hist3=16;	
      
      %create the task
      
      createTask(TDMI_glucose_jobs, @run_tdmi_basic, 0, {binning_style, number_of_bins, starting_file_number, starting_file_id_TDMI, starting_file_id_INTRA_PATIENT_SHUFFLE, ...
                          starting_file_id_POPULATION_SHUFFLE, max_time, min_time, defNumber_of_bins_hist3, run_kde, run_hist3, execution_path, name_of_data_file, home_directory}); 
      
      %submit the job
      
      %fid=fopen([execution_path, '/', 'foo.txt'], 'a+');                                                                                   
      %fprintf(fid, '%s /n', execution_path);                                                                                                                                         
      %fclose(fid); 
      
      submit(TDMI_glucose_jobs);
      
      cd('..');  
      keep i j;
  end;
end;

  
