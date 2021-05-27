function [ hdrimg, curve ] = robertson_getResponse( images, times, I, channel)

maxit = 100;
maxdelta = 0.0005;

%% initalization
% perform the first step of the Robertson algorithm

% initialize the response function I and Ip (I in the previous iteration -
% used as a stopping criterion).
I = normalize(I);
Ip = I;

% apply Robertson to get first HDR image estimate
hdrimg = robertson_applyResponse(images, times, I, channel);


%% optimization
it_count = 0;
delta = 5000;

while(delta > maxdelta)

    % step 1: minimize the objective function with respect to I
    %   compute the response function estimate I (equation 10 from the paper);
    %   I has to be monotonically increasing (beware of a lost zero between
    %   two nonzero values)!
    %   (hint: to avoid extra for loops you could use the "conditional indices"
    %   as mentioned in the assignment.

    % step 2: normalize I
    I = normalize(I);%调用归一化数据子函数

    
    % step 3: apply new response
    hdrimg = robertson_applyResponse(images, times, I, channel);

    
    % step 4: check stopping condition delta - use the squared difference
    % between two consecutive response curve estimates.
    
    fprintf('    %d: delta = %g\n', it_count, delta);

    if(it_count == maxit)
        delta = 0;
    end
    
    it_count = it_count+1;
    Ip = I;
end

curve = I;

end

% 
% function [ normed, mid ] = normalize( I )
%     normed(I+1) = 1;
% end
