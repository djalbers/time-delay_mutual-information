%kde_raw has tau=0 to number_of_delays
%kde_error has tau=0 to number_of_delays
%hist3_raw has tau=0 to tau= number_of_delays
%hist3_error has tau=0 to number_of_delays
if(run_kde==1)
    kde_raw=load([execution_path, '/tdmi_kde_raw.dat']);
    kde_error=load([execution_path, '/tdmi_kde_shuffled.dat']);
    
    end_point=max(size(kde_raw));
    tdmi_kde_raw=kde_raw(2:end_point);
    end_point=max(size(kde_error));
    tdmi_kde_error=kde_error(2:end_point);
    
    kde_error_mean=mean(tdmi_kde_error);
    tdmi_kde=tdmi_kde_raw-kde_error_mean;
    fid=fopen([execution_path, '/tdmi_kde.dat'], 'w');
    fprintf(fid, '%g \n', tdmi_kde);
    fclose(fid);
end;
if(run_hist3==1)
    hist3_raw=load([execution_path, '/tdmi_hist3_raw.dat']);
    hist3_error=load([execution_path, '/tdmi_hist3_shuffled.dat']);

    end_point=max(size(hist3_raw));
    tdmi_hist3_raw=hist3_raw(2:end_point);
    end_point=max(size(hist3_error));
    tdmi_hist3_error=hist3_error(2:end_point);

    hist3_error_mean=mean(tdmi_hist3_error);
    tdmi_hist3=tdmi_hist3_raw-hist3_error_mean;
    fid=fopen([execution_path, '/tdmi_hist3.dat'], 'w');
    fprintf(fid, '%g \n', tdmi_hist3);
    fclose(fid);
end;
