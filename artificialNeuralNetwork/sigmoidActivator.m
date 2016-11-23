%https://github.com/darshanime/neural-networks-MATLAB/blob/master/sigmoid.m
function [z] = sigmoidActivator(z)
    %The sigmoid function
    z = exp(-z);
    z = 1+z;
    z = 1./z;
end