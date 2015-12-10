
SET I /AGR,MAN,SER/;

PARAMETER
Y0(I)      output
K0(I)
L0(I)
PY0(i)
W0(I)
RK0(I)
;

$CALL GDXXRW i=data.xlsx NC=0 o=DATA.gdx index=indexsheet!A1
$gdxin DATA.gdx

$LOAD K0 L0
$gdxin
$ontext
L0("AGR")=30;
L0("MAN")=21;
L0("SER")=39;


K0("AGR")=365;
K0("MAN")=98;
K0("SER")=22;
$offtext
Y0(I)=K0(I)+L0(I);
PY0(I)=1;
W0(I)=1;
RK0(I)=1;

*---CALIBRATION
PARAMETER
Beta(i)
alpha(i)
A0(I)
al(i)
ak(i)
RHOH(I)
SIGMA(I)
;
SIGMA(I)=0.3;
RHOH(I)=(SIGMA(I)-1)/SIGMA(I);

         ALPHA(I)=RK0(I)*K0(I)**(1-RHOH(I))
         /(W0(I)*L0(I)**(1-RHOH(I))+RK0(I)* K0(I)**(1-RHOH(I)));

         BETA(I)=W0(I)*L0(I)**(1-RHOH(I))
         /(W0(I)*L0(I)**(1-RHOH(I))+RK0(I)*K0(I)**(1-RHOH(I)));

          A0(I)=Y0(I)/(ALPHA(I)*K0(I)**RHOH(I)+BETA(I)*L0(I)**RHOH(I))**(1/RHOH(I));

         al(i)=a0(i);
         ak(i)=a0(i);

VARIABLES
Y(I)
L(I)
K(I)
PY(I)
W(I)
RK(I)
KS(I)
LS(I)
OBJ
;

         Y.L(I)=Y0(I);
         L.L(I)=L0(I);
         K.L(I)=K0(I);
         PY.L(I)=1;
         W.L(I)=1;
         RK.L(I)=1;
         LS.L(I)=L0(I);
         KS.L(I)=K0(I);
         OBJ.L=1;

EQUATION
EQUY(I)
EQUL(I)
EQUK(I)
EQUKS(I)
EQULS(I)
EQURK(I)
EQUW(I)
EQUOBJ
;


EQUY(I)..        Y(I)=E=A0(i)*[ALPHA(I)*K(I)**RHOH(I)+BETA(I)*L(I)**RHOH(I)]**(1/RHOH(I)) ;

EQUL(I)..        L(I)=E=(Al(I)**RHOH(I)*BETA(I)*PY(I)/W(I))**(1/(1-RHOH(I)))*Y(I);

EQUK(I)..        K(I)=E=(Ak(I)**RHOH(I)*ALPHA(I)*PY(I)/RK(I))**(1/(1-RHOH(I)))*Y(I);

EQUKS(I)..       KS(I)=E=K(I);

EQULS(I)..       L(I)=E=LS(I);

EQUW(I)..       W(I)=E=PY(I)*A0(I)**RHOH(I)*[1-ALPHA(I)]*[Y(I)/L(I)]**(1-RHOH(I));

EQURK(I)..      RK(I)=E=  PY(I)*A0(I)**RHOH(I)*(Y(I)/L(I))**(1-RHOH(I));

EQUOBJ..         OBJ=E=1;

MODEL PRODCD
/
EQUY
EQUL
EQUK
EQUKS
EQULS
EQUOBJ
*EQURK
*EQUW
/;

PY.FX(I)=1;
*W.FX(I)=1;
*RK.FX(I)=1;
KS.FX(I)=K0(I);
LS.FX(I)=L0(I);


OPTION NLP=CONOPT2;

SOLVE PRODCD MAXIMIZING OBJ USING NLP
;


*W.FX(I)=1.1;
KS.FX(i)=K0(i)*1.25;
*LS.FX(i)=L0(i)*1.25;

*ak(i)=ak(i)*1.25;
SOLVE PRODCD MAXIMIZING OBJ USING NLP

parameter
perdiff(*,i)
Perdiff1(*);

perdiff("change in capital",i)= (k.l(i)/k0(i)-1)*100+eps;
perdiff("change in wage",i)= (w.l(i)/w0(i)-1)*100+eps;
perdiff("change in rent of capital",i)= (rk.l(i)/rk0(i)-1)*100+eps;
perdiff("change in labour",i)= (l.l(i)/l0(i)-1)*100+eps;
perdiff("change in output",i)= (y.l(i)/y0(i)-1)*100+eps;
perdiff1("total capital")=(sum(i,k.l(i))/sum(i,k0(i))-1)*100+eps;
perdiff1("total wage")=(sum(i,w.l(i))/sum(i,w0(i))-1)*100+eps;
perdiff1("total rent of capital")=(sum(i,rk.l(i))/sum(i,rk0(i))-1)*100+eps;
perdiff1("total labour")=(sum(i,l.l(i))/sum(i,l0(i))-1)*100+eps;
perdiff1("total output")=(sum(i,y.l(i))/sum(i,y0(i))-1)*100+eps;
*$ontext
execute_unload "result.gdx" perdiff   perdiff1

execute 'gdxxrw.exe Result.gdx par=PERDIFF   RNG=Test!A1'
execute 'gdxxrw.exe Result.gdx par=PERDIFF1  rdim=1 RNG=Test!A9'   

*$offtext

