%how many iterates, whether to plot
%function a=calculate_and_plot_kde_TDMI(number_of_delays, starting_file_number, time_delayMI, plotit1, plotit2);
function [a]=calculate_and_plot_kde_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, execution_path);

%number_of_delays=10;
%starting_file_number=10000;
%time_delayMI=zeros([number_of_delays]:1);

mi_pdf_fig=figure(1);
for i=1:number_of_delays+1;
    %  read in the pairwise data
    %TDMI_pair(:,1)=dlmread('1.dat');
    %TDMI_test=dlmread('try.dat');
    %tau=9;
    j=i-1;
    file_number=num2str(starting_file_number+j);
    fid=fopen([execution_path, '/', file_number]);
    
    if(fid~=(-1))
        fclose(fid);
        TDMI_test=dlmread([execution_path, '/', file_number]);
        TDMI_size=max(size(TDMI_test(:,1)))-i;
        clear TDMI_test;
        % read in row 0, column 1
        %TDMI_pair=dlmread('try.dat', '\t', [0 0 TDMI_size 1]);
        TDMI_pair=dlmread([execution_path, '/', file_number], '\t', [0 0 TDMI_size 1]);
        %TDMI_pair(:,2)=dlmread('try.dat','\t', [1 1 20 1);
        TDMI_size=max(size(TDMI_pair(:,1)));
        % now you know the number of data points in this sucker
        %TDMI_pair(:,1)=dlmread('try.dat', '\\t', [0 0 TDMI_size_max 0]);
        
        if(plotit1==1)
            %PLOT THIS SUCKER!!!
            TDMI_pair_trans=TDMI_pair.';
            p=kde(TDMI_pair_trans, 'rot');
            p1 = marginal(p,[1]);
            p2 = marginal(p,[2]);
            % MI(a,b) = H(a) + H(b) - H(a,b)
            MI_est = entropy(p1)+entropy(p2)-entropy(p);
            time_delayMI(i)=MI_est;
            %fprintf('   MI_est = %f (nits)\n',MI_est);
            %figure(starting_file_number+j);
            %if(i<13)
            %    subplot(3, 4, i);
            %    mesh(hist(p));
            %end;
            if(i<10)
                subplot(3, 3, i);
                mesh(hist(p));
                title(['\tau =', num2str(i-1)], 'fontsize', 18);
            end;
        
        end;
    elseif(fid==(-1))
        time_delay_MI(i)=-0.1;
    end;
    

end;

if(plotit2==1)
    mi_fig=figure('Name', 'TDMI');
    %plot(time_delayMI, '-o');
    semilogy(time_delayMI, '-o');
    xlabel('\tau');
    ylabel('I_{\tau}');
    title('Time-delayed mutual information', 'FontSize', 20);
end
%write out the TDMI!!! to a file

%fid_debug=fopen([execution_path, '/debug.dat'], 'w+');
%fprintf(fid_debug, '%g \n', 1);

%clear ffn;
%ffn=[execution_path,'/time_delay_MI.dat'];
%fid=fopen(ffn,'w+');
fid=fopen([execution_path, '/time_delay_MI.dat'], 'w+');
fprintf(fid,'%12.8f\n',time_delayMI);
status=fclose(fid);

%fprintf(fid_debug, '%g \n', 2);

%%NOTE, this code barfs here!!!
%saveas(mi_pdf_fig, [execution_path, '/mi_pdf.pdf']); 
clear mi_pdf_fig;

%fprintf(fid_debug, '%g \n', 3);

saveas(mi_fig, [execution_path, '/tdmi.pdf']);
clear mi_fig;

%fprintf(fid_debug, '%g \n', 4);
%fclose(fid_debug);

end
