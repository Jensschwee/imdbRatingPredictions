tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

%NumberOfReperts = 50;

% Gradient Descent
X = table2array(tblMovieCleaned(:, 1)); %Color
X = [X, table2array(tblMovieCleaned(:, 4))]; %Duration
%X = [X, table2array(tblMovieCleaned(:, 5))]; %director_facebook_likes
%X = [X,table2array(tblMovieCleaned(:, 6))]; %actor_3_facebook_likes
%X = [X,table2array(tblMovieCleaned(:, 8))]; %actor_1_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 14))]; %cast_total_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 226:244))]; %facenumber_in_poster
%X = [X, table2array(tblMovieCleaned(:, 25))]; %actor_2_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 29:50))]; %genre
X = [X, table2array(tblMovieCleaned(:, 51:84))]; %language
X = [X, table2array(tblMovieCleaned(:, 85:127))]; %country
X = [X, table2array(tblMovieCleaned(:, 128:133))]; %content_rating
X = [X, table2array(tblMovieCleaned(:, 134:207))]; %title_year
X = [X, table2array(tblMovieCleaned(:, 208:225))]; %aspect_ratio
y = table2array(tblMovieCleaned(:, 245));

net = feedforwardnet([50]);%initialise network
%net.divideFcn = 'dividetrain'; %this will only train on the whole dataset (no validation)
net.divideFcn = 'divideind'; %divide data into training, validation and test sets
[trainInd,valInd,testInd] = dividerand(length(X),0.7,0.15,0.15);%select data randomly
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.00001;
net.trainParam.max_fail = 5;

t1 = tic;%initilise counter
net = train(net,x,t);%train network
toc(t1)%compute elapsed time