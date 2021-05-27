function [ w ] = weight( x )

    % gaussian weighting function
    w = exp(-4*((x-127.5).^2)./127.5^2);

end
