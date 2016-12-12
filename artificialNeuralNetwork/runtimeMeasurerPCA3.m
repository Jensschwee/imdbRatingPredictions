%http://hugofeng.info/2014/06/05/bp_ann_in_matlab/
clc
clear all
%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

% Config
repeats = 10;
epochs = 300;
errorThreshhold = 0.0001;
learningRate = 0.0005;

% Tuning parameter
hiddenNeuronRange = 5:5:200;

hiddenLayerName = [];
hiddenLayerTestMean = [];
hiddenLayerTestSD = [];
hiddenLayerEpochMean = [];
hiddenLayerEpochSD = [];
hiddenLayerFinalMSEMean = [];
hiddenLayerFinalMSESD = [];

hiddenNeurons = [140 120 55];

%---Add output layer
layerOfNeurons = [hiddenNeurons, 1];
layerCount = size(layerOfNeurons, 2);

for repeat = 1:repeats;
    %---Weight and bias random range using tansig scale
    [trainInd,valInd,testInd] = dividerand(size(tblMovieCleaned,1),0.7,0.15,0.15);%select data randomly
    amountOfSampels=size(tblMovieCleaned,1);

    % Input and output parameteres
    input = table2array(tblMovieCleaned(:, 1)); %Color
    input = [input, table2array(tblMovieCleaned(:, 2))]; %Duration
    input = [input, table2array(tblMovieCleaned(:, 13))]; %director_facebook_likes
    input = [input, table2array(tblMovieCleaned(:, 12))]; %cast_total_facebook_likes
    input = [input, table2array(tblMovieCleaned(:, 14:36))]; %genre
    input = [input, table2array(tblMovieCleaned(:, 55:93))]; %language
    input = [input, table2array(tblMovieCleaned(:, 94:155))]; %country
    input = [input, table2array(tblMovieCleaned(:, 128:133))]; %content_rating
    input = [input, table2array(tblMovieCleaned(:, 156:243))]; %title_year
    input = [input, table2array(tblMovieCleaned(:, 244:262))]; %aspect_ratio
    input = [input, table2array(tblMovieCleaned(:, 37:54))]; %facenumber_in_poster
    output = table2array(tblMovieCleaned(:, 10));
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
    %---Weight and bias random range
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
            % choice = randi([1 trainsetCount]);
            %choice = i;
            choice = sqens(i);
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
        %figure(1);
        %plot(err);

        %plot overall network error at end of each iteration
        %error = zeros(size(validationInp,1), outArgc);
        %for t = 1:size(validationInp,1)
        %    [predict, layeroutput] = ForwardNetwork(validationInp(t, :), layerOfNeurons, weightCell);
        %    p(t) = predict;
        %    
        %    error(t, : ) = predict - validationOut(t, :);
        %end
        %err(iter) = (sum(error.^2)/(size(validationInp,1) - size(validationInp,2) - 1))^0.5;
        %figure(1);
        %plot(err);


        %---Stop error threshold is reached
        if (iter > 1)
            deltaErr = abs(err(iter) - err(iter-1));
            if(errorThreshhold > deltaErr)
                break;
            end
        end

    end

    fprintf('Repeat %d ended with %d epochs.\n', repeat, iter);

    time(repeat) = toc(t1(repeat));
    epochNum(repeat) = iter;
    finalMse(repeat) = err(iter);
    finalTestRsq(repeat) = rSquaredTest(repeat, iter);

    %--Test the trained network with a test set
    testsetCount = size(testInp, 1);
    error = zeros(testsetCount, outArgc);
    predictions = zeros(testsetCount, outArgc);
    for t = 1:testsetCount
        [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell);
        p(t) = predict;
        error(t, :) = predict - testRealOut(t, :);
    end
end;


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
end

hiddenLayerName = [hiddenLayerName, numHidden];
hiddenLayerTimeMean = [hiddenLayerName, mean(time(1,:))];
hiddenLayerTimeSD = [hiddenLayerName, std(time(1,:))];
hiddenLayerTestMean = [hiddenLayerTestMean, mean(finalTestRsq(1, :))];
hiddenLayerTestSD = [hiddenLayerTestSD, std(finalTestRsq(1, :))];
hiddenLayerEpochMean = [hiddenLayerEpochMean, mean(epochNum(1,:))];
hiddenLayerEpochSD = [hiddenLayerEpochSD, std(epochNum(1,:))];
hiddenLayerFinalMSEMean = [hiddenLayerFinalMSEMean, mean(finalMse(1,:))];
hiddenLayerFinalMSESD = [hiddenLayerFinalMSESD, std(finalMse(1,:))];

tblMedian(1:size(tblMovieCleaned,1)) = median(tblMovieCleaned.imdb_score);
tblMedianOfSet(1:size(rSquaredTrain,2)) = rSquareValue(tblMedian,tblMovieCleaned.imdb_score);

%figure
%hold on
%set(gca,'fontsize',18)
%errorbar(1:errorbarGap:size(rSquaredTest,2),rSquaredTrainMean,rSquaredTrainSd,'color', [1 0 0])
%errorbar(1:errorbarGap:size(rSquaredTest,2),rSquaredValidationMean,rSquaredValidationSd,'color', [0 1 0])
%errorbar(1:errorbarGap:size(rSquaredTest,2),rSquaredTestMean,rSquaredTestSd,'color', [0 0 1])
%line(1:size(rSquaredTest,2),tblMedianOfSet, 'Color', [0.6 0.6 0.6])
%xlabel('Number Of Epochs')
%ylabel('r squared')
%legend('Train','Validation','Test','Median','Location','northwest')
%set(gca, 'Xlim', [-1 size(rSquaredTest, 2)+5])
%title(strcat({'ANN with '}, num2str(hiddenNeurons), {' hidden neurons, '}, num2str(learningRate), {' learning rate'} ))
%hold off

hiddenLayerTestMean

%clear input
%clear output
%clear tblMovieCleaned

