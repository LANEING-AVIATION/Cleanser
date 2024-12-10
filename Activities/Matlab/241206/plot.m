% 数据示例
height = [160, 170, 180, 190, 200]; % 身高 (cm)
length = [4, 4.2, 4.5, 4.8, 5];    % 杆材长度 (m)
rigidity = [1, 1.2, 1.5, 1.8, 2];   % 杆材刚性 (单位：相对硬度)

% 绘制身高与杆材长度的关系图
figure;
subplot(1, 2, 1);
plot(height, length, '-o');
xlabel('身高 (cm)');
ylabel('杆材长度 (m)');
title('身高与杆材长度关系');
grid on;

% 绘制身高与杆材刚性的关系图
subplot(1, 2, 2);
plot(height, rigidity, '-o');
xlabel('身高 (cm)');
ylabel('杆材刚性 (单位：相对硬度)');
title('身高与杆材刚性关系');
grid on;
