$TITLE Simple macro model

$ONTEXT
Y=c+i
C=a*y+b
i=50
i= autonomous investment; c=consumption; a=marginal propensity to consume b=autonomous consumption and y=income.
$OFFTEXT


SCALARS
a marginal propensity to consume / 0.5 /
b autonomous consumption/ 100 / ;
PARAMETERS
i investment ;
i = 50;
VARIABLES
y income
c consumption
obj objective
; 
EQUATIONS
eqincome         Income equation
eqconsumption    consumption equation
eqobj            objective equation ;

eqobj.. obj =E= 0;
eqincome.. y =E= c + i;
eqconsumption.. c =E= a * y + b;
MODEL SIMPLEMACRO / ALL /;
SOLVE SIMPLEMACRO MINIMIZING OBJ USING LP;
