% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

NumberOfReperts = 50;
NumberOfIterations = 200:10:350;
alpha = 0.25;

deltaRSqured = -0.01;
validationCheck = 5; %How manny times may the model not get better?

epochsTryed = []; %Epochs tryed in

for k=1:size(NumberOfIterations,2)
    epochsTryed = [epochsTryed NumberOfIterations(k)] ;
    for i=1:NumberOfReperts;
        [tblTest, tblTraining] = dataSplit(tblMovieCleaned);
        % Gradient Descent
        X = table2array(tblTraining(:, 1)); %Color
        X = [X, table2array(tblTraining(:, 4))]; %Duration
        %X = [X, table2array(tblTest(:, 5))]; %director_facebook_likes
        %X = [X,table2array(tblTest(:, 6))]; %actor_3_facebook_likes
        %X = [X,table2array(tblTest(:, 8))]; %actor_1_facebook_likes
        X = [X,table2array(tblTraining(:, 14))]; %cast_total_facebook_likes
        %X = [X,table2array(tblTest(:, 23))]; %Budget
        %X = [X, table2array(tblTest(:, 226:244))]; %facenumber_in_poster
        %X = [X, table2array(tblTest(:, 25))]; %actor_2_facebook_likes
        X = [X, table2array(tblTraining(:, 29:50))]; %genre
        X = [X, table2array(tblTraining(:, 51:84))]; %language
        X = [X, table2array(tblTraining(:, 85:127))]; %country
        %X = [X, table2array(tblTest(:, 128:133))]; %content_rating
        X = [X, table2array(tblTraining(:, 134:207))]; %title_year
        %X = [X, table2array(tblTest(:, 208:225))]; %aspect_ratio
        y = table2array(tblTraining(:, 26));
                
        num_iters = NumberOfIterations(k);

        % Init Theta and Run Gradient Descent 
        X = [ones(length(y), 1) X];
        theta = zeros(size(X,2), 1);
        [theta] = gradientDescent(X, y, theta, alpha, num_iters);

        % Eval
        rsquaredTest(i,k) = evaluateRegression(tblTest,theta);
        rsquaredTraning(i,k) = evaluateRegression(tblTraining,theta);
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
plotRSS(rsquaredTest,rsquaredTraning,NumberOfReperts,epochsTryed, size(X,2)-1, tblMovieCleaned.imdb_score);

%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

