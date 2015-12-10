
SET I/AGR,MAN,SER/;

PARAMETER
Y0(I)
K0(I)
L0(I)
PY0(i)
W0(I)
RK0(I)
;

Y0(I)=100;
L0(I)=50;
K0(I)=50;
PY0(I)=1;
W0(I)=1;
RK0(I)=1;

*---CALIBRATION
PARAMETER
Beta(i)
alpha(i)
A0(I)
;

BETA(I)=(L0(I)*W0(I))/(PY0(I)*Y0(I));
ALPHA(I)=1-BETA(I);
A0(I)=Y0(I)/((K0(I)**(BETA(i)))*(L0(I)**(ALPHA(i))) ) ;


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
         OBJ.L=0;


EQUATION
EQUY(I)
EQUL(I)
EQUK(I)
EQUKS(I)
EQULS(I)
EQUOBJ
;


EQUY(I)..        Y(I)=E=A0(I)*K(I)**(beta(i))*L(I)**(alpha(i));

EQUL(I)..        L(I)*W(I)=E=alphA(I)*PY(I)*Y(I);

EQUK(I)..        K(I)*RK(I)=E=BETA(I)*PY(I)*Y(I);

EQUKS(I)..       KS(I)=E=K(I);

EQULS(I)..       L(I)=E=LS(I);

EQUOBJ..         OBJ=E=1;

MODEL PRODCD
/
EQUY
EQUL
EQUK
EQUKS
EQULS
EQUOBJ
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
KS.FX(I)=K0(I)*1.25;

SOLVE PRODCD MAXIMIZING OBJ USING NLP

