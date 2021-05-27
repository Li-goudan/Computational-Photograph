clear all;
close all;
clc;

img = double(imread('lighthouse.ppm'))/255;
bayer = img2bayer(img);

simple = nearest(bayer);
%linear = bilinear(bayer);
linear = demosaic(bayer);%双线性插值法子函数

%% viz bilinear
figure('Name','Final');

subplot(2,3,1);
imshow(img);
title('Original - Full');

ax(1) = subplot(2,3,2);
imshow(img);
title('Original - Zoom');

ax(2) = subplot(2,3,3);
imshow(bayer);
title('Bayer pattern');

ax(3) = subplot(2,3,4);
imshow(simple);
title('Nearest Neighbour');

ax(4) = subplot(2,3,5);
imshow(linear);
title('Bilinear Interpolation');

linkaxes(ax, 'xy');
