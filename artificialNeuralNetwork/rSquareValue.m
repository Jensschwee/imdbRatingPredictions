function [rSquare ] = rSquareValue(realVaule, perdited )
%calc rSquare value
%   Detailed explanation goes here
    meanRealVaule = mean(realVaule);
    rSquare = 1 - sum((realVaule -perdited).^2)/sum((realVaule - meanRealVaule).^2);
    if rSquare < 0
        %rSquare = 0;
    end
end

