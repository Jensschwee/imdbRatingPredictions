function [RSS] = evaluateRegression(tblTest,theta)
%EVAL This function evaluates results from linear regression
%   Detailed stuff..
X = table2array(tblTest(:, 4)); %Duration
%X = [X, table2array(tblTraining(:, 4))]; %Duration
X = [X, table2array(tblTest(:, 5))]; %director_facebook_likes
X = [X,table2array(tblTest(:, 6))]; %actor_3_facebook_likes
X = [X,table2array(tblTest(:, 8))]; %actor_1_facebook_likes
X = [X,table2array(tblTest(:, 14))]; %cast_total_facebook_likes
X = [X, table2array(tblTest(:, 16))]; %facenumber_in_poster
X = [X, table2array(tblTest(:, 29:50))]; %genre
y = table2array(tblTest(:, 51));
X = [ones(length(y), 1) X];
estimateRevenue = X * theta; 

error = y - estimateRevenue;

RSS = sum(error.^2);

end