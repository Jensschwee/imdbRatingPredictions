% Split data into training and test data
trainingSetSize = 0.85; %Size of the traning set in %
tblIndex = randperm(length(tblMovieNoOutliers.movie_imdb_link));
testSize = length(tblMovieNoOutliers.movie_imdb_link)*(1-trainingSetSize);
trainingSize = length(tblMovieNoOutliers.movie_imdb_link)*trainingSetSize;

%Spilt data ind i tables
tblTest = tblMovieNoOutliers(tblIndex(1:testSize),:);
tblTraining = tblMovieNoOutliers(tblIndex(testSize+1:testSize+trainingSize),:);

clear tblIndex
clear testSize
clear trainingSize
clear trainingSetSize

modelspec = 'sys ~ age + wgt + sex + smoke';
mdl = fitlm(tblTraining,modelspec) 

