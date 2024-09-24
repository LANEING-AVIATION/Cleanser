% 初始化数据
a=2;
x=10000;
cha=1;
ci=0;

% 循环
while abs(cha)>=0.00001
    x1=1/2*(x+a/x);
    cha=x1-x;
    x=x1;
    ci=ci+1;
end

fprintf("迭代次数为%d,x值为%.7f\n",ci,x)
