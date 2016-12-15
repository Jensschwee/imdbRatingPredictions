comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayerPCA/tuneANNPCASingleHiddenLayer.mat'};

names = [];
means = [];
sds = [];
ephos = [];
ephosSds = [];

for listIndex = 1:length(comparisonList)
    load(comparisonList{listIndex});
    names = [names hiddenLayerName];
    means = [means hiddenLayerTestMean];
    sds = [sds hiddenLayerTestSD];
    ephos = [ephos hiddenLayerEpochMean];
    ephosSds = [ephosSds hiddenLayerEpochSD];
end

[b, indexes] = sort(means, 'descend');

[pScore1, bestRMeanCase] = tTestRsquared(indexes(1:10), means, sds,10);
pScore1
bestRMeanCase
names(indexes(bestRMeanCase))

[b1, indexes1] = sort(ephos(indexes(bestRMeanCase)), 'ascend');
[pScoreE, bestEpohsMeanCase] = tTestEphos(indexes(indexes1), ephos, ephosSds,10);
pScoreE
bestEpohsMeanCase
names(indexes(indexes1(bestEpohsMeanCase)))
