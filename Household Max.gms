$ Title A Household's Utility Max. you can find this example in the library

* Definition of the Index Sets ---------------------------------------
Set     i       goods                   /Agr     Agriculture,
                                         Man     Manufacturing
                                         Ser     Services/
        h       factors                 /CAP    capital,
                                         LAB    labor/;

* Definition of Parameters -------------------------------------------
Parameter       alpha(i)        share parameter in utility function
                /Agr   0.02
                 Man   0.327
                 Ser   0.653/;

Parameter       pq(i)           price of the i-th good
                /Agr   1
                 Man   1
                 Ser   1/;

Parameter       pf(h)           price of the h-th factor
                /CAP    1
                 LAB    1/;

Parameter       FF(h)           factor endowment
                /CAP    5989
                 LAB    14219/;

* Definition of Primal/Dual Variables --------------------------------
Positive Variable X(i)          consumption of the i-th good
;
Variable        UU              utility
;
Equation        eqX(i)          household demand function
                obj             utility function
;
* Specification of Equations ------------------------------------------

eqX(i)..        X(i)      =e= alpha(i)*sum(h, pf(h)*FF(h))/pq(i);
obj..           UU        =e= prod(i, X(i)**alpha(i));


X.lo(i)=0.001;

* Defining the Model --------------------------------------------------
Model HHmax /all/;

* Solving the Model ---------------------------------------------------
Solve HHmax maximizing UU using NLP;
* ---------------------------------------------------------------------
* end of model --------------------------------------------------------
* ---------------------------------------------------------------------
pf("Lab")=1.2;
Solve HHmax maximizing UU using NLP;
;