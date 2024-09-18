x0=[1;1;1;1];lb=[0;0;0;0];ub=[];A=[];b=[];Aeq=[];beq=[];
[x,fval]=fmincon('example2_8_1',x0,A,b,Aeq,beq,lb,ub,'example2_8_2')