% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

NumberOfReperts = 50;
NumberOfIterations = 100:100:1500;
alpha = 0.15;

deltaRSqured = -0.001;
validationCheck = 5; %How manny times may the model not get better?

epochsTryed = []; %Epochs tryed in


for k=1:size(NumberOfIterations,2)
    epochsTryed = [epochsTryed NumberOfIterations(k)] ;
    for i=1:NumberOfReperts;
        [tblTest, tblTraining] = dataSplit(tblMovieCleaned);
        % Gradient Descent
        %X = table2array(tblTraining(:, 1:size(tblTraining,2)-1));
        %y = table2array(tblTraining(:, size(tblTraining,2)));
        %n = 100;
        %sigma = 1
        %X=linspace(0,1,n);
        %y=(0.5*X-2)+sigma*randn(1,n);
        
        X = table2array(tblTraining(:, 1:size(tblTraining,2)-2));
        %X = table2array(tblTraining(:, 1));
        y = table2array(tblTraining(:, size(tblTraining,2)));
        
        num_iters = NumberOfIterations(k);

        % Init Theta and Run Gradient Descent 
        X = [ones(length(y), 1) X];
        theta = zeros(size(X,2), 1);
        [theta] = gradientDescent(X, y, theta, alpha, num_iters);

        % Eval
        rsquaredTest(i,k) = evaluateRegressionPCA(tblTest,theta);
        rsquaredTraning(i,k) = evaluateRegressionPCA(tblTraining,theta);
    end;
    
    %Has the model become better?
    if (k > 1)
        if(deltaRSqured < (mean2(rsquaredTest(:,k-1)) - mean2(rsquaredTest(:,k))))
            if(validationCheck ~= 0)
                validationCheck = validationCheck-1;
            else
                break;
            end
        end
    end
end;

% Plot
plotRSS(rsquaredTest,rsquaredTraning,NumberOfReperts,epochsTryed, size(X,2)-1, tblMovieCleaned.y50);

%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

