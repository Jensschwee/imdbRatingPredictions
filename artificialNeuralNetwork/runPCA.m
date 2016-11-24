%http://hugofeng.info/2014/06/05/bp_ann_in_matlab/
clc
clear all
close all

%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned_pca.csv');

[trainInd,valInd,testInd] = dividerand(size(tblMovieCleaned,1),0.7,0.15,0.15);%select data randomly
amountOfSampels=size(tblMovieCleaned,1);

% Input and output parameteres
input = table2array(tblMovieCleaned(:, 1:size(tblMovieCleaned,2)-2));
output = table2array(tblMovieCleaned(:, size(tblMovieCleaned,2)));

%---Set training parameters
iterations = 50;
errorThreshhold = 0.000001;
learningRate = 0.001;
%---Set hidden layer type, for example: [4, 3, 2]
hiddenNeurons = [25 10];

trainInp = input(trainInd,:);
trainOut = output(trainInd);
validationInp = input(valInd,:);
validationOut = output(valInd);
testInp = input(testInd,:);
testRealOut = output(testInd);

assert(size(trainInp,1)==size(trainOut, 1),'Counted different sets of input and output.');

%---Initialize Network attributes
inArgc = size(trainInp, 2);
outArgc = size(trainOut, 2);
trainsetCount = size(trainInp, 1);
testsetCount = size(testInp, 1);

%---Add output layer
layerOfNeurons = [hiddenNeurons, outArgc];
layerCount = size(layerOfNeurons, 2);

%---Weight and bias random range using tansig scale
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
for iter = 1:iterations
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
    
    rSquredTrain(iter) = rSquareValue(pre',trainOut);
    
    %plot overall network error at end of each iteration
    error = zeros(size(validationInp,1), outArgc);
    for t = 1:size(validationInp,1)
        [predict, layeroutput] = ForwardNetwork(validationInp(t, :), layerOfNeurons, weightCell);
        p(t) = predict;
        error(t, : ) = predict - validationOut(t, :);
    end
    rSquredValidation(iter) = rSquareValue(p',validationOut);
    
    for t = 1:testsetCount
        [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell);
        p(t) = predict;
    end
    
    rSquredTest(iter) = rSquareValue(p',testRealOut);
        
    err(iter) = sum(error.^2)/(size(validationInp,1)-size(validationInp,2));
    
    %---Stop if reach error threshold
    if err(iter) < errorThreshhold
        break;
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

rSquareValue(p',testRealOut)

%---Print predictions
fprintf('Ended with %d iterations.\n', iter);
a = testInp;
b = testRealOut;
c = p';
x1_x2_act_pred_err = [a b c c-b];
hist(x1_x2_act_pred_err(:,size(x1_x2_act_pred_err,2)));

plot(error)


figure
hold on
set(gca,'fontsize',18)
xlabel('Number Of Epochs')
ylabel('r squared')
line(1:size(rSquredTrain,2),rSquredTrain, 'Color', [1 0 0 ])
line(1:size(rSquredValidation,2),rSquredValidation,'Color', [0 1 0 ])
line(1:size(rSquredTest,2),rSquredTest, 'Color', [0 0 1])
legend('Train','Validation','Test','Location','northwest')
title(strcat({'ANN with '}, num2str(hiddenNeurons), {' neurons '}, num2str(learningRate), {' Learning Rate'} ))
hold off

%clear input
%clear output
%clear tblMovieCleaned

