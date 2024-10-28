% 参数和初始条件
mu = 1 / 82.45;
mu1 = 1 - mu;

% 初始条件
initial_conditions = [1.2, 0, 0, -1.04935751];
tspan = [0 10]; % 根据需要调整时间跨度

% 定义微分方程组
apollo = @(t, Y) [
    Y(2);
    2 * Y(4) + Y(1) - mu1 * (Y(1) + mu) / ((Y(1) + mu)^2 + Y(3)^2)^(3/2) ...
    - mu * (Y(1) - mu1) / ((Y(1) - mu1)^2 + Y(3)^2)^(3/2);
    Y(4);
    -2 * Y(2) + Y(3) - mu1 * Y(3) / ((Y(1) + mu)^2 + Y(3)^2)^(3/2) ...
    - mu * Y(3) / ((Y(1) - mu1)^2 + Y(3)^2)^(3/2)
];

% 求解
[t, sol] = ode45(apollo, tspan, initial_conditions);

% 绘图
plot(sol(:,1), sol(:,3));
xlabel('x'); ylabel('y');
title('Apollo卫星运动轨迹');
grid on;
