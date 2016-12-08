function [theta] = gradientDescent(X, y, theta, alpha, numberOfIterations)
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, numberOfIterations) updates theta by
%   taking numberOfIterations gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
thetas = size(theta,1);
%J_history = zeros(numberOfIterations, 1); 

%for iteration = 1:numberOfIterations
    % Perform a single gradient step on the parameter vector theta. 

    % we minimize the value of J(theta) by changing the values of the 
    % vector theta NOT changing X or y

    % alpha = learning rate as a single number

    % hypothesis = mx1 column vector
    % X = mxn matrix
    % theta = nx1 column vector
    %for all the thetas
    sqens = datasample(1:m,m,'Replace',false);
    %all the examples
    for examples = 1:m
         for t = 1:thetas
            hyp = (theta' * X(sqens(examples), :)');
            currentT = X(sqens(examples),2);
            error = (y(sqens(examples))- hyp);
            theta(t) = theta(t) + alpha * error * currentT;
        end
    end
    
    %theta = theta - alpha * (1/m) * result';
end