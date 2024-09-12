clear all;
clc
p1=imread('C:\Users\Administrator\Desktop\20240704数字图像处理\IP-test-code\lena.bmp');
p1=im2double(p1);  %转换为double
p=rgb2gray(p1);
[e1,s1] = edge(p,'sobel',0.03,'both');          % sobel检测器
[e2,s2] = edge(p,'roberts',0.03,'both');        % roberts检测器
[e3,s3] = edge(p,'prewitt',0.04,'both');        % prewitt检测器
[e4,s4] = edge(p,'log',0.003,2.10);              % LoG检测器
[e5,s5] = edge(p,'canny',[0.05 0.12],1.6);   % canny检测器
subplot(2,3,1),imshow(p);
subplot(2,3,2),imshow(e1);
subplot(2,3,3),imshow(e2);
subplot(2,3,4);imshow(e3);
subplot(2,3,5),imshow(e4);
subplot(2,3,6),imshow(e5);
