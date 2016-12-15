comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayerPCA/tunePCAHiddenLayer2Layers.mat',...
    '../artificialNeuralNetwork/ANNHiddenLayerPCA/tuneANNPCA105DualHiddenLayer.mat'...
    '../artificialNeuralNetwork/ANNHiddenLayerPCA/tuneANNPCA165DualHiddenLayer.mat'...
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

[b, indexes1] = sort(ephos(indexes(bestRMeanCase)), 'ascend');
[pScore, bestRMeanCase] = tTestRsquared(indexes(indexes1), ephos, ephosSds,10);
pScore
bestRMeanCase
names(indexes(indexes1(bestRMeanCase)));
