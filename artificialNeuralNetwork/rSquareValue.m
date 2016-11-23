function [rSquare ] = rSquareValue(x,x2)
%calc rSquare value
%   Detailed explanation goes here
    %meanRealVaule = mean(realVaule);
    %rSquare = 1 - sum((realVaule -perdited).^2)/sum((realVaule - mean(realVaule)).^2);
    rSquare=1-sum((x2-x).^2)/sum((x2-mean(x2)).^2);
    %if rSquare < 0
        %rSquare = 0;
    %end
end

