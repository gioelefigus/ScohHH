
$ONTEXT
WRITE A SIMPLE VECTOR

Assume we have 100 workers in agriculture, 80 workers in manufacturing and 120 workers
in the service sector.

Let's call our variable L. To create a simple vector we write the following

FIRST WE SHOULD CONSTRACT AN INDEX FOR THE SECTORS
$OFFTEXT
SET I/AGR,MAN,SER/;

PARAMETER
L/
AGR 100,
MAN 80,
SER 120/;

PARAMETER
L0;

L0("AGR")=100;
L0("MAN")=80;
L0("SER")=120;

ALIAS (I,J)


TABLE M(I,J)
         AGR     MAN     SER
AGR      30      20     10
MAN      45      50     25
SER      10      20     30
;

