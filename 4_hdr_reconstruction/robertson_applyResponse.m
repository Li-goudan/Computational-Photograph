function [ hdrimg ] = robertson_applyResponse( images, times, I, channel )
% compute the given channel of the HDR image given the set of images,
% exposure time and a response curve

N = length(images);
w = weight(I);%robertsonȨ��
im = cell(1,N);%Ԫ��������ԭ��ͬ�ع�ʱ���Ȩ�غ��ֵ

%ԭ��ͬ�ع�ʱ��ͼ���Ȩ��
for i = 1:N
    im{i} = images{i}(:,:,channel).*w(images{i}(:,:,channel)+1);
end

hdrimg = zeros(200,308);

%�ع��ں�
for j = 1:N
    hdrimg = im{j}+hdrimg;
end

end
