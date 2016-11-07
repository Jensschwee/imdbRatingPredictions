clc
clear all
%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

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
output = table2array(tblMovieCleaned(1:amountOfSampels, 245));

%---Set training parameters
iterations = 5000;
errorThreshhold = 0.1;
learningRate = 0.5;
%---Set hidden layer type, for example: [4, 3, 2]
hiddenNeurons = [3 2];

%---'Xor' training data
trainInp = input;
trainOut = output;
testInp = input;
testRealOut = output;

% %---'And' training data
% trainInp = [1 1; 1 0; 0 1; 0 0];
% trainOut = [1; 0; 0; 0];
% testInp = trainInp;
% testRealOut = trainOut;
assert(size(trainInp,1)==size(trainOut, 1),...
    'Counted different sets of input and output.');
%---Initialize Network attributes
inArgc = size(trainInp, 2);
outArgc = size(trainOut, 2);
trainsetCount = size(trainInp, 1);

%---Add output layer
layerOfNeurons = [hiddenNeurons, outArgc];
layerCount = size(layerOfNeurons, 2);

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
%---Set initial biases
biasCell = cell(1, layerCount);
for i = 1:layerCount
    biasCell{i} = unifrnd(b, e, 1, layerOfNeurons(i));
end
%----------------------
%---Begin training
%----------------------
for iter = 1:iterations
    for i = 1:trainsetCount
        % choice = randi([1 trainsetCount]);
        choice = i;
        sampleIn = trainInp(choice, :);
        sampleTarget = trainOut(choice, :);
        [realOutput, layerOutputCells] = ForwardNetwork(sampleIn, layerOfNeurons, weightCell, biasCell);
        [weightCell, biasCell] = BackPropagate(learningRate, sampleIn, realOutput, sampleTarget, layerOfNeurons, ...
            weightCell, biasCell, layerOutputCells);
    end
    %plot overall network error at end of each iteration
    error = zeros(trainsetCount, outArgc);
    for t = 1:trainsetCount
        [predict, layeroutput] = ForwardNetwork(trainInp(t, :), layerOfNeurons, weightCell, biasCell);
        p(t) = predict;
        error(t, : ) = predict - trainOut(t, :);
    end
    err(iter) = (sum(error.^2)/trainsetCount)^0.5;
    figure(1);
    plot(err);
    %---Stop if reach error threshold
    if err(iter) < errorThreshhold
        break;
    end
end

%--Test the trained network with a test set
testsetCount = size(testInp, 1);
error = zeros(testsetCount, outArgc);
for t = 1:testsetCount
    [predict, layeroutput] = ForwardNetwork(testInp(t, :), layerOfNeurons, weightCell, biasCell);
    p(t) = predict;
    error(t, : ) = predict - testRealOut(t, :);
end
%---Print predictions
fprintf('Ended with %d iterations.\n', iter);
a = testInp;
b = testRealOut;
c = p';
x1_x2_act_pred_err = [a b c c-b]
%---Plot Surface of network predictions
testInpx1 = [-1:0.1:1];
testInpx2 = [-1:0.1:1];
[X1, X2] = meshgrid(testInpx1, testInpx2);
testOutRows = size(X1, 1);
testOutCols = size(X1, 2);
testOut = zeros(testOutRows, testOutCols);
for row = [1:testOutRows]
    for col = [1:testOutCols]
        test = [X1(row, col), X2(row, col)];
        [out, l] = ForwardNetwork(test, layerOfNeurons, weightCell, biasCell);
        testOut(row, col) = out;
    end
end
figure(2);
surf(X1, X2, testOut);






clear input
clear output
clear tblMovieCleaned

