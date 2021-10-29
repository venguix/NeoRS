#To run this script in terminal: sh launch_matlab.sh

#/Applications/MATLAB_R2015a.app/bin/matlab -r -nodesktop -nosplash "run('/Users/vicenteenguix/Desktop/NeoRS/NeoRS/neors.m');"

#matlab -nosplash -nodesktop -r "run('/Users/vicenteenguix/Desktop/NeoRS/NeoRS/neors.m');"



#matlab -r "edit('/Users/vicenteenguix/Desktop/NeoRS/NeoRS/neors.m');"


#setup matlab:

#1. nano .bash_profile
#2  export PATH=/Applications/MATLAB_R2015a.app/bin/:$PATH
#3. source ~/.bash_profile
#4. matlab


#set neors path in matlab
#1.HOME > set path > Add with subfolder > neors
#2. Launch neors from terminal
matlab -nosplash -nodesktop -r "run('neors');"

#chmod a+x yourscriptname
#open with terminal