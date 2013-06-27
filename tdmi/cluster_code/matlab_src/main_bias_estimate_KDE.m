% this is a script!!!!
%1. run this KDE for the data
%2. run the KDE for the data scrambled
%3. full-population scramble
%4. run the KDE for the data with uniform data mixed
%5. run the KDE for the data with gaussian data mixed
%6. run the KDE for the data with KDE-estimated data mixed

fid_debug=fopen([execution_path, '/debug.dat'], 'w+');


%defNumber_of_delays=10;
%defStarting_file_number_TDMI=0.01;
%defStarting_file_id_INTRA_PATIENT_SHUFFLE=0.02;
%defStarting_file_id_POPULATION_SHUFFLE=0.03;

% 1. we calculate and plot the kde-based MI
number_of_delays=defNumber_of_delays;
%number_of_delays=10;
%number_of_delays=16;
starting_file_number=defStarting_file_number_TDMI;
%starting_file_number=0.01;
plotit1=1; % plot the kde estimiates
plotit2=1; % plot the time delayed MI

calculate_and_plot_kde_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, execution_path);

%now let's automatically change the file names to something reasonable.

movefile([execution_path,'/time_delay_MI.dat'], [execution_path,'/tdmi_kde_raw.dat']);
%commented out because of a saveas bug
%movefile([execution_path,'/mi_pdf.pdf'], [execution_path,'/mi_pdf_kde_raw.pdf']);
movefile([execution_path,'/tdmi.pdf'], [execution_path,'/tdmi_kde_raw.pdf']);

fprintf(fid_debug, '%g \n', 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%2.
number_of_delays=defNumber_of_delays;
%number_of_delays=10;
%number_of_delays=16;
starting_file_number=defStarting_file_id_INTRA_PATIENT_SHUFFLE;
%starting_file_number=0.02;
plotit1=1; % plot the kde estimiates
plotit2=1; % plot the time delayed MI

fprintf(fid_debug, '%g \n', 3);

calculate_and_plot_kde_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, execution_path);

%now let's automatically change the file names to something reasonable.
movefile([execution_path,'/time_delay_MI.dat'], [execution_path,'/tdmi_kde_shuffled.dat']);
%commented out because of a saveas bug
%movefile([execution_path,'/mi_pdf.pdf'], [execution_path,'/mi_pdf_kde_shuffled.pdf']);
movefile([execution_path,'/tdmi.pdf'], [execution_path,'/tdmi_kde_shuffled.pdf']);

fprintf(fid_debug, '%g \n', 4);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%3.
number_of_delays=defNumber_of_delays;
%number_of_delays=10;
%number_of_delays=16;
starting_file_number=defStarting_file_id_POPULATION_SHUFFLE;
%starting_file_number=0.03;
plotit1=1; % plot the kde estimiates
plotit2=1; % plot the time delayed MI

fprintf(fid_debug, '%g \n', 5);

calculate_and_plot_kde_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, execution_path);

%now let's automatically change the file names to something reasonable.
movefile([execution_path,'/time_delay_MI.dat'], [execution_path,'/tdmi_kde_population_shuffled.dat']);
%commented out because of a saveas bug
%movefile([execution_path,'/mi_pdf.pdf'], [execution_path,'/mi_pdf_kde_population_shuffled.pdf']);
movefile([execution_path,'/tdmi.pdf'], [execution_path,'/tdmi_kde_population_shuffled.pdf']);

fprintf(fid_debug, '%g \n', 6);

%%%%%%%%%%%%%%%%%%%%%%%%
%4-7

%clear starting_file_number;
%clear number_of_delays;
%clear plotit1;
%clear plotit2;
%starting_file_number=defStarting_file_number_TDMI;
%number_of_delays=defNumber_of_delays;
%plotit1=1;
%plotit2=1;

%fprintf(fid_debug, '%g \n', 7);

%calculate_lower_bound_mixed_random_No_kde_TDMI(starting_file_number, number_of_delays, plotit1, plotit2, execution_path);

%fprintf(fid_debug, '%g \n', 8);
%fclose(fid_debug);

