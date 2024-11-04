x=[0.25 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12 13 14 15 16];
y=[30 68 75 82 82 77 68 68 58 51 50 41 38 35 28 25 18 15 12 10 7 7 4];
x0=[1 0 0];
[m]=lsqcurvefit(@func,x0,x,y);

x1=0:0.05:18;
y1=func(m,x1);
figure;
hold on
plot(x,y,"o","MarkerFaceColor","b")
plot(x1,y1,"r",LineWidth=1.5)
xlabel("时间 h")
ylabel("酒精含量 0.1^2mg/ml")
title("酒精含量随时间变化曲线")
legend("数据点","酒精含量关于时间的拟合曲线")

function y=func(x0,x)
a0=x0(1);
a1=x0(2);
a2=x0(3);
y=a0.*(exp(a1.*x)-exp(a2.*x));
end



