close all;
clear all;
clc;

%% load images

rock = double(imread('rock_orig.pgm'))/255.0;
rock_b = double(imread('rock_bilateral.pgm'))/255.0;

[h, w] = size(rock)

% viz
figure(1);
imshow(rock,[]);


%% bilateral

% calc sigma_r
[dx dy] = gradient(rock);
mag = sqrt(dx.^2 + dy.^2);
magup = sort(mag(:));
pos = round(0.9 * length(magup));

sigma_s = min(h, w) / 16.0
w = ceil(2*sigma_s)
sigma_r = magup(pos)

[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_s^2));

figure(2);
imshow(G,[])


bilat = bilateralfilter(rock, w, sigma_s, sigma_r);


%% sfgs

figure(3);
subplot(2,2,1); imshow(rock);
subplot(2,2,2); imshow(bilat);
subplot(2,2,3); imshow(rock_b);
subplot(2,2,4); imshow((rock_b-bilat).^2,[]);


%% enhance texture

rock_tex = rock-bilat;%extract texture
residual = rock_tex*3 + rock;%enhance texture
img_out = residual/max(residual(:));
%img_out = residual;

figure(4);
imshow(img_out,[]);
imwrite(img_out,'rock_resid.jpg');

% normalization

figure(5);
for i = 1:4
    detail = (2*i*rock_tex);
    res = exp(log(bilat) + detail/max(detail(:)));
    ax(i) = subplot(2,2,i); imshow(res,[]);
end

linkaxes(ax);    