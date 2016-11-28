%http://hugofeng.info/2014/06/05/bp_ann_in_matlab/
clc
clear all
close all

%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

amountOfSampels=size(tblMovieCleaned,1);


% Plot config
repeats = 2;
errorbarGap = 1;

%---Set training parameters
errorThreshhold = 0.0001;
learningRate = 0.00001;
validationCheck = 5; %How many times may the model not get better?
errorbarGap = 1;
hiddenNeurons = [50 20 25 15 10];

%epochs = 50;
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

        err(iter) = sum(error.^2)/(size(validationInp,1)-size(validationInp,2));

        %---Stop if reach error threshold
        if (iter > 1)
            if(errorThreshhold < (err(iter) - err(iter-1)))
                if(validationCurrent ~= 0)
                    validationCurrent = validationCurrent-1;
                else
                    break;
                end
            end
        end
        
    end

    %plot(err);

    %--Test the trained network with a test set
    error = zeros(testsetCount, outArgc);
    for t = 1:testsetCount
        [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell);
        p(t) = predict;
        error(t, : ) = predict - testRealOut(t, :);
    end
       
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
end

%---Print predictions
fprintf('Ended with %d epochs.\n', iter);
a = testInp;
b = testRealOut;
c = p';
x1_x2_act_pred_err = [a b c c-b];
hist(x1_x2_act_pred_err(:,size(x1_x2_act_pred_err,2)));

plot(error)

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

