% Run script for Linear Regression
%run('../Datacleaning.m')
[tblTest, tblTraining] = dataSpilit(tblMovieNormalized);

% Gradient Descent
%X = table2array(tblTraining(:, 1)); %Color
X = table2array(tblTraining(:, 4)); %Duration
%X = [X, table2array(tblTraining(:, 4))]; %Duration
X = [X, table2array(tblTraining(:, 5))]; %director_facebook_likes
X = [X,table2array(tblTraining(:, 6))]; %actor_3_facebook_likes
X = [X,table2array(tblTraining(:, 8))]; %actor_1_facebook_likes
X = [X,table2array(tblTraining(:, 14))]; %cast_total_facebook_likes
X = [X, table2array(tblTraining(:, 16))]; %facenumber_in_poster
X = [X, table2array(tblTraining(:, 29:50))]; %genre
y = table2array(tblTraining(:, 51));
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
X = [ones(length(y), 1) X];
theta = zeros(29, 1);
[theta] = gradientDescent(X, y, theta, alpha, num_iters);

% Eval
normalizedInput = [1, 0.274193548387097, 0.00483333333333333];
estimatePriceUsingGradientDescent = normalizedInput * theta; 
% Plot