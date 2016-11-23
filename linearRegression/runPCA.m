% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

NumberOfReperts = 50;
NumberOfIterations = 10:10:100;

for k=1:size(NumberOfIterations,2)
    for i=1:NumberOfReperts;
        [tblTest, tblTraining] = dataSplit(tblMovieCleaned);
        % Gradient Descent
        %X = table2array(tblTraining(:, 1:size(tblTraining,2)-1));
        %y = table2array(tblTraining(:, size(tblTraining,2)));
        %n = 100;
        %sigma = 1
        %X=linspace(0,1,n);
        %y=(0.5*X-2)+sigma*randn(1,n);
        
        alpha = 0.05;
        X = table2array(tblTraining(:, 1:size(tblTraining,2)-1));
        %X = table2array(tblTraining(:, 1));
        y = table2array(tblTraining(:, size(tblTraining,2)));
        alpha = 0.75;
        num_iters = NumberOfIterations(k);

        % Init Theta and Run Gradient Descent 
        X = [ones(length(y), 1) X];
        theta = zeros(size(X,2), 1);
        [theta] = gradientDescent(X, y, theta, alpha, num_iters);

        % Eval
        rsquared(i,k) = evaluateRegressionPCA(tblTest,theta);
    end;
end;

% Plot
plotRSS(rsquared,NumberOfReperts,NumberOfIterations, size(X,2)-1);

%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

