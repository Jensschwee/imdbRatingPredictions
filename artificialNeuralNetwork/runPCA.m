%http://hugofeng.info/2014/06/05/bp_ann_in_matlab/
clc
clear all
close all

%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

amountOfSampels=size(tblMovieCleaned,1);


% Plot config
repeats = 10;
errorbarGap = 2;
validationCheck = 5; % How many times may the model not get better?
learningRate = 0.001;
hiddenNeurons = [25 10];
errorThreshhold = 0.0001;
epochs = 200;
%errorThreshhold = 0.000001;
%learningRate = 0.001;
%hiddenNeurons = [25 10];



%---Add output layer
layerOfNeurons = [hiddenNeurons, 1];
layerCount = size(layerOfNeurons, 2);


for repeat = 1:repeats;
    
    validationCurrent = validationCheck;
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

    %plot(err);

    %--Test the trained network with a test set
    error = zeros(testsetCount, outArgc);
    for t = 1:testsetCount
        [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell);
        p(t) = predict;
        error(t, : ) = predict - testRealOut(t, :);
    end

%plot(err);

rSquareValue(p',testRealOut);

% Shitty code
count = 1;
for e = 1:errorbarGap:size(rSquaredTest,2)
    rSquaredTrainMean(count) = mean(rSquaredTrain(find(rSquaredTrain(:,e) ~= 0),e));
    rSquaredTrainSd(count) = std(rSquaredTrain(find(rSquaredTrain(:,e) ~= 0),e));
    rSquaredValidationMean(count) = mean(rSquaredValidation(find(rSquaredValidation(:,e) ~= 0),e));
    rSquaredValidationSd(count) = std(rSquaredValidation(find(rSquaredValidation(:,e) ~= 0),e));
    rSquaredTestMean(count) = mean(rSquaredTest(find(rSquaredTest(:,e) ~= 0),e));
    rSquaredTestSd(count) = std(rSquaredTest(find(rSquaredTest(:,e) ~= 0),e));
    count = count + 1;
end;

%---Print predictions
fprintf('Ended with %d epochs.\n', iter);

end

%plot(error)

tblMedian(1:size(tblMovieCleaned,1)) = median(tblMovieCleaned.y50);
tblMedianOfSet(1:size(rSquaredTrain,2)) = rSquareValue(tblMedian,tblMovieCleaned.y50);

figure
hold on
set(gca,'fontsize',18)
xlabel('Number Of Epochs')
ylabel('r squared')
errorbar(1:errorbarGap:size(rSquaredTest, 2),rSquaredTrainMean,rSquaredTrainSd,'color', [1 0 0])
errorbar(1:errorbarGap:size(rSquaredTest, 2),rSquaredValidationMean,rSquaredValidationSd,'color', [0 1 0])
errorbar(1:errorbarGap:size(rSquaredTest, 2),rSquaredTestMean,rSquaredTestSd,'color', [0 0 1])
line(1:size(rSquaredTest,2),tblMedianOfSet, 'Color', [0.6 0.6 0.6])
legend('Train','Validation','Test','Median','Location','northwest')
set(gca, 'Xlim', [-1 size(rSquaredTest, 2)+5])
title(strcat({'ANN with '}, num2str(hiddenNeurons), {' neurons '}, num2str(learningRate), {' Learning Rate'} ))
hold off

%clear input
%clear output
%clear tblMovieCleaned

