function [ CI ] = ConfidenceInterval( means, sds)
%CONFIDENCEINTERVAL Summary of this function goes here
%   Detailed explanation goes here
    x = means;                     % Create Data
    SEM = sds/sqrt(10);               % Standard Error
    ts = tinv([0.025  0.975],10-1);      % T-Score
    for i=1:size(x);
     CI(i)= (ts(1) .* SEM(i));                      % Confidence Intervals
    end
end

