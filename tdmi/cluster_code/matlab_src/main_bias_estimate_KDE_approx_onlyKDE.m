clear starting_file_number;
clear number_of_delays;
clear plotit1;
clear plotit2;
%starting_file_number=9999;
starting_file_number=0.01;
number_of_delays=10;
%number_of_delays=100;
%number_of_delays=34;
plotit1=1;
plotit2=1;

%function a=calculate_lower_bound_mixed_random_No_kde_TDMI(starting_file_number, number_of_delays, plotit1, plotit2);

%number_of_delays=10;
%starting_file_number=10000;
%time_delayMI=zeros([number_of_delays]:1);

file_number=num2str(starting_file_number+1);
TDMI_test=dlmread(file_number);
TDMI_size=max(size(TDMI_test(:,1)))-1;
clear TDMI_test;
% read in row 0, column 1
TDMI_pair=dlmread(file_number, '\t', [0 0 TDMI_size 0]);   
TDMI_size=max(size(TDMI_pair(:,1)));

%calculate the pair mixed with Gaussian random numbers
TDMI_pair_random(:,1)=TDMI_pair(:,1);

clear mi_pdf_fig;
clear mi_fig;

%%%%%%%%%%%%%---------------------------%%%%%%%%%%%%%%%

%calculate the pair mixed with KDE estimated randome numbers
TDMI_pair_random(:,1)=TDMI_pair(:,1);
mi_pdf_fig=figure();

%specify the initial standard deviation for the normal distribution used to
%generate the new random variables --- note a larger standard deviation
%means a worse fit for few points (more points needed for converngence in
%distribution) where as a smaller standard deviation means a better fit but
%MUCH slower calculationg!
standard_deviation_for_generating_RV=10; %was 3
%at 3, 2, 1, no humps, looks uniform
%at 0.2 the corner humps appear
% 
%specify the number of points you want to generate!
number_of_generated_values=TDMI_size;
%specify if you want to make the plots of all the relevant figures such as
%the KDEs of all the distributions, M*g, etc.
make_plots=0;

for i=1:number_of_delays;
    %TDMI_pair_random(:,2)= rand(1,TDMI_size);
    
    x(:,1)=TDMI_pair_random(:,1);
    number_of_generated_values=max(size(TDMI_pair_random))+1;
    %fprintf('i %f', i);
    %fprintf(' size of TDMIpair %f', number_of_generated_values);
    %number_of_generated_values=10000;
    
 
    x_generated=generate_random_numbers_from_arbitary_distribution(x, number_of_generated_values, standard_deviation_for_generating_RV, make_plots);
    %TDMI_pair_random(:,2)= x_generated(:,1);
    TDMI_pair_random(:,2)= x_generated(1,:).';
    %foo1=max(size(TDMI_pair_random(:,2)));
    %foo2=max(size(x_generated(1,:).'));
    
    %fprintf(' size of tdmi vector %f', foo1);
    %fprintf(' size of generated values %f', foo2);
    %fprintf('\n'); 
    
    %fprintf('Number of points in the files \n',TDMI_size);
    
    % calculate and plot the TDMI with the normally distributed data
    clear p p1 p2 MI_est;
    %figure();
    %plot(TDMI_pair_random(:,2),TDMI_pair_random(:,1), 'o');
    TDMI_pair_random_trans=TDMI_pair_random.';
    p=kde(TDMI_pair_random_trans, 'rot');
    p1 = marginal(p,[1]);
    p2 = marginal(p,[2]);
    % MI(a,b) = H(a) + H(b) - H(a,b)
    MI_est = entropy(p1)+entropy(p2)-entropy(p);
    %fprintf('   MI_est = %f (nits)\n',MI_est);
    if(plotit1==1)
        %figure();
        %if(i<13)
        %    subplot(3, 4, i);
        %    mesh(hist(p));
        %    xlabel('x_i');
        %   ylabel('x_{\tau}');
        %    title('Time-delayed MI KDE approximation-mixed', 'FontSize', 5);
        %end;
        if(i<10)
            subplot(3, 3, i);
            mesh(hist(p));
            title(['\tau =', num2str(i-1)], 'fontsize', 18);
        end
        
    end;

    MI_estimate(i)=MI_est;
    fprintf('%f \n', i);
end
    
%dlmwrite('lower_bound_MI_estimate_RN_mix.dat', MI_estimate);

if(plotit2==1)
    mi_fig=figure('Name', 'TDMI');
    %plot(time_delayMI, '-o');
    semilogy(MI_estimate, '-o');
    xlabel('\tau');
    ylabel('I_{\tau}');
    title('Time-delayed mutual information - KDE approximation', 'FontSize', 20);
end
%write out the TDMI!!! to a file
%dlmwrite('time_delay_MI_uniform.dat', MI_estimate);
fid=fopen('time_delay_MI_KDE_fit_LV.dat','w+');
fprintf(fid,'%12.8f\n',MI_estimate);
status=fclose(fid);
saveas(mi_pdf_fig, 'mi_pdf_KDE_fit_LV.pdf');
saveas(mi_fig, 'tdmi_KDE_fit_LV.pdf');

%end


%%%%%%%%%%% smaller variance case %%%%%%%%%%%%%%

clear mi_pdf_fig;
clear mi_fig;

%%%%%%%%%%%%%---------------------------%%%%%%%%%%%%%%%

%calculate the pair mixed with KDE estimated randome numbers
TDMI_pair_random(:,1)=TDMI_pair(:,1);
mi_pdf_fig=figure();

%specify the initial standard deviation for the normal distribution used to
%generate the new random variables --- note a larger standard deviation
%means a worse fit for few points (more points needed for converngence in
%distribution) where as a smaller standard deviation means a better fit but
%MUCH slower calculationg!
standard_deviation_for_generating_RV=0.2; %was 3
%at 3, 2, 1, no humps, looks uniform
%at 0.2 the corner humps appear
% 
%specify the number of points you want to generate!
number_of_generated_values=TDMI_size;
%specify if you want to make the plots of all the relevant figures such as
%the KDEs of all the distributions, M*g, etc.
make_plots=0;

for i=1:number_of_delays;
    %TDMI_pair_random(:,2)= rand(1,TDMI_size);
    
    x(:,1)=TDMI_pair_random(:,1);
    number_of_generated_values=max(size(TDMI_pair_random))+1;
    %fprintf('i %f', i);
    %fprintf(' size of TDMIpair %f', number_of_generated_values);
    %number_of_generated_values=10000;
    
 
    x_generated=generate_random_numbers_from_arbitary_distribution(x, number_of_generated_values, standard_deviation_for_generating_RV, make_plots);
    %TDMI_pair_random(:,2)= x_generated(:,1);
    TDMI_pair_random(:,2)= x_generated(1,:).';
    %foo1=max(size(TDMI_pair_random(:,2)));
    %foo2=max(size(x_generated(1,:).'));
    
    %fprintf(' size of tdmi vector %f', foo1);
    %fprintf(' size of generated values %f', foo2);
    %fprintf('\n'); 
    
    %fprintf('Number of points in the files \n',TDMI_size);
    
    % calculate and plot the TDMI with the normally distributed data
    clear p p1 p2 MI_est;
    %figure();
    %plot(TDMI_pair_random(:,2),TDMI_pair_random(:,1), 'o');
    TDMI_pair_random_trans=TDMI_pair_random.';
    p=kde(TDMI_pair_random_trans, 'rot');
    p1 = marginal(p,[1]);
    p2 = marginal(p,[2]);
    % MI(a,b) = H(a) + H(b) - H(a,b)
    MI_est = entropy(p1)+entropy(p2)-entropy(p);
    %fprintf('   MI_est = %f (nits)\n',MI_est);
    if(plotit1==1)
        %figure();
        %if(i<13)
        %    subplot(3, 4, i);
        %    mesh(hist(p));
        %    xlabel('x_i');
        %   ylabel('x_{\tau}');
        %    title('Time-delayed MI KDE approximation-mixed', 'FontSize', 5);
        %end;
        if(i<10)
            subplot(3, 3, i);
            mesh(hist(p));
            title(['\tau =', num2str(i-1)], 'fontsize', 18);
        end
        
    end;

    MI_estimate(i)=MI_est;
    fprintf('%f \n', i);
end
    
%dlmwrite('lower_bound_MI_estimate_RN_mix.dat', MI_estimate);

if(plotit2==1)
    mi_fig=figure('Name', 'TDMI');
    %plot(time_delayMI, '-o');
    semilogy(MI_estimate, '-o');
    xlabel('\tau');
    ylabel('I_{\tau}');
    title('Time-delayed mutual information - KDE approximation', 'FontSize', 20);
end
%write out the TDMI!!! to a file
%dlmwrite('time_delay_MI_uniform.dat', MI_estimate);
fid=fopen('time_delay_MI_KDE_fit_SV.dat','w+');
fprintf(fid,'%12.8f\n',MI_estimate);
status=fclose(fid);
saveas(mi_pdf_fig, 'mi_pdf_KDE_fit_SV.pdf');
saveas(mi_fig, 'tdmi_KDE_fit_SV.pdf');




