% 定义x, y的取值范围
[x, y] = meshgrid(-5:0.1:5, -5:0.1:5);

% 定义z
z = y.^2 - 3.*x.*y + x.^2;

% 绘制曲面图
figure;
surf(x, y, z);

% 添加标签
xlabel('x');
ylabel('y');
zlabel('z');
title('z = y^2 - 3xy + x^2 曲面图');