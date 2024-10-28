% 初始条件和参数
S0 = 7; V = 350; in_rate = 14; out_rate = 10.5;

% 定义微分方程
salt_eq = @(t, S) -out_rate / V * S;
tspan = [0 50]; % 选择适当的时间范围

% 求解微分方程
[t, S] = ode45(salt_eq, tspan, S0);

% 绘图
plot(t, S);
xlabel('时间 t (秒)');
ylabel('容器内盐的含量 S (千克)');
title('盐的含量随时间的变化');
grid on;
