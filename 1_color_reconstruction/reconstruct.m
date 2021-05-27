function RGB = reconstruct(R,G,B)
%   将输入的R,G,B单通道合并为一张RGB三通道图片
    RGB(:,:,1)=R(:,:,1);
    RGB(:,:,2)=G(:,:,1);
    RGB(:,:,3)=B(:,:,1);
end

