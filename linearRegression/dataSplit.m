function [tblTest, tblTraining] = dataSpilit(tbl)
    % Split data into training and test data
    trainingSetSize = 0.85; %Size of the traning set in %
    tblIndex = randperm(length(tbl.movie_imdb_link));
    testSize = length(tbl.movie_imdb_link)*(1-trainingSetSize);
    trainingSize = length(tbl.movie_imdb_link)*trainingSetSize;

    %Spilt data ind i tables
    tblTest = tbl(tblIndex(1:testSize),:);
    tblTraining = tbl(tblIndex(testSize+1:testSize+trainingSize),:);

    clear tblIndex
    clear testSize
    clear trainingSize
    clear trainingSetSize
end