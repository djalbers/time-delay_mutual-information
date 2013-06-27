%how many iterates, whether to plot
%function a=calculate_and_plot_kde_TDMI(number_of_delays, starting_file_number, time_delayMI, plotit1, plotit2);
function [a]=calculate_and_plot_hist3_TDMI(number_of_delays, starting_file_number, plotit1, plotit2, defNumber_of_bins_hist3, execution_path);

%number_of_delays=10;
%starting_file_number=10000;
%time_delayMI=zeros([number_of_delays]:1);

%mi_pdf_fig=figure(1);
%BIG CHANGE i -> 0 from 1
for i=1:(number_of_delays+1);
    %  read in the pairwise data
    %TDMI_pair(:,1)=dlmread('1.dat');
    %TDMI_test=dlmread('try.dat');
    %tau=9;
    %BIG CHANGE!!! the two below lines are different now
    j=i-1;    
    file_number=num2str(starting_file_number+j); 
    %file_number=num2str(starting_file_number+i);
    fid=fopen([execution_path, '/', file_number]);
    
    if(fid~=(-1))
        fclose(fid);
        TDMI_test=dlmread([execution_path, '/', file_number]);
        %BIG CHANGE!!! +1 at the end
        TDMI_size=max(size(TDMI_test(:,1)))-i;
        %TDMI_size=max(size(TDMI_test(:,1)));
        %fprintf('%g \n', TDMI_size);
        clear TDMI_test;
        % read in row 0, column 1
        %TDMI_pair=dlmread('try.dat', '\t', [0 0 TDMI_size 1]);
        TDMI_pair=dlmread([execution_path, '/', file_number], '\t', [0 0 TDMI_size 1]);
        %TDMI_pair(:,2)=dlmread('try.dat','\t', [1 1 20 1);
        TDMI_size=max(size(TDMI_pair(:,1)));
        % now you know the number of data points in this sucker
        %TDMI_pair(:,1)=dlmread('try.dat', '\\t', [0 0 TDMI_size_max 0]);
        
        %if(plotit1==1)
            
        %CALCULATE THE MI histogram style
            
        %nbins(1)=10;
        nbins(1)=defNumber_of_bins_hist3;
        nbins(2)=nbins(1);
        raw_pdf=hist3(TDMI_pair, nbins);

        %normalized_joint_pdf=raw_pdf/number_of_points;
        normalized_joint_pdf=raw_pdf/TDMI_size;

        xmarginals_normalization=sum(raw_pdf);
        ymarginals_normalization=sum(raw_pdf');

        %generate marginals
        for(k=1:nbins(1))
            %px(k)=xmarginals_normalization(k)/number_of_points;
            %py(k)=ymarginals_normalization(k)/number_of_points;
            px(k)=xmarginals_normalization(k)/TDMI_size;
            py(k)=ymarginals_normalization(k)/TDMI_size;
        end;

        MI_est=0;
        for(k=1:nbins(1))
            for(j=1:nbins(1))
                pxy=normalized_joint_pdf(k,j);
                if(pxy~=0)
                    MI_est=MI_est+pxy*log(pxy/(px(j)*py(k)));
                end;
            end;
        end;
        time_delayMI(i)=MI_est;
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
%dlmwrite('time_delay_MI.dat', time_delayMI);
fid=fopen([execution_path,'/time_delay_MI.dat'],'w+');
fprintf(fid,'%12.8f\n',time_delayMI);
status=fclose(fid);
%saveas(mi_pdf_fig, 'mi_pdf.pdf');
saveas(mi_fig, [execution_path,'/tdmi.pdf']);

end