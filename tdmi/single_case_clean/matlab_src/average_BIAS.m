clear datain;
clear number_of_points_bias;

datain=load([execution_path, '/tdmi_hist3_shuffled.dat']);
number_of_points_bias=max(size(datain));

bias=datain(2:number_of_points_bias);
bias_mean=mean(bias);
bias_std=std(bias);
fid=fopen([execution_path, '/BIAS'], 'w');
fprintf(fid, 'intra-population ');
fprintf(fid, '%g \t %g \n', bias_mean, bias_std);
fclose(fid);

clear datain;
clear number_of_points_bias; 
clear bias;
clear bias_mean;
clear bias_std;

datain=load([execution_path, '/tdmi_hist3_population_shuffled.dat']);
number_of_points_bias=max(size(datain));
bias=datain(2:number_of_points_bias);
bias_mean=mean(bias);
bias_std=std(bias);
fid=fopen([execution_path, '/BIAS'], 'a');
fprintf(fid, 'inter-population ');
fprintf(fid, '%g \t %g \n', bias_mean, bias_std);
fclose(fid);

clear datain;
clear bias;
clear bias_mean;
clear bias_std;
