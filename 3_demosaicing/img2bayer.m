%%

function bayer = img2bayer(img)

%img = double(imread(file))/255;
%img = imread(file);

bayer = zeros(size(img));

bayer(1:2:end,1:2:end,1) = img(1:2:end, 1:2:end,1);
bayer(1:2:end,2:2:end,2) = img(1:2:end, 2:2:end,2);
bayer(2:2:end,1:2:end,2) = img(2:2:end, 1:2:end,2);
bayer(2:2:end,2:2:end,3) = img(2:2:end, 2:2:end,3);

%imwrite(bayer,strcat(file,'.bmp'),'bmp');

end
