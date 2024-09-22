% 1. 加载JSON数据
jsonFile = '4.json'; % JSON 文件名
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

% 4. 使用Z轴加速度的自相关来检测震动周期
[zAutocorr, lags] = xcorr(az, 'coeff'); % Z轴加速度的自相关
[~, locs] = findpeaks(zAutocorr(lags > 0), 'MinPeakHeight', 0.3); % 找到自相关峰值
cycleLength = locs(1); % 假设第一个峰值对应的间隔为周期长度

% 5. 提取有效周期数据
validCycles = []; % 有效周期的索引
for i = 1:cycleLength:(n - cycleLength)
    currentCycle = az(i:i + cycleLength - 1);
    if std(currentCycle) < 0.5 % 使用标准差来判断周期是否稳定
        validCycles = [validCycles; i]; % 记录有效周期的起始位置
    end
end

% 6. 可视化有效周期内的加速度和角速度数据
if ~isempty(validCycles)
    cycleIdx = validCycles(1); % 选取第一个有效周期进行可视化
    time = 1:cycleLength; % 时间轴

    figure;
    hold on;
    % 绘制加速度数据
    plot(time, ax(cycleIdx:cycleIdx + cycleLength - 1), 'r', 'DisplayName', 'Accel X');
    plot(time, ay(cycleIdx:cycleIdx + cycleLength - 1), 'g', 'DisplayName', 'Accel Y');
    plot(time, az(cycleIdx:cycleIdx + cycleLength - 1), 'b', 'DisplayName', 'Accel Z');
    % 绘制角速度数据
    plot(time, gx(cycleIdx:cycleIdx + cycleLength - 1), '--r', 'DisplayName', 'Gyro X');
    plot(time, gy(cycleIdx:cycleIdx + cycleLength - 1), '--g', 'DisplayName', 'Gyro Y');
    plot(time, gz(cycleIdx:cycleIdx + cycleLength - 1), '--b', 'DisplayName', 'Gyro Z');
    
    % 设置图形属性
    xlabel('Time (samples)');
    ylabel('Sensor Readings');
    title('XYZ Acceleration and Gyroscope Data (One Vibration Cycle)');
    legend('show');
    grid on;
    hold off;
else
    disp('No valid cycles detected.');
end
