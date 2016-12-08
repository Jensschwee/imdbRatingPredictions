% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

NumberOfReperts = 10;
NumberOfIterations = 300;
alpha = 0.0001:0.0001:0.001; 
%alpha = 0.95:-0.1:0;

deltaMSE = 0.000;

epochsTryed = []; %Epochs tryed in

AlphaTuning = [ones(length(alpha), 1) ones(length(alpha), 1) ones(length(alpha), 1) ones(length(alpha), 1) ones(length(alpha), 1) ones(length(alpha), 1)];

epochsTryed = NumberOfIterations;
for a=1:length(alpha)
    for i=1:NumberOfReperts;
        [tblTest, tblTraining] = dataSplit(tblMovieCleaned);
        X = table2array(tblTest(:, 1)); %Color
        X = [X, table2array(tblTest(:, 2))]; %Duration
        X = [X, table2array(tblTest(:, 13))]; %director_facebook_likes
        X = [X, table2array(tblTest(:, 12))]; %cast_total_facebook_likes
        X = [X, table2array(tblTest(:, 14:36))]; %genre
        X = [X, table2array(tblTest(:, 55:93))]; %language
        X = [X, table2array(tblTest(:, 94:155))]; %country
        X = [X, table2array(tblTest(:, 128:133))]; %content_rating
        X = [X, table2array(tblTest(:, 156:243))]; %title_year
        X = [X, table2array(tblTest(:, 244:262))]; %aspect_ratio
        X = [X, table2array(tblTest(:, 37:54))]; %facenumber_in_poster
        y = table2array(tblTest(:, 10));

        % Init Theta and Run Gradient Descent 
        X = [ones(length(y), 1) X];
        theta = [1 rand(1,(size(X,2)-1))]';

        XTest = table2array(tblTraining(:, 1)); %Color
        XTest = [XTest, table2array(tblTraining(:, 2))]; %Duration
        XTest = [XTest, table2array(tblTraining(:, 13))]; %director_facebook_likes
        XTest = [XTest, table2array(tblTraining(:, 12))]; %cast_total_facebook_likes
        XTest = [XTest, table2array(tblTraining(:, 14:36))]; %genre
        XTest = [XTest, table2array(tblTraining(:, 55:93))]; %language
        XTest = [XTest, table2array(tblTraining(:, 94:155))]; %country
        XTest = [XTest, table2array(tblTraining(:, 128:133))]; %content_rating
        XTest = [XTest, table2array(tblTraining(:, 156:243))]; %title_year
        XTest = [XTest, table2array(tblTraining(:, 244:262))]; %aspect_ratio
        XTest = [XTest, table2array(tblTraining(:, 37:54))]; %facenumber_in_poster
        yTest = table2array(tblTraining(:, 10));
        XTest = [ones(length(yTest), 1) XTest];

        mseLast = 100000;

        t1 = tic;%initilise counter
        for k=1:NumberOfIterations
            for j=1:1
                % Gradient Descent
                [theta] = gradientDescent(X, y, theta, alpha(a));
            end
            for h=1:size(XTest,1)
                testPrediction(h) = sum(XTest(h,:)' .* theta);
            end
            % Eval
            rsquaredTest(i,k) = evaluateRegression(tblTest,theta);
            rsquaredTraning(i,k) = evaluateRegression(tblTraining,theta);

            thisMSE = immse(testPrediction,yTest');

            for h=1:size(X,1)
                predictions(h) = sum(X(h,:)' .* theta);
            end

            errTraning(i,k) = immse(predictions,y');

            if(deltaMSE > abs(mseLast - thisMSE))
                 break;
            else
                mseLast = thisMSE;
            end
            errTest(i,k) = thisMSE;
        end
        
        epochsCount(i) = k;
        rsquaredTestCount(i) = rsquaredTest(i,k);
        errTestCount(i) = thisMSE;
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

    epochsMean = mean2(epochsCount);
    epochsSD = std(epochsCount);
    errTestMean = mean2(errTestCount);
    errTestSD = std(errTestCount);
    rsquaredTestMean = mean2(rsquaredTestCount);
    rsquaredTestSD = std(rsquaredTestCount);
    
    AlphaTuning(a,1) = alpha(a);
    AlphaTuning(a,2) = epochsMean;
    AlphaTuning(a,3) = epochsSD;
    AlphaTuning(a,4) = rsquaredTestMean;
    AlphaTuning(a,5) = rsquaredTestSD;
    AlphaTuning(a,6) = errTestMean;
    AlphaTuning(a,7) = errTestSD;
end

%toc(t1);%compute elapsed time

% Plot
%plotRSS(rsquaredTest,rsquaredTraning,NumberOfReperts,1:size(errTest,2), size(X,2)-1, tblMovieCleaned.imdb_score);

%plotMSE(errTest,errTraning,NumberOfReperts,1:size(errTest,2), size(X,2)-1)

%plot(errTest(1,:));

%mean(ManuralTesting(1,:))
%mean(ManuralTesting(2,:))

%mean(timeToTrain)
%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

