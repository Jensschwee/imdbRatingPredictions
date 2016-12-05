% Run script for Linear Regression
%https://github.com/quinnliu/machineLearning/tree/master/supervisedLearning/linearRegressionInMultipleVariables
clc
%close all
clear all

tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

NumberOfReperts = 1;
NumberOfIterations = 200;
alpha = 1;

deltaMSE = 0.01;
validationCheck = 5; %How manny times may the model not get better?

epochsTryed = []; %Epochs tryed in

tblMovieManuel=readtable('../movie_manualTesting_cleaned_pca.csv');

manuralInput = table2array(tblMovieManuel(:, 1:size(tblMovieManuel,2)-2));

manuralInput = [ones(length(table2array(tblMovieManuel(:, size(tblMovieManuel,2)))), 1) manuralInput];
t1 = tic;%initilise counter

epochsTryed = NumberOfIterations;
for i=1:NumberOfReperts;
    [tblTest, tblTraining] = dataSplit(tblMovieCleaned);

    X = table2array(tblTraining(:, 1:size(tblTraining,2)-2));
    y = table2array(tblTraining(:, size(tblTraining,2)));

    XTest = table2array(tblTest(:, 1:size(tblTest,2)-2));
    yTest = table2array(tblTest(:, size(tblTest,2)));
    XTest = [ones(length(yTest), 1) XTest];

    %num_iters = NumberOfIterations(k);

    % Init Theta and Run Gradient Descent 
    X = [ones(length(y), 1) X];
    theta = [1 rand(1,(size(X,2)-1))]';
    
    mseLast = 100000;
    
    t1 = tic;%initilise counter
    for k=1:NumberOfIterations
        for j=1:1
            % Gradient Descent
            [theta] = gradientDescent(X, y, theta, alpha);
        end
        for h=1:size(XTest,1)
            testPrediction(h) = sum(XTest(h,:)' .* theta);
        end
        % Eval
        rsquaredTest(i,k) = evaluateRegressionPCA(tblTest,theta);
        rsquaredTraning(i,k) = evaluateRegressionPCA(tblTraining,theta);
        thisMSE = immse(testPrediction,yTest');
        if(deltaMSE > abs(mseLast - thisMSE))
            if(validationCheck > 0)
                validationCheck = validationCheck-1;
            else
                 break;
            end
        else
            mseLast = thisMSE;
        end
        errTest(i,k) = thisMSE;
        
        for h=1:size(X,1)
            predictions(h) = sum(X(h,:)' .* theta);
        end
        
        errTraning(i,k) = immse(predictions,y');
    end
    timeToTrain(i) = toc(t1);%compute elapsed time

    ManuralTesting(1,i) = sum(manuralInput(1,:)' .* theta);
    ManuralTesting(2,i) = sum(manuralInput(2,:)' .* theta);   
end;
%Has the model become better?
%if (i > 1)
%        if(deltaRSqured > (mean2(err(i,:)) - mean2(err(i-1,:))))
%            if(validationCheck ~= 0)
%                validationCheck = validationCheck-1;
%            else
%                break;
%            end
%        end
%    end

mean(timeToTrain)

% Plot
plotRSS(rsquaredTest,rsquaredTraning,NumberOfReperts,1:size(rsquaredTest,2), size(X,2)-1, tblMovieCleaned.y65);

plotMSE(errTest,errTraning,NumberOfReperts,1:size(errTest,2), size(X,2)-1)

mean(ManuralTesting(1,:))
mean(ManuralTesting(2,:))

%medianOfVaules = ones(length(tblMovieCleaned.y50),1);
%medianOfVaules(1:size(tblMovieCleaned.y50)) = median(tblMovieCleaned.y50);
%rSquareValue(medianOfVaules,tblMovieCleaned.y50)

%clear RSS
%clear alpha
%clear num_iters
%clear theta
%celear X
%clear y
%clear tblTest
%clear tblTraining

