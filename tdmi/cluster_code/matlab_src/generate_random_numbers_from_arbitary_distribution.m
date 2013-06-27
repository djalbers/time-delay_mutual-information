function [x_kde_generated]=generate_random_numbers_from_arbitary_distribution(x, number_of_generated_values, standard_deviation_for_generating_RV, make_plots);

%function prototype: data, how many points to generate, whether to plot stuff
%clear all;
%specify the initial standard deviation for the normal distribution used to
%generate the new random variables --- note a larger standard deviation
%means a worse fit for few points (more points needed for converngence in
%distribution) where as a smaller standard deviation means a better fit but
%MUCH slower calculationg!
%standard_deviation_for_generating_RV=3; 
%specify the number of points you want to generate!
%number_of_generated_values=500;
%specify if you want to make the plots of all the relevant figures such as
%the KDEs of all the distributions, M*g, etc.
%make_plots=1;

%1. create or read in a set of numbers
%2. perform a KDE fit of those data points (one could also use a histogram)
%3. approximate the kde estimate with a chip (or spline, now we use pchip)
%4. integrate the spline to make sure the function is integrating to 1 and
%is a proper probability function. --- we don't do this anymore, but you
%can turn it on to check
%5. define the normal distribution we use to generate the data points
%6. using the result from 5, estimate M, the maximum multiple such that
%f<g*M
%7. perform the accept-reject algorithm in the standard way

%1) calculate size of original data
number_of_original_data_points=max(size(x));

%1.1 make the date into a probability distribution
data_mean=mean(x);
data_standard_deviation=std(x);



%2) perform a kde fit of the data
number_of_kde_fit_grid_points=1000;
[f, x_grid]=ksdensity(x, 'npoints', number_of_kde_fit_grid_points);
if(make_plots==1)
    figure('Name', 'Real data KDE estimate');
    plot(x_grid,f);
    figure('Name', 'Real data histogram');
    hist(x);
end;

%3) make a pchip or spline approximation of the data
%spline approximation
%f_spline_approx=spline(x_grid,f);

%pchip approximation
f_spline_approx=pchip(x_grid,f);

%4) integrate the spline approximation of the data to make sure it is a PDF
a=min(x_grid);
b=max(x_grid);

%int_kde_estimate=quad(@(x_grid)ppval(f_spline_approx,x_grid),a,b);


%5) define the normal distribution function

if(standard_deviation_for_generating_RV<data_standard_deviation)
    standard_deviation_for_generating_RV=data_standard_deviation;
end;

spline_approx_of_g=@(v) (1/(standard_deviation_for_generating_RV*2*sqrt(2*pi)))*exp(-((v-data_mean).^2)/(2*standard_deviation_for_generating_RV^2));

%6) estimate the maximum factor used to accept the randomly generated data
spline_explicit_g=spline_approx_of_g(x_grid);
spline_explicit_f=ppval(f_spline_approx,x_grid);

M=spline_explicit_f./spline_explicit_g;
M_max=max(M);
spline_explicit_g_times_M=M_max.*spline_explicit_g(1,:);

if(make_plots==1)
    figure('Name', 'Explicit spline approximations of f and g');
    plot(x_grid, spline_explicit_f);
    hold all;
    plot(x_grid, spline_explicit_g);
    legend('f', 'g');

    figure('Name', 'Explicit spline approximations of f, g, and g*M');
    plot(x_grid, spline_explicit_f);
    hold all;
    plot(x_grid, spline_explicit_g);
    plot(x_grid, spline_explicit_g_times_M);
    legend('f', 'g', 'M*g');
end;

%7) run the accept-reject algorithm to generate random values
i=1;
while(i<number_of_generated_values)
    u=rand(1);
    from_g=(randn(1)*data_standard_deviation)+data_mean;
    if(from_g <= b && from_g >= a)
        %f_over_g=ppval(f_spline_approx,from_g)/ppval(spline_approx_of_g, from_g);
        f_over_g=ppval(f_spline_approx,from_g)/(spline_approx_of_g(from_g));
        if(M_max*u <= f_over_g)
            x_kde_generated(1,i)=from_g;
            i=i+1;
        end;
    end;
end;

if(make_plots==1)
    [f_generated, x_generated_grid]=ksdensity(x_kde_generated, 'npoints', number_of_generated_values);
    figure('Name', 'Real data KDE estimate');
    plot(x_generated_grid,f_generated);
    hold all;
    plot(x_grid,f);
    legend('Generated PDF', 'KDE of original PDF');
end;
% AND THAT FOLKS, is it!
end





