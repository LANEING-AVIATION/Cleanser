%  EXAMPLE #1:
clear all;
clc
 rawimg = imread('TestHT_Chkbd1.bmp');
 fltr4img = [1 2 3 2 1; 2 3 4 3 2; 3 4 6 4 3; 2 3 4 3 2; 1 2 3 2 1];
 fltr4img = fltr4img / sum(fltr4img(:));
 imgfltrd = filter2( fltr4img , rawimg );
 tic;
 [accum, axis_rho, axis_theta, lineprm, lineseg] = ...
     Hough_Grd(imgfltrd, 6, 0.02);
 toc;
 figure(1); imagesc(axis_theta*(180/pi), axis_rho, accum); axis xy;
 xlabel('Theta (degree)'); ylabel('Pho (pixels)');
 title('Accumulation Array from Hough Transform');
 figure(2); imagesc(rawimg); colormap('gray'); axis image;
 DrawLines_2Ends(lineseg);
 title('Raw Image with Line Segments Detected');
%
%  EXAMPLE #2:
%  rawimg = imread('TestHT_Pentagon.png');
%  fltr4img = [1 1 1 1 1; 1 2 2 2 1; 1 2 4 2 1; 1 2 2 2 1; 1 1 1 1 1];
%  fltr4img = fltr4img / sum(fltr4img(:));
%  imgfltrd = filter2( fltr4img , rawimg );
%  tic;
%  [accum, axis_rho, axis_theta, lineprm, lineseg] = ...
%      Hough_Grd(imgfltrd, 8, 0.05);
%  toc;
%  figure(1); imagesc(axis_theta*(180/pi), axis_rho, accum); axis xy;
%  xlabel('Theta (degree)'); ylabel('Pho (pixels)');
%  title('Accumulation Array from Hough Transform');
%  figure(2); imagesc(imgfltrd); colormap('gray'); axis image;
%  DrawLines_Polar(size(imgfltrd), lineprm);
%  title('Raw Image (Blurred) with Lines Detected');
%  figure(3); imagesc(rawimg); colormap('gray'); axis image;
%  DrawLines_2Ends(lineseg);
%  title('Raw Image with Line Segments Detected');
%
%  BUG REPORT:
%  This is an alpha version. Please send your bug reports, comments and
%  suggestions to pengtao@glue.umd.edu . Thanks.