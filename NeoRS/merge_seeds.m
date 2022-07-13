function [ ] = merge_seeds( subject )


out=[subject '/Output_files/SBC/Total_ROIs_perceptron'];
in1=[subject '/Output_files/SBC/SCA_vol1'];
in2=[subject '/Output_files/SBC/SCA_vol2'];
in3=[subject '/Output_files/SBC/SCA_vol3'];
in4=[subject '/Output_files/SBC/SCA_vol4'];
in5=[subject '/Output_files/SBC/SCA_vol5'];
in6=[subject '/Output_files/SBC/SCA_vol6'];
in7=[subject '/Output_files/SBC/SCA_vol7'];
in8=[subject '/Output_files/SBC/SCA_vol8'];
in9=[subject '/Output_files/SBC/SCA_vol9'];
in10=[subject '/Output_files/SBC/SCA_vol10'];
in11=[subject '/Output_files/SBC/SCA_vol11'];
in12=[subject '/Output_files/SBC/SCA_vol12'];
in13=[subject '/Output_files/SBC/SCA_vol13'];
in14=[subject '/Output_files/SBC/SCA_vol14'];
in15=[subject '/Output_files/SBC/SCA_vol15'];
in16=[subject '/Output_files/SBC/SCA_vol16'];
in17=[subject '/Output_files/SBC/SCA_vol17'];
in18=[subject '/Output_files/SBC/SCA_vol18'];
in19=[subject '/Output_files/SBC/SCA_vol19'];
in20=[subject '/Output_files/SBC/SCA_vol20'];
in21=[subject '/Output_files/SBC/SCA_vol21'];
in22=[subject '/Output_files/SBC/SCA_vol22'];
in23=[subject '/Output_files/SBC/SCA_vol23'];
in24=[subject '/Output_files/SBC/SCA_vol24'];
in25=[subject '/Output_files/SBC/SCA_vol25'];
in26=[subject '/Output_files/SBC/SCA_vol26'];
in27=[subject '/Output_files/SBC/SCA_vol27'];
in28=[subject '/Output_files/SBC/SCA_vol28'];
in29=[subject '/Output_files/SBC/SCA_vol29'];
in30=[subject '/Output_files/SBC/SCA_vol30'];
in31=[subject '/Output_files/SBC/SCA_vol31'];


Merge_bold_cmd=['fslmerge -t ' out ' ' in1 ' ' in2 ' ' in3 ' ' in4 ' ' in5 ' ' in6 ' ' in7 ' ' in8 ' ' in9 ' ' in10 ' ' in11 ' ' in12 ' ' in13 ' ' in14 ' ' in15 ' ' in16 ' ' in17 ' ' in18 ' ' in19 ' ' in20 ' ' in21 ' ' in22 ' ' in23 ' ' in24 ' ' in25 ' ' in26 ' ' in27 ' ' in28 ' ' in29 ' ' in30 ' ' in31];
system(Merge_bold_cmd)


end

