%http://hugofeng.info/2014/06/05/bp_ann_in_matlab/
clc
clear all
%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

[trainInd,valInd,testInd] = dividerand(size(tblMovieCleaned,1),0.7,0.15,0.15);%select data randomly
amountOfSampels=size(tblMovieCleaned,1);

% Input and output parameteres
input = table2array(tblMovieCleaned(1:amountOfSampels, 1)); %Color
input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 4))]; %Duration
%input = [input, table2array(tblMovieCleaned(:, 5))]; %director_facebook_likes
%input = [input,table2array(tblMovieCleaned(:, 6))]; %actor_3_facebook_likes
%input = [input,table2array(tblMovieCleaned(:, 8))]; %actor_1_facebook_likes
 input = [input,table2array(tblMovieCleaned(1:amountOfSampels, 14))]; %cast_total_facebook_likes
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 226:244))]; %facenumber_in_poster
%input = [input, table2array(tblMovieCleaned(:, 25))]; %actor_2_facebook_likes
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 29:50))]; %genre
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 51:84))]; %language
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 85:127))]; %country
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 128:133))]; %content_rating
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 134:207))]; %title_year
 input = [input, table2array(tblMovieCleaned(1:amountOfSampels, 208:225))]; %aspect_ratio
output = table2array(tblMovieCleaned(1:amountOfSampels, 26));

%---Set training parameters
repeats = 2;
errorbarGap = 10
epochs = 200;
errorThreshhold = 0.001;
learningRate = 0.00005;
%---Set hidden layer type, for example: [4, 3, 2]
hiddenNeurons = [25];

%iterations = 50;
%errorThreshhold = 0.001;
%learningRate = 0.0005;
%---Set hidden layer type, for example: [4, 3, 2]
%hiddenNeurons = [25 10 3];

%learningRate = 0.005;
%---Set hidden layer type, for example: [4, 3, 2]
%hiddenNeurons = [25 10];

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




for repeat = 1:repeats;
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

        err(iter) = (sum(error.^2)/(size(validationInp,1)-size(validationInp,2)))^0.5;
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


        %---Stop if reach error threshold
        if err(iter) < errorThreshhold
            break;
        end
    end

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
for e = 1:errorbarGap:epochs
    rSquaredTrainMean(count) = mean(rSquaredTrain(:,e));
    rSquaredTrainSd(count) = std(rSquaredTrain(:,e));
    rSquaredValidationMean(count) = mean(rSquaredValidation(:,e));
    rSquaredValidationSd(count) = std(rSquaredValidation(:,e));
    rSquaredTestMean(count) = mean(rSquaredTest(:,e));
    rSquaredTestSd(count) = std(rSquaredTest(:,e));
    count = count + 1;
end



tblMedian(1:size(tblMovieCleaned,1)) = median(tblMovieCleaned.imdb_score);
tblMedianOfSet(1:size(rSquaredTrain,2)) = rSquareValue(tblMedian,tblMovieCleaned.imdb_score);

figure
hold on
set(gca,'fontsize',18)
errorbar(1:errorbarGap:epochs,rSquaredTrainMean,rSquaredTrainSd,'color', [1 0 0])
errorbar(1:errorbarGap:epochs,rSquaredValidationMean,rSquaredValidationSd,'color', [0 1 0])
errorbar(1:errorbarGap:epochs,rSquaredTestMean,rSquaredTestSd,'color', [0 0 1])
line(1:size(rSquaredTest,2),tblMedianOfSet, 'Color', [0.6 0.6 0.6])
xlabel('Number Of Epochs')
ylabel('r squared')
%line(1:size(rSquaredTrain,2),rSquaredTrain, 'Color', [1 0 0 ])
%line(1:size(rSquaredValidation,2),rSquaredValidation,'Color', [0 1 0 ])
%line(1:size(rSquaredTest,2),rSquaredTest, 'Color', [0 0 1])
legend('Train','Validation','Test','Median','Location','northwest')
set(gca, 'Xlim', [-1 epochs+5])
title(strcat({'ANN with '}, num2str(hiddenNeurons), {' neurons '}, num2str(learningRate), {' Learning Rate'} ))
hold off

%---Print predictions
fprintf('Ended with %d epochs.\n', iter);
a = testInp;
b = testRealOut;
c = p';
x1_x2_act_pred_err = [a b c c-b];
%hist(x1_x2_act_pred_err(:,size(x1_x2_act_pred_err,2)));
%clear input
%clear output
%clear tblMovieCleaned

