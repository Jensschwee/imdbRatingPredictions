function [rSquare ] = rSquareValue(predict,realOut)
%calc rSquare value
%   Detailed explanation goes here
    %meanRealVaule = mean(realVaule);
    %rSquare = 1 - sum((realVaule -perdited).^2)/sum((realVaule - mean(realVaule)).^2);
    
    
    % This formula return two values, we only use one of them. That might
    % not be good. TODO
    R = (cov(predict,realOut) / [(var(realOut)).^0.5 (var(realOut)).^0.5]);
    rSquare = R(2).^2;
    
    %rSquare=1-sum((realOut-predict).^2)/sum((realOut-mean(realOut)).^2);
    
    
    
    
    %if rSquare < 0
        %rSquare = 0;
    %end
end

