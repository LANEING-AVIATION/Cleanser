clear all
I=imread('C:\Users\Administrator\Desktop\20240704数字图像处理\IP-test-code\blood.jpg')
figure,imshow(I);
figure;imhist(I)
I1=im2bw(I,110/255)
figure,imshow(I1);
