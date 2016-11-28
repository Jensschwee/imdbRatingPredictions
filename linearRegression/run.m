% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

NumberOfReperts = 50;
NumberOfIterations = 1:1:200;
alpha = 0.25;

deltaRSqured = 0.0001;
validationCheck = 5; %How manny times may the model not get better?

epochsTryed = []; %Epochs tryed in

tblMovieManuel=readtable('../movie_manualTesting_cleaned.csv');

outputManural = table2array(tblMovieManuel(:, 1)); %Color
outputManural = [outputManural, table2array(tblMovieManuel(:, 4))]; %Duration
%X = [X, table2array(tblTest(:, 5))]; %director_facebook_likes
%X = [X,table2array(tblTest(:, 6))]; %actor_3_facebook_likes
%X = [X,table2array(tblTest(:, 8))]; %actor_1_facebook_likes
outputManural = [outputManural,table2array(tblMovieManuel(:, 14))]; %cast_total_facebook_likes
%X = [X,table2array(tblTest(:, 23))]; %Budget
%X = [X, table2array(tblTest(:, 226:244))]; %facenumber_in_poster
%X = [X, table2array(tblTest(:, 25))]; %actor_2_facebook_likes
outputManural = [outputManural, table2array(tblMovieManuel(:, 29:50))]; %genre
outputManural = [outputManural, table2array(tblMovieManuel(:, 51:84))]; %language
outputManural = [outputManural, table2array(tblMovieManuel(:, 85:127))]; %country
%X = [X, table2array(tblTest(:, 128:133))]; %content_rating
outputManural = [outputManural, table2array(tblMovieManuel(:, 134:207))]; %title_year
%X = [X, table2array(tblTest(:, 208:225))]; %aspect_ratio
y = table2array(tblMovieManuel(:, 26));

outputManural = [ones(length(y), 1) outputManural];
t1 = tic;%initilise counter

epochsTryed = NumberOfIterations;
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

    % Init Theta and Run Gradient Descent 
    X = [ones(length(y), 1) X];
    theta = zeros(size(X,2), 1);
    
    XTest = table2array(tblTest(:, 1)); %Color
    XTest = [XTest, table2array(tblTest(:, 4))]; %Duration
    %X = [X, table2array(tblTest(:, 5))]; %director_facebook_likes
    %X = [X,table2array(tblTest(:, 6))]; %actor_3_facebook_likes
    %X = [X,table2array(tblTest(:, 8))]; %actor_1_facebook_likes
    XTest = [XTest,table2array(tblTest(:, 14))]; %cast_total_facebook_likes
    %X = [X,table2array(tblTest(:, 23))]; %Budget
    %X = [X, table2array(tblTest(:, 226:244))]; %facenumber_in_poster
    %X = [X, table2array(tblTest(:, 25))]; %actor_2_facebook_likes
    XTest = [XTest, table2array(tblTest(:, 29:50))]; %genre
    XTest = [XTest, table2array(tblTest(:, 51:84))]; %language
    XTest = [XTest, table2array(tblTest(:, 85:127))]; %country
    %X = [X, table2array(tblTest(:, 128:133))]; %content_rating
    XTest = [XTest, table2array(tblTest(:, 134:207))]; %title_year
    %X = [X, table2array(tblTest(:, 208:225))]; %aspect_ratio
    yTest = table2array(tblTest(:, 26));
    XTest = [ones(length(yTest), 1) XTest];
    
    for k=1:size(NumberOfIterations,2)
        for j=1:(NumberOfIterations(2)-NumberOfIterations(1))
            % Gradient Descent
            [theta] = gradientDescent(X, y, theta, alpha);
        end
        % Eval
        rsquaredTest(i,k) = evaluateRegression(tblTest,theta);
        rsquaredTraning(i,k) = evaluateRegression(tblTraining,theta);
        for h=1:size(XTest,1)
            testPrediction(h) = sum(XTest(h,:) .* theta');
        end
        err(i,k) = immse(testPrediction,yTest');
    end
    
    ManuralTesting(1,i) = sum(outputManural(1,:)' .* theta);
    ManuralTesting(2,i) = sum(outputManural(2,:)' .* theta);

    %Has the model become better?
    %if (k > 1)
    %    if(deltaRSqured > abs(mean2(rsquaredTest(:,k-1)) - mean2(rsquaredTest(:,k))))
    %        if(validationCheck ~= 0)
    %            validationCheck = validationCheck-1;
    %        else
    %            break;
    %        end
    %    end
end

toc(t1)%compute elapsed time

% Plot
plotRSS(rsquaredTest,rsquaredTraning,NumberOfReperts,epochsTryed, size(X,2)-1, tblMovieCleaned.imdb_score);

plot(err(1,:));

mean(ManuralTesting(1,:))
mean(ManuralTesting(2,:))

%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

