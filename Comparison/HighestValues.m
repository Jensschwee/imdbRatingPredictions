comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[5-60 5-60].mat',...
    '../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[60-120 5-60].mat'...
    };

names = [];
means = [];
sds = [];

for listIndex = 1:length(comparisonList)
    load(comparisonList{listIndex});
    names = [names hiddenLayerName];
    means = [means hiddenLayerTestMean];
    sds = [sds hiddenLayerTestSD];
end

[b, indexes] = sort(means, 'descend');

layerCombinations = names(ix);





