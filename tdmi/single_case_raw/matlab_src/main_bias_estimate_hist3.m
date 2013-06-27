% this is a script!!!!
%1. run this KDE for the data
%2. run the KDE for the data scrambled
%3. run the KDE for the data with uniform data mixed
%4. run the KDE for the data with gaussian data mixed
%5. run the KDE for the data with KDE-estimated data mixed


% 1. we calculate and plot the histogram-based MI

%clear number_of_delays;
%clear starting_file_number;
%clear beginning_output_file_number;
%clear total_number_of_different_lags;
%clear plotit1;
%clear plotit2;
%number_of_delays=34;
number_of_delays=defNumber_of_delays;
%number_of_delays=10;
starting_file_number=defStarting_file_number_TDMI;
%starting_file_number=0.01;
plotit1=1; % plot the kde estimiates
plotit2=1; % plot the time delayed MI

calculate_and_plot_hist3_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, defNumber_of_bins_hist3, execution_path);

%now let's automatically change the file names to something reasonable.
movefile([execution_path, '/time_delay_MI.dat'], [execution_path, '/tdmi_hist3_raw.dat']);
%movefile('mi_pdf.pdf', 'mi_pdf_hist3_raw.pdf');
%movefile('tdmi.pdf', 'tdmi_hist3_raw.pdf');


%%%%%%%%%%%%%%%%%%%%%%%%%%
%2.
number_of_delays=defNumber_of_delays;
%number_of_delays=10;
%number_of_delays=16;
starting_file_number=defStarting_file_id_INTRA_PATIENT_SHUFFLE;
%starting_file_number=0.02;
plotit1=1; % plot the kde estimiates
plotit2=1; % plot the time delayed MI

calculate_and_plot_hist3_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, defNumber_of_bins_hist3, execution_path);

%now let's automatically change the file names to something reasonable.
movefile([execution_path, '/time_delay_MI.dat'], [execution_path, '/tdmi_hist3_shuffled.dat']);
%movefile('mi_pdf.pdf', 'mi_pdf_kde_shuffled.pdf');
%movefile('tdmi.pdf', 'tdmi_kde_shuffled.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%
%3.
number_of_delays=defNumber_of_delays;
%number_of_delays=10;
%number_of_delays=16;
starting_file_number=defStarting_file_id_POPULATION_SHUFFLE;
%starting_file_number=0.03;
plotit1=1; % plot the kde estimiates
plotit2=1; % plot the time delayed MI

calculate_and_plot_hist3_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, defNumber_of_bins_hist3, execution_path);

%now let's automatically change the file names to something reasonable.
movefile([execution_path, '/time_delay_MI.dat'], [execution_path, '/tdmi_hist3_population_shuffled.dat']);
%movefile('mi_pdf.pdf', 'mi_pdf_kde_population_shuffled.pdf');
%movefile('tdmi.pdf', 'tdmi_kde_population_shuffled.pdf');



