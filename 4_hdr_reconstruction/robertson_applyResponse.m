function [ hdrimg ] = robertson_applyResponse( images, times, I, channel )
% compute the given channel of the HDR image given the set of images,
% exposure time and a response curve

N = length(images);
w = weight(I);%robertson权重
im = cell(1,N);%元胞数组存放原不同曝光时间乘权重后的值

%原不同曝光时间图像乘权重
for i = 1:N
    im{i} = images{i}(:,:,channel).*w(images{i}(:,:,channel)+1);
end

hdrimg = zeros(200,308);

%曝光融合
for j = 1:N
    hdrimg = im{j}+hdrimg;
end

end
