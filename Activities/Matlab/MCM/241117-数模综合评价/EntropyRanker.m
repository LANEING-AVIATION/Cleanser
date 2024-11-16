% ��ջ���
clear;
clc;
% ԭʼ���ݾ���
A = [
    80, 90, 85;
    70, 60, 78;
    90, 80, 88;
    85, 75, 92
];
% ָ�����ͣ�1��ʾЧ���ͣ�0��ʾ�ɱ���
indicator_type = [1, 0, 1];
% ���ݱ�׼������Ч����: ��һ�����ɱ���: ����һ����
[n, m] = size(A);
R = zeros(n, m);
for j = 1:m
    if indicator_type(j) == 1
        % Ч����ָ���һ��
        R(:, j) = (A(:, j) - min(A(:, j))) / (max(A(:, j)) - min(A(:, j)));
    else
        % �ɱ���ָ�귴��һ��
        R(:, j) = (max(A(:, j)) - A(:, j)) / (max(A(:, j)) - min(A(:, j)));
    end
end
% �����ָ�����ֵ
k = 1 / log(n);  % ����k
E = zeros(1, m);
for j = 1:m
    p = R(:, j) ./ sum(R(:, j));
    E(j) = -k * sum(p .* log(p + eps));  % ��eps��ֹlog(0)
end
% �����ָ��Ĳ���ϵ��
d = 1 - E;
% �����ָ���Ȩ��
w = d / sum(d);
% �����ۺϵ÷�
Z = R * w';
% ����ۺϵ÷ּ�����
[sorted_Z, index] = sort(Z, 'descend');
% ������
fprintf('���������ۺϵ÷֣�\n');
disp(Z);
fprintf('����\n');
disp(index);
% ���ÿ���������ۺϵ÷ּ����Ӧ������
for i = 1:n
    fprintf('����%d = %.4f, ���� = %d\n', i, Z(i), find(index == i));
end
