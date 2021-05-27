%% reset
clear
close all;
clc;


%% load data

[names, times] = listparse('max.list');
n = length(names);
channels = 1:3;

%  load the parsed images
images = cell(n,1);
for i = 1:n
    images{i} = double(imread(sprintf('%s',names{i})));
end

times = 1 ./ times;


% viz overview
figure(1);

for i = 1:n
    subplot(3,4,i);
    imshow(uint8(images{i}));
    title(sprintf('\\Delta t_{%d} = %0.3gs',i,times(i)));
end


%% Robertson linear

f = 0:255;

figure(2);
plot(f);
axis tight;
title('linear response curve');

figure(3);
plot(weight(0:255));
axis tight;
title('weighting function');


[h w d] = size(images{1});
img = zeros(h, w, d);

disp('Reconstructing with linear response curve:');
for c = channels
    fprintf('  calculating channel %d...\n',c);
    img(:,:,c) = robertson_applyResponse(images, times, 0:255, c);
end

% viz linear
logged = log(img);
scaled = logged / max(logged(:));

figure(4);
imshow(scaled,[]);
title('HDR with linear response Curve');


%% Robertson with response curve

imgopt = zeros(h, w, d);
curve = zeros(d, 256);

disp('Reconstructing with calculated response curve:');
for c = channels
    fprintf('  calculating channel %d...\n',c);
    [imgopt(:,:,c), curve(c,:)] = robertson_getResponse(images, times, 0:255, c);
end

tonedopt = tonemap(imgopt, 'AdjustLightness', [0.1 1]);

figure(5);
imshow(tonedopt);
imwrite(tonedopt,'reconstructed.jpg','jpg');
title('HDR with calculated response Curve');

% viz curve
figure(6);
semilogx(curve(1,:),0:255,'r');
hold on;
semilogx(curve(2,:),0:255,'g');
semilogx(curve(3,:),0:255,'b');
hold off;
axis tight;
title('Response Curve');