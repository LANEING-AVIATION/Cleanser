f=[-170.8582 17.7254 -41.2582 -2.2182 -131.8182 500000];
A=[1 -0.17037 -0.5324 0 1 0;0 0.17037 0.5324 0 0 0;1 0.32 1 0 0 0;0 1 0 0 0 0;0 0 1 1 0 0;0 0 0 -1 -1 0];
b=[0;888115;166805;521265.625;683400;-660000];
Aeq=[0 0 0 0 0 1];
beq=[1];
lb=[0;0;0;0;0;0];
[x,fval,exitflag,output,lamda]=linprog(f,A,b,Aeq,beq,lb,[])