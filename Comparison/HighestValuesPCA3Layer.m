comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayerPCA/140tunePCAHiddenLayer3Layers.mat'};
names = [];
means = [];
sds = [];
ephos = [];
ephosSds = [];

for listIndex = 1:length(comparisonList)
    load(comparisonList{listIndex});
    
    cleanedNames = []; 
    for strIndex = 1:length(hiddenLayerName)
        if mod(strIndex,6) == 0
            cleanedNames = [cleanedNames {strcat('140--',num2str(hiddenLayerName(strIndex)), '--55')}];
        elseif mod(strIndex,5) == 0
            cleanedNames = [cleanedNames {strcat('140--',num2str(hiddenLayerName(strIndex)), '--45')}];
        elseif mod(strIndex,4) == 0
            cleanedNames = [cleanedNames {strcat('140--',num2str(hiddenLayerName(strIndex)), '--35')}];
         elseif mod(strIndex,3) == 0
            cleanedNames = [cleanedNames {strcat('140--',num2str(hiddenLayerName(strIndex)), '--25')}];
        elseif mod(strIndex,2) == 0
            cleanedNames = [cleanedNames {strcat('140--',num2str(hiddenLayerName(strIndex)), '--15')}];
        else
            cleanedNames = [cleanedNames {strcat('140--',num2str(hiddenLayerName(strIndex)), '--5')}];
        end
    end
    names = [names cleanedNames];
    means = [means hiddenLayerTestMean];
    sds = [sds hiddenLayerTestSD];
    ephos = [ephos hiddenLayerEpochMean];
    ephosSds = [ephosSds hiddenLayerEpochSD];
end

[b, indexes] = sort(means, 'descend');
names(indexes(1:10))
[pScore, bestRMeanCase] = tTestRsquared(indexes(1:10), means, sds,10);
pScore
bestRMeanCase
names(indexes(bestRMeanCase))

[b1, indexes1] = sort(ephos(indexes(bestRMeanCase)), 'ascend');
[pScoreE, bestEpohsMeanCase] = tTestEphos(indexes(indexes1), ephos, ephosSds,10);
pScoreE
bestEpohsMeanCase
names(indexes(indexes1(bestEpohsMeanCase)))
