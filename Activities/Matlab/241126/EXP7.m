% 定义被逼近的函数
f = @(x) abs(x);

% 定义域
x = linspace(-1, 1, 1000);

% 分别在子空间 phi1 和 phi2 中计算逼近

%% 子空间 phi1 = span(1, x, x^3)
phi1_basis = @(x) [ones(size(x)); x; x.^3]; % 基函数
A1 = phi1_basis(x) * phi1_basis(x)';        % 格拉姆矩阵
b1 = phi1_basis(x) * f(x)';                 % 法方程的右端项
coeff1 = A1 \ b1;                           % 求解逼近系数
P1 = @(x) coeff1(1) + coeff1(2)*x + coeff1(3)*x.^3; % 逼近多项式
error1 = trapz(x, (f(x) - P1(x)).^2);       % 计算平方误差

%% 子空间 phi2 = span(1, x^2, x^4)
phi2_basis = @(x) [ones(size(x)); x.^2; x.^4]; % 基函数
A2 = phi2_basis(x) * phi2_basis(x)';           % 格拉姆矩阵
b2 = phi2_basis(x) * f(x)';                    % 法方程的右端项
coeff2 = A2 \ b2;                              % 求解逼近系数
P2 = @(x) coeff2(1) + coeff2(2)*x.^2 + coeff2(3)*x.^4; % 逼近多项式
error2 = trapz(x, (f(x) - P2(x)).^2);          % 计算平方误差

% 绘制函数和逼近多项式的图像
figure;
subplot(2, 1, 1);
plot(x, f(x), 'k-', 'LineWidth', 2); hold on;
plot(x, P1(x), 'r--', 'LineWidth', 2);
legend('f(x) = |x|', '在 \phi_1 中的逼近', 'Location', 'Best');
title('在 \phi_1 中的函数逼近');
xlabel('x'); ylabel('f(x)');
grid on;

subplot(2, 1, 2);
plot(x, f(x), 'k-', 'LineWidth', 2); hold on;
plot(x, P2(x), 'b--', 'LineWidth', 2);
legend('f(x) = |x|', '在 \phi_2 中的逼近', 'Location', 'Best');
title('在 \phi_2 中的函数逼近');
xlabel('x'); ylabel('f(x)');
grid on;

% 显示结果
disp('逼近结果：');
disp('子空间 phi1: span(1, x, x^3)');
disp(['逼近多项式系数: ', num2str(coeff1')]);
disp(['平方误差: ', num2str(error1)]);
disp('子空间 phi2: span(1, x^2, x^4)');
disp(['逼近多项式系数: ', num2str(coeff2')]);
disp(['平方误差: ', num2str(error2)]);
