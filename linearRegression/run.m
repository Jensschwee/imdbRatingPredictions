% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

NumberOfReperts = 50;
NumberOfIterations = 1:1:25;

for k=1:size(NumberOfIterations,2)
    for i=1:NumberOfReperts;
        [tblTest, tblTraining] = dataSplit(tblMovieCleaned);
        % Gradient Descent
        X = table2array(tblTraining(:, 1)); %Color
        X = [X, table2array(tblTraining(:, 4))]; %Duration
        %X = [X, table2array(tblTraining(:, 5))]; %director_facebook_likes
        %X = [X,table2array(tblTraining(:, 6))]; %actor_3_facebook_likes
        %X = [X,table2array(tblTraining(:, 8))]; %actor_1_facebook_likes
        X = [X,table2array(tblTraining(:, 14))]; %cast_total_facebook_likes
        %X = [X, table2array(tblTraining(:, 226:244))]; %facenumber_in_poster
        %X = [X, table2array(tblTraining(:, 25))]; %actor_2_facebook_likes
        X = [X, table2array(tblTraining(:, 29:50))]; %genre
        X = [X, table2array(tblTraining(:, 51:84))]; %language
        X = [X, table2array(tblTraining(:, 85:127))]; %country
        %X = [X, table2array(tblTraining(:, 128:133))]; %content_rating
        X = [X, table2array(tblTraining(:, 134:207))]; %title_year
        %X = [X, table2array(tblTraining(:, 208:225))]; %aspect_ratio
        y = table2array(tblTraining(:, 245));
        alpha = 0.05;
        num_iters = NumberOfIterations(k);

        % Init Theta and Run Gradient Descent 
        X = [ones(length(y), 1) X];
        theta = zeros(size(X,2), 1);
        [theta] = gradientDescent(X, y, theta, alpha, num_iters);

        % Eval
        rsquared(i,k) = evaluateRegression(tblTest,theta);
    end;
end;

% Plot
plotRSS(rsquared,NumberOfReperts,NumberOfIterations, size(X,2));

%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

