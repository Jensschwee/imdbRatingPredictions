function [tblTest, tblTraining] = dataSpilit(tbl)
    % Split data into training and test data
    trainingSetSize = 0.85; %Size of the traning set in %
    tblIndex = randperm(height(tbl));
    testSize = height(tbl)*(1-trainingSetSize);
    trainingSize = height(tbl)*trainingSetSize;
    warning('off','all')
      

    %Spilt data ind i tables
    tblTest = tbl(tblIndex(1:testSize),:);
    tblTraining = tbl(tblIndex(testSize+1:testSize+trainingSize),:);
    warning('on','all')
    clear tblIndex
    clear testSize
    clear trainingSize
    clear trainingSetSize
end