% 导入数据
data = readmatrix('alcohol_data.xlsx');

% 分离时间和酒精含量
time = data(1, :);         
alcohol_content = data(2, :); 

% 设置参数
max_epochs = 1000; % 最大训练周期
error_threshold = 5; % 允许的误差阈值（根据需要调整）

% 创建神经网络
net = fitnet(10); % 10个隐藏神经元
net.trainParam.max_fail = 10; % 允许的最大失败次数
net.trainParam.epochs = max_epochs; % 最大训练周期
net.trainParam.goal = 0; % 训练目标为0误差

% 训练过程
is_converged = false;

while ~is_converged
    [net, tr] = train(net, time, alcohol_content);
    
    % 计算预测值
    predicted_values = net(time);
    
    % 计算均方误差
    mse = mean((predicted_values - alcohol_content).^2);
    
    % 检查误差是否在阈值范围内
    if mse < error_threshold
        is_converged = true;
    end
    
    disp(['MSE: ', num2str(mse)]);
    
    % 允许通过设置max_epochs来限制训练轮数
    if tr.num_epochs >= max_epochs
        disp('达到最大训练周期，结束训练。');
        break;
    end
end

% 生成拟合曲线
fit_time = linspace(min(time), max(time), 100);
fit_alcohol_content = net(fit_time);

% 绘制原始数据和拟合曲线
figure;
hold on;
scatter(time, alcohol_content, 'filled', 'DisplayName', '原始数据');
plot(fit_time, fit_alcohol_content, 'r-', 'LineWidth', 2, 'DisplayName', '神经网络拟合');

% 设置图形属性
xlabel('时间 (小时)');
ylabel('酒精含量 (毫克/百毫升)');
title('酒精含量与时间的神经网络拟合');
grid on;
legend('Location', 'Best');
hold off;

% 输出训练信息
disp('神经网络训练完成。');

% 显示神经网络的训练参数
disp('神经网络的训练参数:');
disp(net.trainParam);
disp('隐藏层权重:');
disp(net.IW);
disp('偏置:');
disp(net.b);
disp('层间权重:');
disp(net.LW);

% 输出模型结构
disp('模型结构:');
disp('输入层：1个输入节点（时间）');
disp('隐藏层：1个隐藏层，10个神经元');
disp('输出层：1个输出节点（酒精含量）');

% 输出训练参数
disp('训练参数:');
disp(net.trainParam);

% 输出权重和偏置
disp('隐藏层权重:');
disp(net.IW{1}); % 输入到隐藏层的权重
disp('隐藏层偏置:');
disp(net.b{1}); % 隐藏层的偏置
disp('输出层权重:');
disp(net.LW{2,1}); % 隐藏层到输出层的权重
disp('输出层偏置:');
disp(net.b{2}); % 输出层的偏置

% 输出训练过程中的性能指标
disp('训练过程中的性能指标:');
disp(['最终均方误差 (MSE): ', num2str(mean((net(time) - alcohol_content).^2))]);
