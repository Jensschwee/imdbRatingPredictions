% Split data into training and test data
trainingSetSize = 0.85; %Size of the traning set in %
tblIndex = randperm(length(tblMovie.movie_imdb_link));
testSize = length(tblMovie.movie_imdb_link)*(1-trainingSetSize);
trainingSize = length(tblMovie.movie_imdb_link)*trainingSetSize;

%Spilt data ind i tables
tblTest = tblMovie(tblIndex(1:testSize),:);
tblValidation = tblMovie(tblIndex(testSize+1:testSize+trainingSize),:);

clear tblIndex
clear testSize
clear trainingSize
clear trainingSetSize