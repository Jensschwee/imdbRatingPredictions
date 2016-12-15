comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[5-60 5-60].mat',...
    '../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[60-120 5-60].mat',...
    '../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[100 5-110].mat'...
    };

%comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNSingleHiddenLayer-[5-200].mat'};

%comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNTripleHiddenLayer-[100 5-60 5-60].mat'};

names = [];
means = [];
sds = [];

for listIndex = 1:length(comparisonList)
    load(comparisonList{listIndex});
    
    cleanedNames = []; 
    for strIndex = 1:length(hiddenLayerName)
        if(isnumeric(hiddenLayerName(strIndex)))
            cleanedNames = [cleanedNames {strcat('100--',num2str(hiddenLayerName(strIndex)))}];
        else
            cleanedNames = [cleanedNames hiddenLayerName(strIndex)];
        end
    end
    
    names = [names cleanedNames];
    means = [means hiddenLayerTestMean];
    sds = [sds hiddenLayerTestSD];
end

[b, indexes] = sort(means, 'descend');

orderedMeans = names(indexes)




