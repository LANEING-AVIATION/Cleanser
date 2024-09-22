% 1. 加载JSON数据
jsonFile = '5.json'; % JSON 文件名
jsonData = jsondecode(fileread(jsonFile)); % 读取并解析 JSON 文件

% 2. 初始化数据
n = size(jsonData, 1); % 数据点数量

% 3. 提取XYZ角速度和XYZ加速度
ax = jsonData(:, 1); % 提取加速度X分量
ay = jsonData(:, 2); % 提取加速度Y分量
az = jsonData(:, 3); % 提取加速度Z分量
gx = jsonData(:, 4); % 提取角速度X分量
gy = jsonData(:, 5); % 提取角速度Y分量
gz = jsonData(:, 6); % 提取角速度Z分量

% 4. 绘制数据
time = 1:n; % 假设每个数据点代表一毫秒，时间从 1 到 n

figure;
hold on;
plot(time, ax, 'r', 'DisplayName', 'Accel X');
plot(time, ay, 'g', 'DisplayName', 'Accel Y');
plot(time, az, 'b', 'DisplayName', 'Accel Z');
plot(time, gx, '--r', 'DisplayName', 'Gyro X');
plot(time, gy, '--g', 'DisplayName', 'Gyro Y');
plot(time, gz, '--b', 'DisplayName', 'Gyro Z');

% 5. 图形设置
xlabel('Time (ms)');
ylabel('Sensor Readings');
title('XYZ Acceleration and Gyroscope Data');
legend('show');
grid on;
hold off;
