%close all;
%clear all;
function [a]=calculate_plot_histogram_TDMI(starting_lag_series, ending_lag_series, root_number_of_bins, maximum_number_of_data_points, starting_file_number, output_type_series, output_MI_PDF, MI_PDF_starting_file_number_series);
% calculate the MI based on series data starting with 
% lag 0 and ending with lag 10
%starting_lag_series=0;
%ending_lag_series=10;
%root_number_of_bins=16;
%maximum_number_of_data_points=10000;
%starting_file_number=1;
%output_type_series=1;
%output_MI_PDF=1; % 0 is off, 1 is for contours and surfaces
%MI_PDF_starting_file_number_series=100;
total_number_of_lags_series=ending_lag_series-starting_lag_series+1;
a=histogram_based_MI_mex(1, root_number_of_bins, starting_lag_series, ending_lag_series, maximum_number_of_data_points, starting_file_number, output_MI_PDF, 1, MI_PDF_starting_file_number_series, 'MI_histo_series.dat', 'MI_histo_bin_data_series.dat');

%// 0 int MI_data_readin_type 1 pairs, 0 series
%// 1 int MI_number_of_bins square root of the number of bins
%// 2 int MI_starting_lag
%// 3 int MI_ending_lag
%// 4 long MI_maximum_number_of_data_points
%// 5 long MI_file_starting_number
%// 6 int MI_output_type // 0 MI, 1 tau MI, 2 lag tau MI
%// 7 MI_PDF_output_on 0 is off, 1 is on
%// 8 MI_PDF_output_starting_file_number what ever you want it to be
%// 9 char MI_output_filename[]
%// 10 char MI_data_per_bin_output_filename
    

% now calculate it from the already available pairwise data
%starting_lag_pair=0;
%ending_lag_pair=9;
%root_number_of_bins=16;
%maximum_number_of_data_point=10000;
%starting_file_number=10000;
%output_type_pair=2;
%output_MI_PDF=1;
%MI_PDF_starting_file_number_pair=200;
%total_number_of_lags_pair=ending_lag_pair-starting_lag_pair;
%histogram_based_MI_mex(1, 16, 0, 9, 10000, 10000, 2, output_MI_PDF, MI_PDF_starting_file_number_pair, 'MI_histo_pairs.dat', 'MI_histo_bin_data_pairs.dat');

%now let's plot things:
% FIRST, read in the data
%read in the MI data
if(output_type_series==1)
    %MI_histo_series_x=dlmread('MI_histo_series.dat', '\t', [0 0 ending_lag_series 0]);
    %MI_histo_series_y=dlmread('MI_histo_series.dat', '\t', [0 1 ending_lag_series 1]);
    %MI_histo_bin_data_series=dlmread('MI_histo_bin_data_series.dat', '\t', [0 0 ending_lag_series 1]);
    MI_histo_series_x=dlmread('MI_histo_series.dat', '\t', [0 0 total_number_of_lags_series-1 0]);
    MI_histo_series_y=dlmread('MI_histo_series.dat', '\t', [0 1 total_number_of_lags_series-1 1]);
    MI_histo_bin_data_series=dlmread('MI_histo_bin_data_series.dat', '\t', [0 0 total_number_of_lags_series-1 1]);
end

%read in the data-per-bin data
%if(output_type_pair==1)
%    MI_histo_bin_data_pairs=dlmread('MI_histo_bin_data_pairs.dat', '\t', [0 0 ending_lag_pair-1 1]);
%end
%if(output_type_pair==2)
%    MI_histo_pair_x=dlmread('MI_histo_pairs.dat', '\t', [0 1 ending_lag_pair-1 1]);
%    MI_histo_pair_y=dlmread('MI_histo_pairs.dat', '\t', [0 2 ending_lag_pair-1 2]);
%    MI_histo_bin_data_pairs=dlmread('MI_histo_bin_data_pairs.dat', '\t', [0 1 ending_lag_pair-1 2]);
%end

% read in and plot the MI-PDF data
mi_histo_pdf=figure();
if(output_MI_PDF==1)
    for i=1:total_number_of_lags_series;
        j=MI_PDF_starting_file_number_series+i-1;
        file_number=num2str(j);
        clear MI_PDF;
        MI_PDF=dlmread(file_number, '\t', [0 0 (root_number_of_bins-1) (root_number_of_bins-1)]);
        %figure(j);
        if(i<13)
            subplot(3, 4, i);
            shading interp;
            surfc(MI_PDF,'EdgeColor','none');
            shading interp;
            %contour(MI_PDF);
            %mesh(hist(MI_PDF));
        end;
    end
end


%plot the MI as a function of tau
mi_histo_fig=figure();
%plot(MI_histo_series_x, MI_histo_series_y, MI_histo_pair_x, MI_histo_pair_y);
plot(MI_histo_series_x, MI_histo_series_y);
xlabel('time-delay, \tau');
ylabel('I(x_i, x_{i-\tau})');
title('Time-delayed mutual information - histogram method', 'FontSize', 20);
%legend('MI - series', 'MI - pairs');
legend('MI - series');
%axis([0 200 -0.5 1.5]);

%figure();
%mi_data_histo=hist2d(MI_histo_bin_data_series);
hist2d(MI_histo_bin_data_series);
xlabel('x_i');
ylabel('x_{i-\tau}');
title('PDF of x_i, x_{i-\tau} series', 'FontSize', 20);

%%figure();
%hist2d(MI_histo_bin_data_pairs);
%xlabel('x_i');
%ylabel('x_{i-\tau}');
%title('PDF of x_i, x_{i-\tau} pairs', 'FontSize', 20);
%%function Hout = hist2d(D,Xn,Yn,Xrange,Yrange)

saveas(mi_histo_pdf, 'mi_histo_pdf.pdf');
saveas(mi_histo_fig, 'tdmi_histo.pdf');
%saveas(mi_data_histo, 'mi_data_histo.pdf');
end