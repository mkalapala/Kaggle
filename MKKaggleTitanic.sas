PROC IMPORT DBMS=csv OUT=train  replace
  DATAFILE="/folders/myfolders/train.csv";
  GETNAMES=YES;
RUN; /*DATAFILE =the name and location of the input file 
	 DBMS = the type of file being read
	 OUT = name of the output file
	 REPLACE = if the TRAIN file already exists in the work library then it should be overwritten
	 GETNAMES = the first row of the CSV file contains the values that will be used to label the variables in the TRAIN dataset.*/
	
/*What effect does the passenger's gender have on his/her survival?*/
PROC FREQ DATA =train ;
  TABLES survived*sex / NOROW NOPERCENT;
RUN;

/*Import the test data*/
PROC IMPORT DBMS=csv OUT=test replace
  DATAFILE="/folders/myfolders/test.csv";
  GETNAMES=YES;
RUN;

/*Assign values 0 and 1 to Survived variable*/
DATA gender_submit(KEEP=survived passengerid );
  SET test;
  IF sex = "female" THEN survived = 1;
  ELSE survived = 0;
 RUN;
 
 /*Convert gender datase to CSV*/
PROC EXPORT DATA=gender_submit DBMS=csv
  OUTFILE= "/folders/myfolders/gender_sub.csv" REPLACE;
RUN;