#!/bin/bash                                                                                                                          
#cd matlab_src;
tar -cf matlab_src.tar matlab_src;
#mv matla.tar ../;
#cd ..;

for (( c=1; c<=1; c++ ))
do
  for (( k=1; k<=10; k++ ))
    do
      #tar -cf mls.tar ./matlab_src;
      mkdir $c.$k;
      cd $c.$k;
      cp ../data_files/$c.$k.glucose.data glucose.data;    
      cp ../run_tdmi_basic.m .;
      cp ../matlab_src.tar .;
      tar -xf matlab_src.tar;
      rm matlab_src.tar;
      cd ..;
      done;
done



