clc
clear all
close all

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

%Fild data set
X = table2array(tblMovieCleaned(:, 1)); %Color
X = [X, table2array(tblMovieCleaned(:, 4))]; %Duration
X = [X, table2array(tblMovieCleaned(:, 5))]; %director_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 6))]; %actor_3_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 8))]; %actor_1_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 14))]; %cast_total_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 226:244))]; %facenumber_in_poster
X = [X, table2array(tblMovieCleaned(:, 25))]; %actor_2_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 29:50))]; %genre
X = [X, table2array(tblMovieCleaned(:, 51:84))]; %language
X = [X, table2array(tblMovieCleaned(:, 85:127))]; %country
X = [X, table2array(tblMovieCleaned(:, 128:133))]; %content_rating
X = [X, table2array(tblMovieCleaned(:, 134:207))]; %title_year
X = [X, table2array(tblMovieCleaned(:, 208:225))]; %aspect_ratio

C=cov(X);
[V,L]=eig(C);
L=diag(L);
[Y,I]=sort(L,'descend');



