## Potentially Hardcoded Numeric Constants


We found the following set of hard coded numbers. This may be completely legitimate (parameter input, thresholds for computations, etc), and is hence only for information.

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/inner_loop_one.f90**

- Line 415, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 887, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/main.f90**

- Line 148, : !r_se_list = (/ 0.04, 0.05, 0.06, 0.07, 0.08, 0.09/) !/ 0.002, 0.005, 0.01, 0.05, 0.1, 0.15/
- Line 285, : if (param_se(i) < param_se(i-1)) param_se(i) = max(0.001,(initial_param_se(i-1)+initial_param_se(i))*0.5)
- Line 292, : !   if (param_se(i) <= param_se(i-1)) param_se(i) = param_se(i-1) + 0.000001
- Line 321, : if (param_se(nalpha+1) == 0) param_se(nalpha+1) = -50.175662699999997

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_model_dataset_info2.do**

- Line 249, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 250, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 254, : replace Wage = 86.731818 if Wage > 86.731818
- Line 255, : replace Wage = 28.777456 if Wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_model_dataset_info0.do**

- Line 248, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 249, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 253, : replace Wage = 86.731818 if Wage > 86.731818
- Line 254, : replace Wage = 28.777456 if Wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/estimation_result/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1092, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1098, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/paper_appendix/Draft_final.tex**

- Line 1, : %2multibyte Version: 5.50.0.2960 CodePage: 932
- Line 18, : %TCIDATA{Version=5.50.0.2960}
- Line 1521, : $ equals 0.88 (with a standard error of 0.004) and an $R^{2}$ of 0.85.
- Line 1604, : improves the fit of Aux 1a (with an increase in $R^{2}$ from 0.680 to 0.681).
- Line 1640, : wage                         & 0.001  & (0.0002)   & & $-1.5\times 10^{-5}$ & $(2.6\times 10^{-6})$ \\
- Line 1641, : $e_d^{\lambda}$              & -0.002 & (0.008)    & & -0.0001              & (0.0001) \\
- Line 1642, : $c_1 \times \lambda_d$       & 0.568  & (0.283)    & & -0.020               & (0.006) \\
- Line 1643, : $d \neq d_0$                 & -0.826 & (0.012)    & & -0.982               & (0.002) \\
- Line 1645, : & 0.476  & (0.098)    & & 0.833                & (0.039) \\
- Line 1647, : & 0.267  & (0.031)    & & 0.236                & (0.026) \\
- Line 1649, : & 0.085  & (0.013)    & & 0.099                & (0.010) \\
- Line 1651, : & 0.020  & (0.011)    & & 0.014                & (0.005) \\
- Line 1652, : $z_d \neq z_{d_0}$           & -0.027 & (0.005)    & & -0.0004              & (0.0001) \\
- Line 1653, : $\ln(\text{distance})$       & -0.019 & (0.002)    & & -0.0001              & (0.00002) \\
- Line 1654, : $q_d:$ urban                 & 0.014  & (0.002)    & & 0.004                & (0.0002) \\
- Line 1655, : $q_d:$ suburban              & 0.011  & (0.002)    & & 0.001                & (0.0001) \\
- Line 1656, : $q_d:$ large metro           & 0.096  & (0.028)    & & 0.012                & (0.002) \\\cline{2-3} \cline{5-6}
- Line 1914, : experience group is 0.71, 0.17, 0.05, 0.001, and 0.001.} Individuals compare
- Line 1965, : & \multicolumn{1}{l}{1--2} & 0.012 & (0.11) \\
- Line 1968, : & \multicolumn{1}{l}{3--4} & 0.016 & (0.02) \\
- Line 1971, : & \multicolumn{1}{l}{5--9} & 0.017 & (0.37) \\
- Line 1974, : & \multicolumn{1}{l}{10--14} & 0.033 & (0.02) \\
- Line 1977, : & \multicolumn{1}{l}{$\geq 15$} & 0.040 & (0.03) \\
- Line 2006, : this coefficient is -0.02 in the data but 0.001 in the model. The upper panel
- Line 2704, : wage & 0.001 & 0.001  & -1.5$\times$10$^{5}$ & -0.5$\times$10$^{-5}$\\
- Line 2705, : $e_{d}^{\lambda}$ &  -0.002 & -0.002 &  -0.0001 & -0.0002\\
- Line 2706, : $c_{1}\times\lambda_{d}$ & 0.568 & 0.499 &  -0.020 & 0.001\\
- Line 2707, : $d\neq d_{0}$ &  -0.826 & -0.896 &  -0.982 & -0.998\\
- Line 2708, : $d\neq d_{0}\times \text{exp}\in[1,2]$ & 0.476 & 0.339 &  0.833 & 0.728\\
- Line 2709, : $d\neq d_{0}\times \text{exp}\in[3,4]$ & 0.267 & 0.203 &  0.236 & 0.177\\
- Line 2710, : $d\neq d_{0}\times \text{exp}\in[5,9]$ & 0.085 & 0.078 &  0.099 & 0.057\\
- Line 2711, : $d\neq d_{0}\times \text{exp}\in[10,14]$ & 0.020 & 0.010 &  0.014 & -0.0002\\
- Line 2712, : $z_{d}\neq z_{d_{0}}$ &  -0.027 & -0.029 & -0.0004 & -0.0003\\
- Line 2713, : $\ln(\text{distance})$ &  -0.019 & -0.010 & -0.0001 & 0.00005\\
- Line 2714, : $q_{d}$: urban & 0.014 & -0.002 &  0.004 & 0.001\\
- Line 2715, : $q_{d}$: suburban & 0.011 & 0.01 &  0.001 & 0.001\\
- Line 2716, : $q_{d}$: large metro & 0.096 & 0.127 &  0.012 & 0.001\\\hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/auxiliary_regressions/aux_model_teachers_wages.do**

- Line 75, : replace wage = 86.731818 if wage > 86.731818
- Line 76, : replace wage = 28.777456 if wage < 28.777456
- Line 223, : replace wage = 86.731818 if wage > 86.731818
- Line 224, : replace wage = 28.777456 if wage < 28.777456
- Line 235, : replace wage = 86.731818 if wage > 86.731818
- Line 236, : replace wage = 28.777456 if wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/estimation_result/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/2_rigid/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_noninc2_JPE.tex**

- Line 8, : free budget (1,000) &      0.0000         &      0.0000\sym{**} &                     &                     &                     &      0.0000         &      0.0000\sym{**} &                     &                     &                     \\
- Line 9, : &    (0.0000)         &    (0.0000)         &                     &                     &                     &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 11, : free capacity       &     -0.0000\sym{*}  &     -0.0000\sym{**} &                     &                     &                     &     -0.0000\sym{**} &     -0.0000\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0000)         &    (0.0000)         &                     &                     &                     &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.0000         &      0.0003\sym{**} &      0.0000         &      0.0003\sym{**} &      0.0003\sym{**} &      0.0000\sym{*}  &      0.0000\sym{**} &      0.0000\sym{*}  &      0.0000         &      0.0000         \\
- Line 15, : &    (0.0000)         &    (0.0001)         &    (0.0000)         &    (0.0001)         &    (0.0001)         &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 17, : free budget PT * $\lambda$&                     &     -0.0000\sym{*}  &                     &     -0.0000\sym{*}  &     -0.0000\sym{*}  &                     &     -0.0000\sym{*}  &                     &     -0.0000         &     -0.0000         \\
- Line 18, : &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         \\
- Line 20, : free budget/teacher (1,000)&                     &                     &      0.0000         &      0.0000\sym{*}  &      0.0000\sym{*}  &                     &                     &      0.0000\sym{*}  &      0.0000         &      0.0000         \\
- Line 21, : &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 23, : urban               &                     &                     &                     &                     &     -0.0000         &                     &                     &                     &                     &      0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0000         &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.0000         &                     &                     &                     &                     &     -0.0000         \\
- Line 30, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 33, : R-squared           &       0.016         &       0.026         &       0.010         &       0.018         &       0.020         &       0.020         &       0.023         &       0.014         &       0.015         &       0.016         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_noninc1_JPE.tex**

- Line 8, : free budget (1,000) &      0.0048\sym{***}&      0.0032         &                     &                     &                     &     -0.0002\sym{**} &     -0.0021\sym{**} &                     &                     &                     \\
- Line 9, : &    (0.0007)         &    (0.0077)         &                     &                     &                     &    (0.0001)         &    (0.0010)         &                     &                     &                     \\
- Line 11, : free capacity       &      0.2964\sym{***}&      0.3821         &                     &                     &                     &      0.0028         &      0.1049\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0840)         &    (0.4305)         &                     &                     &                     &    (0.0090)         &    (0.0529)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      1.0344         &     -1.2271         &      0.8903         &      8.6990         &     10.8620         &      0.2059         &     -2.4867\sym{*}  &      0.2084         &     -3.6050\sym{**} &     -3.4607\sym{**} \\
- Line 15, : &    (0.8382)         &   (10.7926)         &    (0.7751)         &   (20.1065)         &   (21.0288)         &    (0.1722)         &    (1.4585)         &    (0.1704)         &    (1.4114)         &    (1.5552)         \\
- Line 17, : free budget PT * $\lambda$&                     &      0.0492         &                     &     -0.1702         &     -0.2189         &                     &      0.0585\sym{*}  &                     &      0.0831\sym{***}&      0.0804\sym{**} \\
- Line 18, : &                     &    (0.2337)         &                     &    (0.4467)         &    (0.4666)         &                     &    (0.0311)         &                     &    (0.0305)         &    (0.0335)         \\
- Line 20, : free budget/teacher (1,000)&                     &                     &      0.0626\sym{***}&      0.1510         &      0.1817         &                     &                     &     -0.0029\sym{*}  &     -0.0461\sym{***}&     -0.0453\sym{**} \\
- Line 21, : &                     &                     &    (0.0131)         &    (0.2363)         &    (0.2461)         &                     &                     &    (0.0015)         &    (0.0161)         &    (0.0176)         \\
- Line 23, : urban               &                     &                     &                     &                     &      0.0353         &                     &                     &                     &                     &     -0.0034         \\
- Line 24, : &                     &                     &                     &                     &    (0.1590)         &                     &                     &                     &                     &    (0.0288)         \\
- Line 26, : suburban            &                     &                     &                     &                     &     -0.0371         &                     &                     &                     &                     &      0.0251         \\
- Line 27, : &                     &                     &                     &                     &    (0.1397)         &                     &                     &                     &                     &    (0.0156)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -1.9449\sym{***}&                     &                     &                     &                     &      0.0785\sym{**} \\
- Line 30, : &                     &                     &                     &                     &    (0.2627)         &                     &                     &                     &                     &    (0.0357)         \\
- Line 33, : R-squared           &       0.144         &       0.144         &       0.069         &       0.070         &       0.081         &       0.016         &       0.023         &       0.015         &       0.024         &       0.031         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/validation_result/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/2_rigid/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_teachers_offer_set.do**

- Line 48, : local C0 = r(mean) + 0.00000000000000001
- Line 50, : local C1 = r(mean) + 0.00000000000000001
- Line 52, : local exp = r(mean) + 0.00000000000000001
- Line 54, : local wage = r(mean) + 0.00001

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1095, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1101, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/main.f90**

- Line 225, : perturbation(1)  = 3.358  !urban
- Line 226, : perturbation(2)  = 2.132  !suburban
- Line 227, : perturbation(3)  = 8.312  !milwauk
- Line 228, : perturbation(4)  = 1.375  !exp(lamb)
- Line 229, : perturbation(5)  = 26.342 !c1 * lamb
- Line 231, : perturbation(7 ) = 6.688  !d0 exp2
- Line 232, : perturbation(8 ) = 22.030 !d0 exp3
- Line 233, : perturbation(9 ) = 6.325  !d0 exp4
- Line 234, : perturbation(10) = 41.100 !d0 exp5
- Line 235, : perturbation(11) = 50.255 !d0 exp6
- Line 236, : perturbation(12) = 5.237  !d0 logdist
- Line 237, : perturbation(13) = 22.863 !same cz
- Line 239, : perturbation(15) = 0.106  !exp2
- Line 240, : perturbation(16) = 0.021  !exp3
- Line 241, : perturbation(17) = 0.376  !exp4
- Line 242, : perturbation(18) = 0.024  !exp5
- Line 243, : perturbation(19) = 0.034  !exp6
- Line 244, : perturbation(20) = 0.016  !(1-lamb) * c2
- Line 245, : perturbation(21) = 0.029  !master
- Line 246, : perturbation(22) = 0.944  !sigma
- Line 247, : perturbation(23) = 0.195  !fixed cost
- Line 248, : perturbation(24) = 0.448  !dem share
- Line 249, : perturbation(25) = 0.127  !abs(o1 - 1)
- Line 250, : perturbation(26) = 0.297  !dem * abs(o1 - 1)
- Line 251, : perturbation(27) = 0.101  !o2 / 100
- Line 252, : perturbation(28) = 0.341  !dem * o2/100
- Line 253, : perturbation(29) = 0.027  !sigmaD
- Line 303, : !   if (param_se(i) <= param_se(i-1)) param_se(i) = param_se(i-1) + 0.000001
- Line 332, : !              if (param_se(nalpha+1) == 0) param_se(nalpha+1) = -50.175662699999997

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_all1_JPE.tex**

- Line 8, : budget (1,000)      &     -0.0007\sym{**} &      0.0028         &                     &                     &                     &      0.0000         &      0.0000         &                     &                     &                     \\
- Line 9, : &    (0.0003)         &    (0.0032)         &                     &                     &                     &         (.)         &         (.)         &                     &                     &                     \\
- Line 11, : capacity            &     -0.0276         &     -0.2164         &                     &                     &                     &      0.0000         &      0.0000         &                     &                     &                     \\
- Line 12, : &    (0.0439)         &    (0.1823)         &                     &                     &                     &         (.)         &         (.)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.4659         &      5.4449         &      0.4838         &      0.1001         &     -1.0418         &      0.0000         &      0.0000         &      0.0000         &      0.0000         &      0.0000         \\
- Line 15, : &    (0.4654)         &    (4.4710)         &    (0.4977)         &    (6.3589)         &    (5.9050)         &         (.)         &         (.)         &         (.)         &         (.)         &         (.)         \\
- Line 17, : budget PT * $\lambda$&                     &     -0.1082         &                     &      0.0084         &      0.0315         &                     &      0.0000         &                     &      0.0000         &      0.0000         \\
- Line 18, : &                     &    (0.0992)         &                     &    (0.1377)         &    (0.1285)         &                     &         (.)         &                     &         (.)         &         (.)         \\
- Line 20, : budget/teacher (1,000)&                     &                     &     -0.0103\sym{*}  &     -0.0146         &     -0.0266         &                     &                     &      0.0000         &      0.0000         &      0.0000         \\
- Line 21, : &                     &                     &    (0.0053)         &    (0.0716)         &    (0.0671)         &                     &                     &         (.)         &         (.)         &         (.)         \\
- Line 23, : urban               &                     &                     &                     &                     &      0.1698         &                     &                     &                     &                     &      0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.1056)         &                     &                     &                     &                     &         (.)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0343         &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0529)         &                     &                     &                     &                     &         (.)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.3199\sym{**} &                     &                     &                     &                     &      0.0000         \\
- Line 30, : &                     &                     &                     &                     &    (0.1296)         &                     &                     &                     &                     &         (.)         \\
- Line 33, : R-squared           &       0.017         &       0.019         &       0.012         &       0.012         &       0.020         &           .         &           .         &           .         &           .         &           .         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1143, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1149, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/2_rigid/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/1_baseline/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/validation_result/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 886, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/Table_B3.tex**

- Line 8, : $\Delta c_0$        &       0.000         &                     &       0.000         &                     \\
- Line 10, : $\Delta c_1$        &                     &       0.000         &                     &       0.000         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_all_mean3_JPE.tex**

- Line 8, : budget (1,000)      &      0.0000         &      0.0000\sym{*}  &                     &                     &                     \\
- Line 9, : &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 11, : capacity            &     -0.0000         &     -0.0000\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.0000         &      0.0002\sym{*}  &      0.0000         &      0.0002         &      0.0002         \\
- Line 15, : &    (0.0000)         &    (0.0001)         &    (0.0000)         &    (0.0001)         &    (0.0001)         \\
- Line 17, : budget PT * $\lambda$&                     &     -0.0000\sym{*}  &                     &     -0.0000         &     -0.0000         \\
- Line 18, : &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         \\
- Line 20, : budget/teacher (1,000)&                     &                     &      0.0000         &      0.0000         &      0.0000         \\
- Line 21, : &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 23, : urban               &                     &                     &                     &                     &     -0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.0000\sym{**} \\
- Line 30, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 33, : R-squared           &       0.005         &       0.022         &       0.002         &       0.013         &       0.015         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1095, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1101, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/validation_result/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1095, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1101, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/estimation_result/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1143, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1149, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/descriptives/budget_shifts.do**

- Line 50, : legend(off) xline(2011) ylabel(0(0.005)0.02)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_all_mean1_JPE.tex**

- Line 8, : budget (1,000)      &      0.0048\sym{***}&      0.0090         &                     &                     &                     &     -0.0002\sym{*}  &     -0.0020\sym{**} &                     &                     &                     \\
- Line 9, : &    (0.0007)         &    (0.0061)         &                     &                     &                     &    (0.0001)         &    (0.0010)         &                     &                     &                     \\
- Line 11, : capacity            &      0.0498         &     -0.1761         &                     &                     &                     &      0.0028         &      0.1010\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0818)         &    (0.3586)         &                     &                     &                     &    (0.0091)         &    (0.0508)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      1.2306\sym{*}  &      7.1882         &      1.1423\sym{*}  &     11.3038         &     14.7015         &      0.1613         &     -2.4277\sym{*}  &      0.1636         &     -3.1630\sym{**} &     -3.0104\sym{**} \\
- Line 15, : &    (0.7087)         &    (8.4400)         &    (0.6688)         &   (12.9922)         &   (14.2244)         &    (0.1673)         &    (1.3722)         &    (0.1660)         &    (1.4095)         &    (1.5220)         \\
- Line 17, : budget PT * $\lambda$&                     &     -0.1295         &                     &     -0.2215         &     -0.2954         &                     &      0.0563\sym{*}  &                     &      0.0725\sym{**} &      0.0696\sym{**} \\
- Line 18, : &                     &    (0.1840)         &                     &    (0.2889)         &    (0.3160)         &                     &    (0.0294)         &                     &    (0.0306)         &    (0.0329)         \\
- Line 20, : budget/teacher (1,000)&                     &                     &      0.0681\sym{***}&      0.1832         &      0.2246         &                     &                     &     -0.0027\sym{*}  &     -0.0404\sym{**} &     -0.0395\sym{**} \\
- Line 21, : &                     &                     &    (0.0123)         &    (0.1546)         &    (0.1679)         &                     &                     &    (0.0015)         &    (0.0162)         &    (0.0174)         \\
- Line 23, : urban               &                     &                     &                     &                     &      0.0174         &                     &                     &                     &                     &     -0.0031         \\
- Line 24, : &                     &                     &                     &                     &    (0.1561)         &                     &                     &                     &                     &    (0.0288)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0847         &                     &                     &                     &                     &      0.0253         \\
- Line 27, : &                     &                     &                     &                     &    (0.1251)         &                     &                     &                     &                     &    (0.0158)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -1.9124\sym{***}&                     &                     &                     &                     &      0.0717\sym{**} \\
- Line 30, : &                     &                     &                     &                     &    (0.2411)         &                     &                     &                     &                     &    (0.0359)         \\
- Line 33, : R-squared           &       0.111         &       0.111         &       0.086         &       0.087         &       0.100         &       0.012         &       0.019         &       0.011         &       0.018         &       0.025         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/1_baseline/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/estimation_result/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/Table_B12.tex**

- Line 8, : wage (1,000)        &     0.00048\sym{***}&     0.00023\sym{***}\\
- Line 9, : &   (0.00003)         &   (0.00003)         \\
- Line 11, : $ e^\lambda$        &    -0.01676         &     0.09430\sym{***}\\
- Line 12, : &   (0.01724)         &   (0.03566)         \\
- Line 14, : $(v_{1} + \beta_{1}x) \lambda$  (avg for exp = 1)& -1018.52662\sym{***}& -1688.76840\sym{***}\\
- Line 15, : & (227.95399)         & (290.85008)         \\
- Line 17, : $ d_{0} \neq d$     &     0.06007\sym{***}&     0.01720\sym{***}\\
- Line 18, : &   (0.00278)         &   (0.00421)         \\
- Line 20, : Exp2=1 $\times$ $ d_{0} \neq d$&     0.00000         &     0.00000         \\
- Line 23, : Exp3=1 $\times$ $ d_{0} \neq d$&     0.29492\sym{***}&                     \\
- Line 24, : &   (0.03401)         &                     \\
- Line 26, : Exp4=1 $\times$ $ d_{0} \neq d$&     0.25185\sym{***}&     0.30776\sym{***}\\
- Line 27, : &   (0.01690)         &   (0.01802)         \\
- Line 29, : Exp5=1 $\times$ $ d_{0} \neq d$&     0.21691\sym{***}&     0.25632\sym{***}\\
- Line 30, : &   (0.01093)         &   (0.01313)         \\
- Line 32, : $ CZ_{0} \neq CZ_{d}$&     0.00344\sym{***}&    -0.00120         \\
- Line 33, : &   (0.00051)         &   (0.00074)         \\
- Line 35, : lndist              &     0.00042\sym{**} &    -0.00004         \\
- Line 36, : &   (0.00019)         &   (0.00029)         \\
- Line 38, : urban               &    -0.00088         &     0.00020         \\
- Line 39, : &   (0.00064)         &   (0.00066)         \\
- Line 41, : suburban            &    -0.00277\sym{***}&    -0.00371\sym{***}\\
- Line 42, : &   (0.00041)         &   (0.00041)         \\
- Line 44, : Milwaukee           &     0.03039\sym{***}&     0.02732\sym{***}\\
- Line 45, : &   (0.00338)         &   (0.00352)         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/read_data_params.f90**

- Line 114, : if(share_low(1,j) >= 0.58385092) then
- Line 149, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1095, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1101, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_model_dataset_pre2011.do**

- Line 202, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 203, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 205, : replace Wage = 86.731818 if Wage > 86.731818
- Line 206, : replace Wage = 28.777456 if Wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/estimation_result/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_all_mean2_JPE.tex**

- Line 8, : budget (1,000)      &      0.0000         &      0.0000\sym{*}  &                     &                     &                     &      0.0000         &      0.0000\sym{***}&                     &                     &                     \\
- Line 9, : &    (0.0000)         &    (0.0000)         &                     &                     &                     &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 11, : capacity            &     -0.0000         &     -0.0000\sym{*}  &                     &                     &                     &     -0.0000         &     -0.0000\sym{***}&                     &                     &                     \\
- Line 12, : &    (0.0000)         &    (0.0000)         &                     &                     &                     &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.0000         &      0.0003\sym{*}  &      0.0000         &      0.0003         &      0.0003         &      0.0000\sym{**} &      0.0001\sym{***}&      0.0000\sym{**} &      0.0000         &      0.0000         \\
- Line 15, : &    (0.0000)         &    (0.0002)         &    (0.0000)         &    (0.0002)         &    (0.0002)         &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 17, : budget PT * $\lambda$&                     &     -0.0000\sym{*}  &                     &     -0.0000         &     -0.0000         &                     &     -0.0000\sym{**} &                     &     -0.0000         &     -0.0000         \\
- Line 18, : &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         \\
- Line 20, : budget/teacher (1,000)&                     &                     &      0.0000         &      0.0000         &      0.0000         &                     &                     &      0.0000         &      0.0000         &      0.0000         \\
- Line 21, : &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 23, : urban               &                     &                     &                     &                     &     -0.0000         &                     &                     &                     &                     &      0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0000         &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.0000         &                     &                     &                     &                     &     -0.0000\sym{**} \\
- Line 30, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 33, : R-squared           &       0.003         &       0.016         &       0.000         &       0.012         &       0.013         &       0.016         &       0.022         &       0.014         &       0.014         &       0.016         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/descriptives/Table_A3_PanelA.do**

- Line 57, : * Extract Pr_Omega2(1) (data is on the line itself: "0.49878 0.41879 Pr_Omega2( 1)")

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_all3_JPE.tex**

- Line 8, : budget (1,000)      &      0.0000\sym{***}&     -0.0000         &                     &                     &                     \\
- Line 9, : &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 11, : capacity            &      0.0000         &      0.0000\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.0000         &     -0.0003\sym{*}  &      0.0000         &     -0.0001         &     -0.0001         \\
- Line 15, : &    (0.0000)         &    (0.0001)         &    (0.0000)         &    (0.0002)         &    (0.0002)         \\
- Line 17, : budget PT * $\lambda$&                     &      0.0000\sym{*}  &                     &      0.0000         &      0.0000         \\
- Line 18, : &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         \\
- Line 20, : budget/teacher (1,000)&                     &                     &      0.0000\sym{***}&     -0.0000         &     -0.0000         \\
- Line 21, : &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 23, : urban               &                     &                     &                     &                     &      0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.0000\sym{**} \\
- Line 30, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 33, : R-squared           &       0.052         &       0.057         &       0.036         &       0.037         &       0.039         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_noninc4_JPE.tex**

- Line 8, : free budget/teacher (1,000)&      0.0000         &      0.0000\sym{**} &      0.0000\sym{*}  &      0.0000\sym{*}  \\
- Line 9, : &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 11, : $\lambda$           &      0.0000         &      0.0000         &      0.0000         &      0.0000         \\
- Line 12, : &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 14, : $\alpha0$           &     -0.0000         &     -0.0000         &     -0.0000         &     -0.0000         \\
- Line 15, : &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 17, : $\alpha1$           &     -0.0000         &      0.0000         &     -0.0000         &     -0.0000         \\
- Line 18, : &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 20, : urban               &                     &                     &                     &     -0.0000         \\
- Line 21, : &                     &                     &                     &    (0.0000)         \\
- Line 23, : suburban            &                     &                     &                     &     -0.0000         \\
- Line 24, : &                     &                     &                     &    (0.0000)         \\
- Line 26, : Milwaukee           &                     &                     &                     &     -0.0000         \\
- Line 27, : &                     &                     &                     &    (0.0000)         \\
- Line 30, : R-squared           &       0.018         &       0.017         &       0.023         &       0.024         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/budget_overtime.do**

- Line 13, : replace salary_round = 86.731818 if salary_round > 86.731818
- Line 14, : replace salary_round = 28.777456 if salary_round < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 886, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_noninc3_JPE.tex**

- Line 8, : free budget (1,000) &      0.0000         &      0.0000\sym{**} &                     &                     &                     \\
- Line 9, : &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 11, : free capacity       &     -0.0000\sym{**} &     -0.0000\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.0000         &      0.0001\sym{**} &      0.0000         &      0.0001\sym{*}  &      0.0002\sym{*}  \\
- Line 15, : &    (0.0000)         &    (0.0001)         &    (0.0000)         &    (0.0001)         &    (0.0001)         \\
- Line 17, : free budget PT * $\lambda$&                     &     -0.0000\sym{**} &                     &     -0.0000\sym{*}  &     -0.0000\sym{*}  \\
- Line 18, : &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         \\
- Line 20, : free budget/teacher (1,000)&                     &                     &      0.0000         &      0.0000\sym{*}  &      0.0000\sym{*}  \\
- Line 21, : &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 23, : urban               &                     &                     &                     &                     &     -0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.0000         \\
- Line 30, : &                     &                     &                     &                     &    (0.0000)         \\
- Line 33, : R-squared           &       0.022         &       0.034         &       0.015         &       0.022         &       0.024         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/main.f90**

- Line 248, : C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/main.f90**

- Line 248, : C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 886, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/Table_B8.tex**

- Line 8, : Black S             &      -0.000         &       0.000         \\
- Line 9, : &     (0.000)         &         (.)         \\
- Line 11, : Hisp S              &      -0.000         &      -0.000         \\
- Line 12, : &     (0.000)         &         (.)         \\
- Line 14, : Asian S             &      -0.000         &      -0.000         \\
- Line 15, : &     (0.000)         &         (.)         \\
- Line 17, : Black T             &       0.000         &      -0.000         \\
- Line 18, : &     (0.000)         &         (.)         \\
- Line 20, : Black T * Black S   &      -0.000         &       0.000         \\
- Line 21, : &     (0.000)         &         (.)         \\
- Line 23, : Hisp T              &      -0.000         &      -0.000         \\
- Line 24, : &     (0.000)         &         (.)         \\
- Line 26, : Hisp T * Hisp S     &       0.000         &       0.000         \\
- Line 27, : &     (0.000)         &         (.)         \\
- Line 29, : Asian T             &      -0.000         &       0.000         \\
- Line 30, : &     (0.000)         &         (.)         \\
- Line 32, : Asian T * Asian S   &      -0.000         &      -0.000         \\
- Line 33, : &     (0.000)         &         (.)         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/auxiliary_regressions/auxmodels_teachers_varobust.do**

- Line 81, : replace wage = 86.731818 if wage > 86.731818
- Line 82, : replace wage = 28.777456 if wage < 28.777456
- Line 201, : local C0 = r(mean) + 0.00000000000000001
- Line 203, : local C1 = r(mean) + 0.00000000000000001
- Line 205, : local exp = r(mean) + 0.00000000000000001
- Line 207, : local wage = r(mean) + 0.00001
- Line 297, : replace wage = 86.731818 if wage > 86.731818
- Line 298, : replace wage = 28.777456 if wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1095, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1101, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/estimation_result/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1095, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1101, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/aux_district_all2_JPE.tex**

- Line 8, : budget (1,000)      &      0.0000\sym{***}&     -0.0000         &                     &                     &                     &     -0.0000\sym{*}  &      0.0000\sym{*}  &                     &                     &                     \\
- Line 9, : &    (0.0000)         &    (0.0000)         &                     &                     &                     &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 11, : capacity            &      0.0000         &      0.0000\sym{**} &                     &                     &                     &     -0.0000         &     -0.0000\sym{**} &                     &                     &                     \\
- Line 12, : &    (0.0000)         &    (0.0000)         &                     &                     &                     &    (0.0000)         &    (0.0000)         &                     &                     &                     \\
- Line 14, : $\lambda$           &      0.0000         &     -0.0006\sym{*}  &      0.0000         &     -0.0002         &     -0.0001         &      0.0000\sym{*}  &      0.0000\sym{**} &      0.0000         &      0.0000         &      0.0000         \\
- Line 15, : &    (0.0000)         &    (0.0003)         &    (0.0000)         &    (0.0003)         &    (0.0003)         &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 17, : budget PT * $\lambda$&                     &      0.0000\sym{*}  &                     &      0.0000         &      0.0000         &                     &     -0.0000\sym{**} &                     &     -0.0000         &     -0.0000         \\
- Line 18, : &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         &                     &    (0.0000)         &                     &    (0.0000)         &    (0.0000)         \\
- Line 20, : budget/teacher (1,000)&                     &                     &      0.0000\sym{***}&     -0.0000         &      0.0000         &                     &                     &     -0.0000         &      0.0000         &      0.0000         \\
- Line 21, : &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         &                     &                     &    (0.0000)         &    (0.0000)         &    (0.0000)         \\
- Line 23, : urban               &                     &                     &                     &                     &      0.0000         &                     &                     &                     &                     &      0.0000         \\
- Line 24, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 26, : suburban            &                     &                     &                     &                     &      0.0000         &                     &                     &                     &                     &      0.0000         \\
- Line 27, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 29, : Milwaukee           &                     &                     &                     &                     &     -0.0000\sym{**} &                     &                     &                     &                     &     -0.0000         \\
- Line 30, : &                     &                     &                     &                     &    (0.0000)         &                     &                     &                     &                     &    (0.0000)         \\
- Line 33, : R-squared           &       0.050         &       0.054         &       0.035         &       0.035         &       0.037         &       0.012         &       0.015         &       0.009         &       0.010         &       0.013         \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/validation_result/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_model_dataset.do**

- Line 335, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 336, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 340, : replace Wage = 86.731818 if Wage > 86.731818
- Line 341, : replace Wage = 28.777456 if Wage < 28.777456
- Line 697, : replace wage = 86.731818 if wage > 86.731818
- Line 698, : replace wage = 28.777456 if wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/descriptives/appendix_figures.do**

- Line 152, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 153, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 155, : replace Wage = 86.731818 if Wage > 86.731818
- Line 156, : replace Wage = 28.777456 if Wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/validation_result/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do**

- Line 173, : keep if C0 >= seed_C0 + 0.00000000000000001 & ///
- Line 174, : C1 >= seed_C1 + 0.00000000000000001 & ///
- Line 175, : exp >= seed_exp + 0.00000000000000001 & ///
- Line 176, : wage <= seed_wage + 0.00001 & masterup >= seed_masterup

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/inner_loop_one.f90**

- Line 443, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 1125, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
- Line 1131, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/1_baseline/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_model_dataset_info1.do**

- Line 249, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 250, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 254, : replace Wage = 86.731818 if Wage > 86.731818
- Line 255, : replace Wage = 28.777456 if Wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/inner_loop_one.f90**

- Line 415, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 887, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/build/build_model_dataset_info3.do**

- Line 250, : replace wage`d' = 86.731818 if wage`d' > 86.731818
- Line 251, : replace wage`d' = 28.777456 if wage`d' < 28.777456
- Line 255, : replace Wage = 86.731818 if Wage > 86.731818
- Line 256, : replace Wage = 28.777456 if Wage < 28.777456

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/2_rigid/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/2_rigid/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/2_rigid/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/1_baseline/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/stderr/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/1_baseline/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/validation_result/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/main.f90**

- Line 248, : !      C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : !      C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/perturbation/read_data_params.f90**

- Line 114, : if(share_low(1,j) >= 0.58385092) then
- Line 149, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/main.f90**

- Line 248, : C1_period(k,i) = C1_period(k,i) + 0.0068
- Line 249, : C2_period(k,i) = C2_period(k,i) + 0.0009
- Line 252, : C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
- Line 253, : C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
- Line 256, : C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
- Line 257, : C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
- Line 260, : C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
- Line 261, : C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
- Line 264, : C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
- Line 265, : C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/aux_model.f90**

- Line 582, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 586, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 587, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/read_data_params.f90**

- Line 135, : if(share_low(1,j) >= 0.58385092) then
- Line 173, : subsidy_upper = 2*6.566 !cap at 2sd
- Line 1228, : !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1263, : !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
- Line 1349, : !if (abs(wageschedule(i,j) - tval) > 0.0001) then
- Line 1438, : -1.726586 * age2 + &
- Line 1439, : -1.918916 * age3 + &
- Line 1440, : 0.7195059 * age4 + &
- Line 1441, : 1.480628  * age5 + &
- Line 1443, : -1.905028 * exp3 + &
- Line 1444, : -2.334365 * exp4 + &
- Line 1445, : -2.210456 * exp5 + &
- Line 1446, : -1.641332 * exp6 + &
- Line 1448, : 0.1716359 * master_per + &
- Line 1449, : -4.867485 * C1_per + &
- Line 1450, : 2.958172  * C2_per + &
- Line 1452, : -2.518655  * age1 * exp2          + &
- Line 1453, : -0.5922871 * age1 * exp3          + &
- Line 1454, : 0.3767474  * age1 * exp3 * master_per + &
- Line 1455, : 0.1986678  * age1 * exp4 * master_per + &
- Line 1456, : -1.167858  * age2 * exp2          + &
- Line 1457, : 1.423465   * age2 * exp3          + &
- Line 1458, : -0.522141  * age2 * exp3 * master_per + &
- Line 1459, : 1.70768    * age2 * exp4          + &
- Line 1460, : -0.4261816 * age2 * exp4 * master_per + &
- Line 1461, : 1.416716   * age2 * exp5          + &
- Line 1462, : -0.6827148 * age2 * exp5 * master_per + &
- Line 1463, : -0.1266752 * age2 * exp6 * master_per + &
- Line 1464, : 0.2026788  * age2        * master_per + &
- Line 1465, : 1.476243   * age3 * exp3          + &
- Line 1466, : 0.6647152  * age3 * exp3 * master_per + &
- Line 1467, : 1.213979   * age3 * exp4          + &
- Line 1468, : -0.0508234 * age3 * exp4 * master_per + &
- Line 1469, : 1.66701    * age3 * exp5          + &
- Line 1470, : -0.3510542 * age3 * exp5 * master_per + &
- Line 1471, : -0.1017505 * age3 * exp6 * master_per + &
- Line 1472, : -1.21639   * age4 * exp4 * master_per + &
- Line 1473, : -0.1618628 * age4 * exp5          + &
- Line 1474, : -0.6211308 * age4 * exp5 * master_per + &
- Line 1475, : -0.2079674 * age4 * exp6 * master_per + &
- Line 1476, : 0.3041041  * age5 * exp5 * master_per + &
- Line 1478, : -13.84134 * exp3 * master_per * C1_per + &
- Line 1479, : 15.31195  * exp3 * master_per * C2_per + &
- Line 1480, : -9.065213 * exp4 * master_per * C1_per + &
- Line 1481, : 4.498231  * exp4 * master_per * C2_per + &
- Line 1482, : -7.541903 * exp5 * master_per * C1_per + &
- Line 1483, : 6.049184  * exp5 * master_per * C2_per + &
- Line 1484, : 1.348466  * exp6 * master_per * C1_per + &
- Line 1485, : -1.067225 * exp6 * master_per * C2_per + &
- Line 1488, : !(-0.1106883)  + & !Y8  (2013?)
- Line 1489, : (-0.1253728)  + & !Y9  (2014?)
- Line 1490, : (-0.3346778) ! constant term
- Line 1584, : 0.0325744 * age2 + &
- Line 1585, : 0.0379624 * age3 + &
- Line 1586, : 0.2772404 * age4 + &
- Line 1587, : -17.3495  * age5 + &
- Line 1589, : -1.25937 * exp2 + &
- Line 1590, : -2.332426 * exp3 + &
- Line 1591, : -2.979173 * exp4 + &
- Line 1592, : -5.143154 * exp5 + &
- Line 1593, : -6.085858 * exp6 + &
- Line 1595, : 11.52152 * master_per + &
- Line 1602, : -1.37441 * age1 * exp3          + &
- Line 1605, : 4.939774  * age1 * exp6          + &
- Line 1606, : -11.97605 * age1        * master_per + &
- Line 1614, : -1.653275 * age2 * exp5 * master_per + &
- Line 1617, : -11.44638 * age2        * master_per + &
- Line 1627, : -12.06308 * age3        * master_per + &
- Line 1629, : -16.82645  * age4 * exp3 * master_per + &
- Line 1630, : -20.74089  * age4 * exp4 * master_per + &
- Line 1632, : -19.35871 * age4 * exp5 * master_per + &
- Line 1633, : -19.09953 * age4 * exp6 * master_per + &
- Line 1634, : 7.995786 * age4        * master_per + &
- Line 1636, : 6.118267    * age5 * exp6 + &
- Line 1639, : 3.296729 * exp3 * master_per * C1_per + &
- Line 1640, : 15.35585 * exp3 * master_per * C2_per + &
- Line 1641, : -1.349531 * exp4 * master_per * C1_per + &
- Line 1642, : 1.904872 * exp4 * master_per * C2_per + &
- Line 1643, : -10.67493 * exp5 * master_per * C1_per + &
- Line 1644, : 14.01958 * exp5 * master_per * C2_per + &
- Line 1645, : -4.974793 * exp6 * master_per * C1_per + &
- Line 1646, : -1.564769 * exp6 * master_per * C2_per + &
- Line 1650, : !(-1.510012)  + & !Y8  (2013?)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/aux_model.f90**

- Line 613, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 617, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 618, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/aux_model.f90**

- Line 571, : !  can't have zeros in reg, weight to 0.0000000001 instead
- Line 575, : !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
- Line 576, : !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/random.f90**

- Line 26, : REAL(8) :: zigdn=3.442619855899d0,zigtn=3.442619855899d0,zigvn=0.00991256303526217d0, &
- Line 27, : zigq,zigde=7.697117470131487d0,zigte=7.697117470131487d0,zigve=0.003949659822581572d0
- Line 50, : zigdn=3.442619855899d0
- Line 51, : zigtn=3.442619855899d0
- Line 52, : zigvn=0.00991256303526217d0
- Line 53, : zigde=7.697117470131487d0
- Line 54, : zigte=7.697117470131487d0
- Line 55, : zigve=0.003949659822581572d0
- Line 129, : REAL(8), PARAMETER ::  r = 3.442620d0
- Line 141, : x = -0.2904764d0*LOG(Sample_Uniform(0.0d0,1.0d0))
- Line 181, : Sample_Exponential = (7.69711 - LOG(Sample_Uniform(0.0d0,1.0d0)))*a
- Line 228, : IF (u < 1.0d0 - 0.0331d0*x**4) THEN
- Line 264, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Mixture_Normal')
- Line 292, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) CALL NRERROR('weights have to add to one: Sample_Truncated_Mixture_Normal')
- Line 387, : IF ((SUM(p)>1.0000001d0).OR.(SUM(p)<0.9999999d0)) &
- Line 411, : REAL(8),PARAMETER :: t1=0.375D0,t2=2.18D0,t3=0.725D0
- Line 414, : eps=2.220446049250313D-016
- Line 594, : REAL(8), PARAMETER :: p0=220.2068679123761D0,p1=221.2135961699311D0,p2=112.0792914978709D0, &
- Line 595, : p3 = 33.91286607838300D0,p4 = 6.373962203531650D0,p5 = .7003830644436881D0, &
- Line 596, : p6 = .3526249659989109D-01,q0 = 440.4137358247522D0,q1 = 793.8265125199484D0, &
- Line 597, : q2 = 637.3336333788311D0,q3 = 296.5642487796737D0,q4 = 86.78073220294608D0, &
- Line 598, : q5=16.06417757920695D0,q6=1.755667163182642D0,q7=.8838834764831844D-1,cutoff = 7.071D0, &
- Line 599, : logroot2pi = 0.918938533204672780563271317078D0
- Line 652, : REAL(8), PARAMETER :: ZERO=0.D0, ONE = 1.D0, HALF = 0.5D0,SPLIT1 = 0.425D0, SPLIT2 = 5.D0, &
- Line 653, : CONST1 = 0.180625D0, CONST2 = 1.6D0
- Line 655, : REAL(8), PARAMETER :: A0 = 3.3871328727963666080D0,A1=1.3314166789178437745D+2, &
- Line 656, : A2=1.9715909503065514427D+3,A3=1.3731693765509461125D+4,A4=4.5921953931549871457D+4, &
- Line 657, : A5=6.7265770927008700853D+4,A6=3.3430575583588128105D+4,A7=2.5090809287301226727D+3, &
- Line 658, : B1=4.2313330701600911252D+1,B2=6.8718700749205790830D+2,B3=5.3941960214247511077D+3, &
- Line 659, : B4=2.1213794301586595867D+4,B5=3.9307895800092710610D+4,B6=2.8729085735721942674D+4, &
- Line 660, : B7=5.2264952788528545610D+3
- Line 662, : REAL(8), PARAMETER :: C0=1.42343711074968357734D0,C1=4.63033784615654529590D0, &
- Line 663, : C2=5.76949722146069140550D0,C3=3.64784832476320460504D0,C4=1.27045825245236838258D0, &
- Line 664, : C5=2.41780725177450611770D-1,C6=2.27238449892691845833D-2,C7=7.74545014278341407640D-4, &
- Line 665, : D1=2.05319162663775882187D0,D2=1.67638483018380384940D0,D3=6.89767334985100004550D-1, &
- Line 666, : D4=1.48103976427480074590D-1,D5=1.51986665636164571966D-2,D6=5.47593808499534494600D-4, &
- Line 667, : D7=1.05075007164441684324D-9
- Line 669, : REAL(8), PARAMETER :: E0=6.65790464350110377720D0,E1=5.46378491116411436990D0, &
- Line 670, : E2=1.78482653991729133580D0,E3=2.96560571828504891230D-1,E4=2.65321895265761230930D-2, &
- Line 671, : E5=1.24266094738807843860D-3,E6=2.71155556874348757815D-5,E7=2.01033439929228813265D-7, &
- Line 672, : F1=5.99832206555887937690D-1,F2=1.36929880922735805310D-1,F3=1.48753612908506148525D-2, &
- Line 673, : F4=7.86869131145613259100D-4,F5=1.84631831751005468180D-5,F6=1.42151175831644588870D-7, &
- Line 674, : F7=2.04426310338993978564D-15

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 886, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/paper_appendix/Online_Appendix_Sept2025.tex**

- Line 1, : %2multibyte Version: 5.50.0.2960 CodePage: 932
- Line 17, : %TCIDATA{Version=5.50.0.2960}
- Line 581, : of Table 2 in the main text), the $R^{2}$ is barely improved (from 0.68 to 0.681).
- Line 729, : (with a standard error of 0.001) and an R$^{2}$ of 0.99.
- Line 1640, : exp $\in[1,2]$ & 0.0068 & 0.0009\\
- Line 1641, : exp $\in[3,4]$ & 0.0154 & 0.0057\\
- Line 1642, : exp $\in[5,9]$ & 0.0117 & 0.0028\\
- Line 1643, : exp $\in[10,14]$ & 0.0117 & 0.0049\\
- Line 1644, : exp $\in[15,+\infty)$ & 0.0112 & 0.0038\\\hline
- Line 1645, : R$^{2}$ & 0.677 & 0.625\\\hline\hline
- Line 1658, : min & -0.1398 & -0.1988\\
- Line 1659, : p1 & -0.0630 & -0.0779\\
- Line 1660, : p5 & -0.0345 & -0.0417\\
- Line 1661, : p10 & -0.0225 & -0.0278\\
- Line 1662, : p25 & -0.0049 & -0.0075\\
- Line 1663, : median & 0.0115 & -0.0108\\
- Line 1664, : mean & 0.0116 & 0.0110\\
- Line 1665, : p75 & 0.0282 & 0.0300\\
- Line 1666, : p90 & 0.0454 & 0.0503\\
- Line 1667, : p95 & 0.0582 & 0.0664\\
- Line 1668, : p99 & 0.0894 & 0.0978\\
- Line 1669, : max & 0.1532 & 0.2362\\\hline\hline
- Line 1688, : $\Delta c_{0}$ & 1.204\ifmmode^***\else$^{***}$\fi &  & 0.365 & \\
- Line 1689, : & (0.072) &  & (0.250) & \\
- Line 1690, : $\Delta c_{1}$ &  & 0.905\ifmmode^***\else$^{***}$\fi &  & 0.394\\
- Line 1691, : &  & (0.164) &  & (0.286)\\
- Line 1741, : {\small wage} & {\small 0.001 (0.0002)} & {\small 0.002 (0.0003)} &
- Line 1742, : {\small -0.00002 (0.000002))} & {\small -0.00002 (0.000003)}\\
- Line 1743, : ${\small e}^{\lambda_{d}}$ & {\small -0.002 (0.008)} & {\small 0.011 (0.010)}
- Line 1744, : & {\small -0.0001 (0.0001)} & {\small -0.0002 (0.0001)}\\
- Line 1746, : {\small 0.178 (0.496)} & {\small -0.02 (0.006)} & {\small -0.02 (0.015)}\\
- Line 1748, : {\small -0.83 (0.02)} & {\small -0.98 (0.002)} & {\small -0.98 (0.002)}\\
- Line 1751, : $I\left(  d\neq d_{0}\right)  \times${\small exp $\in[4,5]$} & {\small 0.267
- Line 1752, : (0.031)} & {\small 0.317 (0.039)} & {\small 0.236 (0.026)} & {\small 0.237
- Line 1753, : (0.027)}\\
- Line 1754, : $I\left(  d\neq d_{0}\right)  \times${\small exp $\in[6,10]$} & {\small 0.085
- Line 1755, : (0.013)} & {\small 0.099 (0.016)} & {\small 0.099 (0.010)} & {\small 0.095
- Line 1756, : (0.010)}\\
- Line 1757, : $I\left(  d\neq d_{0}\right)  \times${\small exp $\in[11,15]$} & {\small 0.020
- Line 1758, : (0.011)} & {\small 0.009 (0.011)} & {\small 0.014 (0.005} & {\small 0.012
- Line 1759, : (0.005)}\\
- Line 1760, : ${\small I}\left(  z_{d}\neq z_{d_{0}}\right)  $ & {\small -0.0269 (0.005)} &
- Line 1761, : {\small -0.0357 (0.007)} & {\small -0.0004 (0.0001)} & {\small -0.0001
- Line 1762, : (0.00002)}\\
- Line 1763, : {\small ln(distance)} & {\small -0.019 (0.0019)} & {\small -0.019 (0.0026)} &
- Line 1764, : {\small -0.0001 (0.00002)} & {\small -0.0001 (0.00002)}\\
- Line 1765, : $q_{d}:$ {\small urban} & {\small 0.01 (0.002)} & {\small 0.003 (0.003)} &
- Line 1766, : {\small 0.004 (0.0002)} & {\small 0.003 (0.0002)}\\
- Line 1767, : $q_{d}:$ {\small suburban} & {\small 0.01 (0.002)} & {\small 0.011 (0.002)} &
- Line 1768, : {\small 0.001 (0.0001)} & {\small 0.001 (0.0001)}\\
- Line 1770, : {\small 0.01 (0.002)} & {\small 0.01 (0.002)}\\\hline
- Line 1818, : All students & 0.1680 & 0.1370 & 22.61\%\\
- Line 1819, : $\tau_{k}=1$ & 0.1922 & 0.1552 & 23.87\%\\
- Line 1820, : $\tau_{k}=2$ & 0.1438 & 0.1189 & 20.97\%\\\hline\hline
- Line 1837, : Black S & -0.056\ifmmode^\ast\ast\ast\else$^{\ast\ast\ast}$\fi &
- Line 1838, : -0.067\ifmmode^\ast\ast\ast\else$^{\ast\ast\ast}$\fi\\
- Line 1839, : & (0.003) & (0.003)\\[1em]%
- Line 1840, : Hisp S & -0.007\ifmmode^\ast\ast\else$^{\ast\ast}$\fi & -0.022\ifmmode^\ast
- Line 1842, : & (0.003) & (0.003)\\[1em]%
- Line 1843, : Asian S & 0.053\ifmmode^\ast\ast\ast\else$^{\ast\ast\ast}$\fi &
- Line 1844, : 0.081\ifmmode^\ast\ast\ast\else$^{\ast\ast\ast}$\fi\\
- Line 1845, : & (0.004) & (0.004)\\[1em]%
- Line 1846, : Black T & -0.001 & 0.0001\\
- Line 1847, : & (0.005) & (0.005)\\[1em]%
- Line 1848, : Black T * Black S & -0.008 & -0.019\ifmmode^\ast\else$^{\ast}$\fi\\
- Line 1849, : & (0.006) & (0.010)\\[1em]%
- Line 1850, : Hisp T & -0.010\ifmmode^\ast\else$^{\ast}$\fi & -0.006\\
- Line 1851, : & (0.005) & (0.005)\\[1em]%
- Line 1852, : Hisp T * Hisp S & 0.007 & 0.008\\
- Line 1853, : & (0.007) & (0.009)\\[1em]%
- Line 1854, : Asian T & 0.003 & 0.004\\
- Line 1855, : & (0.007) & (0.008)\\[1em]%
- Line 1856, : Asian T * Asian S & 0.015 & 0.022\\
- Line 1857, : & (0.017) & (0.016)\\\hline
- Line 1926, : wage & 0.0012*** &  & 0.0017*** & 0.0018*** & 0.0028*** &  & 0.00172*** &
- Line 1927, : 0.00177*** & 0.00280*** & \\
- Line 1928, : & (0.0002) &  & (0.0002) & (0.0002) & (0.0002) &  & (0.0002) & (0.0002) &
- Line 1929, : (0.0002) & \\
- Line 1930, : $e_{d}^{\lambda}$ & -0.0024 &  & -0.0230** & -0.0177 & -0.0416*** &  &
- Line 1931, : -0.0137 & -0.00835 & -0.00671 & \\
- Line 1932, : & (0.0084) &  & (0.0114) & (0.0148) & (0.0154) &  & (0.0093) & (0.0095) &
- Line 1933, : (0.0076) & \\
- Line 1934, : $c_{1}\times\lambda_{d}$ & 0.5680** &  & 1.0365*** & 0.6565** & 0.8840*** &  &
- Line 1935, : 1.025*** & 0.792** & 0.826*** & \\
- Line 1936, : & (0.2828) &  & (0.2964) & (0.3086) & (0.2386) &  & (0.3029) & (0.3122) &
- Line 1937, : (0.2830) & \\
- Line 1938, : $d\neq d_{0}$ & -0.8259*** &  & -0.7984*** & -0.7969*** & -0.7843*** &  &
- Line 1939, : -0.799*** & -0.797*** & -0.786*** & \\
- Line 1940, : & (0.0122) &  & (0.0138) & (0.0135) & (0.0148) &  & (0.0138) & (0.0135) &
- Line 1941, : (0.0148) & \\
- Line 1942, : $d\neq d_{0} \times$ untenured & 0.4762*** &  & 0.3233*** & 0.3819*** &
- Line 1943, : 0.3117*** &  & 0.324*** & 0.382*** & 0.314*** & \\
- Line 1944, : & (0.0981) &  & (0.1194) & (0.1195) & (0.1171) &  & (0.1193) & (0.1194) &
- Line 1945, : (0.1169) & \\
- Line 1946, : $d\neq d_{0} \times$ exp & 0.2675*** &  & 0.2725*** & 0.2953*** & 0.2853*** &
- Line 1947, : & 0.273*** & 0.295*** & 0.286*** & \\
- Line 1948, : & (0.0314) &  & (0.0322) & (0.0336) & (0.0337) &  & (0.0322) & (0.0336) &
- Line 1949, : (0.0337) & \\
- Line 1950, : $d\neq d_{0} \times$exp$\in[6,10]$ & 0.0847*** &  & 0.0791*** & 0.0875*** &
- Line 1951, : 0.0849*** &  & 0.0793*** & 0.0874*** & 0.0852*** & \\
- Line 1952, : & (0.0126) &  & (0.0130) & (0.0127) & (0.0134) &  & (0.0130) & (0.0127) &
- Line 1953, : (0.0134) & \\
- Line 1954, : $d\neq d_{0} \times$exp$\in[11,15]$ & 0.0204* &  & 0.0173 & 0.0308** &
- Line 1955, : 0.0084 &  & 0.0175 & 0.0309** & 0.00929 & \\
- Line 1956, : & (0.0114) &  & (0.0118) & (0.0123) & (0.0109) &  & (0.0118) & (0.0123) &
- Line 1957, : (0.0109) & \\
- Line 1958, : $z_{d}\neq z_{d_{0}}$ & -0.0269*** &  & -0.0307*** & -0.0310*** & -0.0345*** &
- Line 1959, : & -0.0307*** & -0.0311*** & -0.0347*** & \\
- Line 1960, : & (0.0048) &  & (0.0059) & (0.0059) & (0.0068) &  & (0.0059) & (0.0059) &
- Line 1961, : (0.0068) & \\
- Line 1962, : urban & 0.0138*** &  & 0.0243*** & 0.0225*** & 0.0205*** &  & 0.0243*** &
- Line 1963, : 0.0225*** & 0.0209*** & \\
- Line 1964, : & (0.0021) &  & (0.0027) & (0.0026) & (0.0031) &  & (0.0027) & (0.0026) &
- Line 1965, : (0.0031) & \\
- Line 1966, : suburban & 0.0115*** &  & 0.0103*** & 0.0123*** & 0.0021 &  & 0.0102*** &
- Line 1967, : 0.0122*** & 0.0021 & \\
- Line 1968, : & (0.0021) &  & (0.0022) & (0.0022) & (0.0025) &  & (0.0022) & (0.0022) &
- Line 1969, : (0.0025) & \\
- Line 1970, : ln(distance) & -0.0194*** &  & -0.0227*** & -0.0241*** & -0.0237*** &  &
- Line 1971, : -0.0227*** & -0.0241*** & -0.0235*** & \\
- Line 1972, : & (0.0019) &  & (0.0021) & (0.0021) & (0.0024) &  & (0.0021) & (0.0021) &
- Line 1973, : (0.0024) & \\
- Line 1974, : large metro & 0.0962*** &  & 0.0855*** & 0.0866*** & 0.0798*** &  &
- Line 1975, : 0.0844*** & 0.0858*** & 0.0751** & \\
- Line 1976, : & (0.0278) &  & (0.0280) & (0.0273) & (0.0303) &  & (0.0280) & (0.0273) &
- Line 1977, : (0.0303) & \\
- Line 2001, : {\small wage} & {\small 0.001 (0.0002)} & {\small 0.002 (0.0003)}\\
- Line 2002, : ${\small e}^{\lambda_{d}}$ & {\small -0.002 (0.008)} & {\small -0.008
- Line 2003, : (0.012)\\
- Line 2016, : ${\small I}\left(  z_{d}\neq z_{d_{0}}\right)  $ & {\small -0.03 (0.005)} &
- Line 2017, : {\small -0.04 (0.007)}\\
- Line 2018, : {\small ln(distance)} & {\small -0.02 (0.002)} & {\small -0.02 (0.003)}\\
- Line 2019, : $q_{d}:$ {\small urban} & {\small 0.01 (0.002)} & {\small 0.003 (0.003)}\\
- Line 2020, : $q_{d}:$ {\small suburban} & {\small 0.01 (0.002)} & {\small 0.01 (0.003)}\\
- Line 2043, : Experience      &   13.896&   14.817&   -0.921&    0.001\\
- Line 2044, : Master's        &    0.639&    0.500&    0.139&    0.000\\
- Line 2045, : c1              &   -0.012&    0.018&   -0.030&    0.000\\
- Line 2046, : c2              &   -0.015&    0.018&   -0.033&    0.000\\
- Line 2246, : {\small districts} & 0.52 & 0.003 & 0.66 & 0.39\\
- Line 2358, : {\small Fr(experience 3-4)} & {\small 0.01} & {\small 0.001} &  &  &
- Line 2362, : {\small Fr(experience 10-14)} & {\small -0.004} & {\small 0.008} &  &  &
- Line 2364, : {\small Fr(experience }$\geq15${\small )} & {\small 0.03} & {\small -0.0001} &
- Line 2366, : {\small Fr(MA or above)} & {\small -0.03} & {\small -0.004} &  &  &
- Line 2373, : ${\small \lambda}_{d}$ & {\small 0.001} & {\small 0.01} &  &  & {\small 25.24}
- Line 2375, : {\small budget per teacher} & {\small 0.002} & {\small 0.001*} &  &  &
- Line 2377, : {\small capacity} & {\small -0.00002} & {\small 0.0001} &  &  & {\small -0.35}
- Line 2381, : {\small suburban} & {\small -0.02} & {\small -0.004*} &  &  & {\small 2.59} &
- Line 2383, : {\small large metro} & {\small 0.02} & {\small -0.056} &  &  & {\small 97.94}
- Line 2392, : {\small 143.830} & {\small 5.19}\\
- Line 2409, : {\small wage} & \ \ \ \ \ \  & {\small 0.001} & {\small 0.001} &  &  &  &
- Line 2411, : ${\small e}^{\lambda_{d}}$ & \ \ \ \ \ \  & {\small -0.017} & {\small -0.003}
- Line 2412, : &  &  &  & {\small -0.0002} & {\small -0.0001}\\
- Line 2414, : {\small 0.42} &  &  &  & {\small 0.005} & {\small -0.0003}\\
- Line 2424, : {\small 0.02} & {\small 0.01} &  &  &  & {\small 0.01} & {\small -0.0002}\\
- Line 2426, : {\small -0.003} & {\small -0.01} &  &  &  & {\small -0.0001} &
- Line 2427, : {\small -0.0003}\\
- Line 2428, : {\small ln(distance)} & \ \ \ \ \ \  & {\small -0.009} & {\small -0.004} &  &
- Line 2429, : &  & {\small -0.00003} & {\small 0.00001}\\
- Line 2430, : $q_{d}:$ {\small urban} & \ \ \ \ \ \  & {\small 0.008} & {\small -0.001} &  &
- Line 2431, : &  & {\small 0.002} & {\small 0.001}\\
- Line 2432, : $q_{d}:$ {\small suburban} & \ \ \ \ \ \  & {\small 0.003} & {\small 0.001} &
- Line 2433, : &  &  & {\small 0.001} & {\small 0.001}\\
- Line 2434, : $q_{d}:$ {\small large metro} & \ \ \ \ \ \  & {\small 0.04} & {\small -0.003}
- Line 2435, : &  &  & {\small \ \ \ \ \ \ } & {\small 0.009} & {\small 0.0004}\\\hline\hline\end{tabular}

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/1_baseline/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/inner_loop_one.f90**

- Line 409, : h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
- Line 881, : call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/read_data_params.f90**

- Line 108, : if(share_low(1,j) >= 0.58385092) then
- Line 143, : subsidy_upper = 2*6.566 !cap at 2sd

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/nrutil.f90**

- Line 3, : REAL(8), PARAMETER :: NR_PI = 3.1415926535897932384626433832d0
- Line 4, : REAL(8), PARAMETER :: NR_2PI =  6.2831853071795864769252867664d0
- Line 5, : REAL(8), PARAMETER :: NR_SQRT2PI =  2.506628274631000502415765284779d0
- Line 6, : REAL(8), PARAMETER :: NR_EPS = 2.220446049250313E-016
- Line 722, : REAL(8) :: stp = 2.5066282746310005d0
- Line 723, : REAL(8), DIMENSION(6) :: coef = (/76.18009172947146d0,-86.50532032941677d0, &
- Line 724, : 24.01409824083091d0,-1.231739572450155d0,0.1208650973866179d-2,-0.5395239384953d-5/),aux
- Line 734, : NR_gammln=tmp+LOG(stp*(1.000000000190015d0+&
- Line 754, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012
- Line 784, : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/out_synth/tables/Table_B13.tex**

- Line 8, : Experience      &    1.850&   14.305&  -12.455&    0.000\\
- Line 9, : Master's        &    0.501&    0.500&    0.001&    0.969\\
- Line 10, : c1              &   -0.000&   -0.000&    0.000&    0.000\\
- Line 11, : c2              &    0.000&    0.000&   -0.000&    0.000\\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220349-1/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/simplex_salvador_equilibrium.f90**

- Line 51, : if (j==1)  step = 0.050
- Line 52, : if (j==2)  step = 0.200
- Line 53, : if (j==3)  step = 0.200
- Line 54, : if (j==4)  step = 0.200
- Line 55, : if (j==5)  step = 0.200
- Line 56, : if (j==6)  step = 0.200
- Line 57, : if (j==7)  step = 0.100
- Line 58, : if (j==8)  step = 0.200
- Line 59, : if (j==9)  step = 0.200
- Line 60, : if (j==10) step = 0.200
- Line 61, : if (j==11) step = 0.200
- Line 62, : if (j==12) step = 0.200
- Line 63, : if (j==13) step = 0.200
- Line 64, : if (j==14) step = 0.200
- Line 65, : if (j==15) step = 0.100
- Line 66, : if (j==16) step = 0.100
- Line 67, : if (j==17) step = 0.100
- Line 68, : if (j==18) step = 0.200
- Line 69, : if (j==19) step = 0.200
- Line 70, : if (j==20) step = 0.200
- Line 71, : if (j==21) step = 0.200
- Line 72, : if (j==22) step = 0.200

