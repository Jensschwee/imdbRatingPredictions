comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayerPCA/tunePCAHiddenLayer2Layers.mat',...
    '../artificialNeuralNetwork/ANNHiddenLayerPCA/tuneANNPCA105DualHiddenLayer.mat'...
    '../artificialNeuralNetwork/ANNHiddenLayerPCA/tuneANNPCA165DualHiddenLayer.mat'...
     '../artificialNeuralNetwork/ANNHiddenLayerPCA/60-120,5-60TunePCAHiddenLayer.mat'...
    };

names = [];
means = [];
sds = [];
ephos = [];
ephosSds = [];

for listIndex = 1:length(comparisonList)
    load(comparisonList{listIndex});
    
    cleanedNames = []; 
    for strIndex = 1:length(hiddenLayerName)
        if listIndex == 2
            cleanedNames = [cleanedNames {strcat('105--',num2str(hiddenLayerName(strIndex)))}];
        elseif listIndex == 3
            cleanedNames = [cleanedNames {strcat('165--',num2str(hiddenLayerName(strIndex)))}];
        elseif listIndex == 1
            cleanedNames = [cleanedNames {strcat('5--',num2str(hiddenLayerName(strIndex)))}];
        else
            cleanedNames = [cleanedNames {strcat('10--',num2str(hiddenLayerName(strIndex)))}];
        end
    end
    names = [names cleanedNames];
    means = [means hiddenLayerTestMean];
    sds = [sds hiddenLayerTestSD];
    ephos = [ephos hiddenLayerEpochMean];
    ephosSds = [ephosSds hiddenLayerEpochSD];
end

[b, indexes] = sort(means, 'descend');

[pScore, bestRMeanCase] = tTestRsquared(indexes(1:10), means, sds,10);
pScore
bestRMeanCase
names(indexes(bestRMeanCase));

[b1, indexes1] = sort(ephos(indexes(bestRMeanCase)), 'ascend');
[pScoreE, bestEpohsMeanCase] = tTestEphos(indexes(indexes1), ephos, ephosSds,10);
pScoreE(indexes1)
bestEpohsMeanCase
names(indexes(indexes1(bestEpohsMeanCase)));
