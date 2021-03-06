data ex1_8b;
input time censor stage age_diag yr_diag @@;
lines;
0.6 1 1 77 76
1.3 1 1 53 71
2.4 1 1 45 71
3.2 1 1 58 74
3.3 1 1 76 74
3.5 1 1 43 71
3.5 1 1 60 73
4.0 1 1 52 71
4.0 1 1 63 76
4.3 1 1 86 74
5.3 1 1 81 72
6.0 1 1 75 73
6.4 1 1 77 72
6.5 1 1 67 70
7.4 1 1 68 71
2.5 0 1 57 78
3.2 0 1 51 77
3.3 0 1 63 77
4.5 0 1 48 76
4.5 0 1 68 76
5.5 0 1 70 75
5.9 0 1 47 75
5.9 0 1 58 75
6.1 0 1 77 75
6.2 0 1 64 75
6.5 0 1 79 74
6.7 0 1 61 74
7.0 0 1 66 74
7.4 0 1 73 73
8.1 0 1 56 73
8.1 0 1 73 73
9.6 0 1 58 71
10.7 0 1 68 70
0.2 1 2 86 74
1.8 1 2 64 77
2.0 1 2 63 75
3.6 1 2 70 77
4.0 1 2 81 71
6.2 1 2 74 72
7.0 1 2 62 73
2.2 0 2 71 78
2.6 0 2 67 78
3.3 0 2 51 77
3.6 0 2 72 77
4.3 0 2 47 76
4.3 0 2 64 76
5.0 0 2 66 76
7.5 0 2 50 73
7.6 0 2 53 73
9.3 0 2 61 71
0.3 1 3 49 72
0.3 1 3 71 76
0.5 1 3 57 74
0.7 1 3 79 77
0.8 1 3 82 74
1.0 1 3 49 76
1.3 1 3 60 76
1.6 1 3 64 72
1.8 1 3 74 71
1.9 1 3 53 74
1.9 1 3 72 74
3.2 1 3 54 75
3.5 1 3 81 74
5.0 1 3 59 73
6.3 1 3 70 72
6.4 1 3 65 72
7.8 1 3 68 72
3.7 0 3 52 77
4.5 0 3 66 76
4.8 0 3 54 76
4.8 0 3 63 76
5.0 0 3 49 76
5.1 0 3 69 76
6.5 0 3 65 74
8.0 0 3 78 73
9.3 0 3 69 71
10.1 0 3 51 71
0.1 1 4 65 72
0.3 1 4 71 76
0.4 1 4 76 77
0.8 1 4 65 76
0.8 1 4 78 77
1.0 1 4 41 77
1.5 1 4 68 73
2.0 1 4 69 76
2.3 1 4 62 71
3.6 1 4 71 75
3.8 1 4 84 74
2.9 0 4 74 78
4.3 0 4 48 76
;

data ex1_8b; set ex1_8b;
title 'Example 1.8, page 9 data -- Death Times of Male Laryngeal Cancer Patients';
title3 'Proportional Hazards Regression Model -- Local Tests';
stage2=(stage=2);
stage3=(stage=3);
stage4=(stage=4);
proc print data=ex1_8b;
run;

proc phreg data=ex1_8b;
model time*censor(0) = stage2-stage4 age_diag;
no_stage:test stage2,stage3,stage4;
st2_st3: test stage2=stage3;
st2_st4: test stage2=stage4;
st3_st4: test stage3=stage4;
run;

proc phreg data=ex1_8b;
model time*censor(0) = stage2-stage4;
test stage2=stage3;
test stage3=stage4;
test stage2=stage4;

/*Nonparametric test*/
proc lifetest data=ex1_8b method=life plots=(s,h) graphics;
time time*censor(0);
strata stage;
symbol1 v=none color=red line=1;
symbol2 v=none color=blue line=2;
symbol3 v=none color=green line=3;
run; 
