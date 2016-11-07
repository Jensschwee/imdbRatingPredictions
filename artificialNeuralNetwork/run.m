clc
clear all
%read data soruce
tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

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

%

clear input
clear output
clear tblMovieCleaned

