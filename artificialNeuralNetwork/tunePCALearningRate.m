%http://hugofeng.info/2014/06/05/bp_ann_in_matlab/
clc
clear all
close all

%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

amountOfSampels=size(tblMovieCleaned,1);

% Config
repeats = 10;
epochs = 300;
errorThreshhold = 0.0001;
hiddenNeurons = [140 35 55];

% Tuning parameter
learningRates = [0.00001 0.00005 0.0001 0.0005 0.001 0.005 0.01 0.05];

learningRateName = [];
learningRateTestMean = [];
learningRateTestSD = [];
learningRateEpochMean = [];
learningRateEpochSD = [];
learningRateTimeMean = [];
learningRateTimeSD = [];
learningRateFinalMSEMean = [];
learningRateFinalMSESD = [];

for learningRate = learningRates
    learningRate

    %---Add output layer
    layerOfNeurons = [hiddenNeurons, 1];
    layerCount = size(layerOfNeurons, 2);

    for repeat = 1:repeats;
        %---Weight and bias random range using tansig scale
        % Input and output parameteres
        [trainInd,valInd,testInd] = dividerand(size(tblMovieCleaned,1),0.7,0.15,0.15);%select data randomly
        input = table2array(tblMovieCleaned(:, 1:size(tblMovieCleaned,2)-2));
        output = table2array(tblMovieCleaned(:, size(tblMovieCleaned,2)));

        trainInp = input(trainInd,:);
        trainOut = output(trainInd);
        validationInp = input(valInd,:);
        validationOut = output(valInd);
        testInp = input(testInd,:);
        testRealOut = output(testInd);

        %---Initialize Network attributes
        inArgc = size(trainInp, 2);
        outArgc = size(trainOut, 2);
        trainsetCount = size(trainInp, 1);
        testsetCount = size(testInp, 1);

        e = 1;
        b = -e;
        %---Set initial random weights
        weightCell = cell(1, layerCount);
        for i = 1:layerCount
            if i == 1
                weightCell{1} = unifrnd(b, e, inArgc,layerOfNeurons(1));
            else
                weightCell{i} = unifrnd(b, e, layerOfNeurons(i-1),layerOfNeurons(i));
            end
        end


        t1(repeat) = tic;

        %----------------------
        %---Begin training
        %----------------------
        for iter = 1:epochs
            sqens = datasample(1:trainsetCount,trainsetCount,'Replace',false);
            for i = 1:trainsetCount
                choice = sqens(i);
                %choice = i;
                sampleIn = trainInp(choice, :);
                sampleTarget = trainOut(choice, :);
                [realOutput, layerOutputCells] = ForwardNetwork(sampleIn, layerOfNeurons, weightCell);
                weightCell = BackPropagate(learningRate, sampleIn, realOutput, sampleTarget, layerOfNeurons, weightCell, layerOutputCells);
            end

            for t = 1:trainsetCount
                [predict, layeroutput] = ForwardNetwork(trainInp(t, :), layerOfNeurons, weightCell);
                pre(t) = predict;
            end

            rSquaredTrain(repeat, iter) = rSquareValue(pre',trainOut);

            %plot overall network error at end of each iteration
            error = zeros(size(validationInp,1), outArgc);
            for t = 1:size(validationInp,1)
                [predict, layeroutput] = ForwardNetwork(validationInp(t, :), layerOfNeurons, weightCell);
                p(t) = predict;
                error(t, : ) = predict - validationOut(t, :);
            end
            rSquaredValidation(repeat, iter) = rSquareValue(p',validationOut);

            for t = 1:testsetCount
                [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell);
                p(t) = predict;
            end

            rSquaredTest(repeat, iter) = rSquareValue(p',testRealOut);

            %err(iter) = (sum(error.^2)/(size(validationInp,1)-size(validationInp,2)))^0.5;% RMSE
            err(iter) = sum(error.^2)/(size(validationInp,1)-size(validationInp,2));% MSE

            %---Stop if reach error threshold
            if (iter > 1)
                deltaErr = abs(err(iter) - err(iter-1));
                if(errorThreshhold > deltaErr)
                    break;
                end
            end

        end

        time(repeat) = toc(t1(repeat));
        epochNum(repeat) = iter;
        finalMse(repeat) = err(iter);
        finalTestRsq(repeat) = rSquaredTest(repeat, iter);
        
        fprintf('Repeat %d ended with %d epochs.\n', repeat, iter);

        %--Test the trained network with a test set
        error = zeros(testsetCount, outArgc);
        for t = 1:testsetCount
            [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell);
            p(t) = predict;
            error(t, :) = predict - testRealOut(t, :);
        end

    end

    %plot(err);

    rSquareValue(p',testRealOut);

    % Shitty code
    count = 1;
    for e = 1:size(rSquaredTest,2)
        rSquaredTrainMean(count) = mean(rSquaredTrain(find(rSquaredTrain(:,e) ~= 0),e));
        rSquaredTrainSd(count) = std(rSquaredTrain(find(rSquaredTrain(:,e) ~= 0),e));
        rSquaredValidationMean(count) = mean(rSquaredValidation(find(rSquaredValidation(:,e) ~= 0),e));
        rSquaredValidationSd(count) = std(rSquaredValidation(find(rSquaredValidation(:,e) ~= 0),e));
        rSquaredTestMean(count) = mean(rSquaredTest(find(rSquaredTest(:,e) ~= 0),e));
        rSquaredTestSd(count) = std(rSquaredTest(find(rSquaredTest(:,e) ~= 0),e));
        count = count + 1;
    end;
    
    learningRateName = [learningRateName, learningRate];
    learningRateTestMean = [learningRateTestMean, mean(finalTestRsq(1, :))];
    learningRateTestSD = [learningRateTestSD, std(finalTestRsq(1, :))];
    learningRateEpochMean = [learningRateEpochMean, mean(epochNum(1,:))];
    learningRateEpochSD = [learningRateEpochSD, std(epochNum(1,:))];
    learningRateTimeMean = [learningRateTimeMean, mean(time)];
    learningRateTimeSD = [learningRateTimeSD, std(time)];
    learningRateFinalMSEMean = [learningRateFinalMSEMean, mean(finalMse(1,:))];
    learningRateFinalMSESD = [learningRateFinalMSESD, std(finalMse(1,:))];

    tblMedian(1:size(tblMovieCleaned,1)) = median(tblMovieCleaned.y50);
    tblMedianOfSet(1:size(rSquaredTrain,2)) = rSquareValue(tblMedian,tblMovieCleaned.y50);
 
end   
%clear input
%clear output
%clear tblMovieCleaned

