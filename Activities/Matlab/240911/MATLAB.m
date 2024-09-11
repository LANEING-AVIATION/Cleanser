% 定义网格
[x, y] = meshgrid(-8:0.5:8, -8:0.5:8);

% 定义函数（MATLAB徽标函数 z = sin(r)/r）
r = sqrt(x.^2 + y.^2) + eps;
z = sin(r)./r;

% 绘制3D图
figure;
surf(x, y, z, 'EdgeColor', 'none');  % 创建曲面图
colormap(parula);  % 使用parula色图
axis off;  % 隐藏坐标轴

% 光照
light('Position', [1 0 1], 'Style', 'infinite');
lighting gouraud;

% 添加标题
title('MATLAB Welcome');
[x, y] = meshgrid(-8:0.5:8, -8:0.5:8);Line 20 [x, y] = meshgrid(-8:0.5:8, -8:0.5:8);
Line 21 
% 定义函数（MATLAB徽标函数 z = sin(r)/r）Line 22 % 定义函数（MATLAB徽标函数 z = sin(r)/r）
Line 23 
z = sin(r)./r;Line 24 z = sin(r)./r;
Line 25 
% 绘制3D图Line 26 % 绘制3D图
Line 27 
surf(x, y, z, 'EdgeColor', 'none');  % 创建曲面图Line 28 surf(x, y, z, 'EdgeColor', 'none');  % 创建曲面图
Line 29 
axis off;  % 隐藏坐标轴Line 30 axis off;  % 隐藏坐标轴
Line 31 
% 添加光照Line 32 % 添加光照
Line 33 
lighting gouraud;Line 34 lighting gouraud;
Line 35 
% 添加标题Line 36 % 添加标题
Line 37 
