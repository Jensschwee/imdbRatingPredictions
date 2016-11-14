clc
clear all
tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

amountOfSampels = 500;

% Gradient Descent
X = table2array(tblMovieCleaned(1:amountOfSampels, 1)); %Color
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 4))]; %Duration
%X = [X, table2array(tblMovieCleaned(:, 5))]; %director_facebook_likes
%X = [X,table2array(tblMovieCleaned(:, 6))]; %actor_3_facebook_likes
%X = [X,table2array(tblMovieCleaned(:, 8))]; %actor_1_facebook_likes
X = [X,table2array(tblMovieCleaned(1:amountOfSampels, 14))]; %cast_total_facebook_likes
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 226:244))]; %facenumber_in_poster
%X = [X, table2array(tblMovieCleaned(:, 25))]; %actor_2_facebook_likes
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 29:50))]; %genre
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 51:84))]; %language
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 85:127))]; %country
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 128:133))]; %content_rating
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 134:207))]; %title_year
X = [X, table2array(tblMovieCleaned(1:amountOfSampels, 208:225))]; %aspect_ratio
y = table2array(tblMovieCleaned(1:amountOfSampels, 245));

net = feedforwardnet([50]);%initialise network
%net.divideFcn = 'dividetrain'; %this will only train on the whole dataset (no validation)
net.divideFcn = 'divideind'; %divide data into training, validation and test sets
[trainInd,valInd,testInd] = dividerand(size(X,1),0.7,0.15,0.15);%select data randomly
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.000000001;
net.trainParam.max_fail = 5;

t1 = tic;%initilise counter
net = train(net,X',y');%train network
toc(t1)%compute elapsed time

testNetwork = sim(net,X');%test network on the whole data set
MSE_tr=mean((y(trainInd)'-testNetwork(trainInd)).^2);%compute Mean Squared Error on the training set
MSE_v=mean((y(valInd)'-testNetwork(valInd)).^2);%compute Mean Squared Error on the validation set
MSE_t=mean((y(testInd)'-testNetwork(testInd)).^2);%compute Mean Squared Error on the test set

clear t1
clear testInd
clear trainInd
clear valInd
clear MSE_tr
clear MSE_v
clear MSE_t
clear amountOfSampels
clear testNetwork
clear net
clear X
clear y



