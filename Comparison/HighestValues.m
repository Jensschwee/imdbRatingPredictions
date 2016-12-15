%comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[5-60 5-60].mat',...
%   '../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[60-120 5-60].mat',...
%    '../artificialNeuralNetwork/ANNHiddenLayer/tuneANNDualHiddenLayer-[100 5-110].mat'...
%    };

%comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNSingleHiddenLayer-[5-200].mat'};

comparisonList = {'../artificialNeuralNetwork/ANNHiddenLayer/tuneANNTripleHiddenLayer-[100 5-60 5-60].mat'};

names = [];
means = [];
sds = [];
ephos = [];
ephosSds = [];

for listIndex = 1:length(comparisonList)
    load(comparisonList{listIndex});
    
    cleanedNames = []; 
    for strIndex = 1:length(hiddenLayerName)
        if(isnumeric(hiddenLayerName(strIndex)))
            cleanedNames = [cleanedNames {strcat('',num2str(hiddenLayerName(strIndex)))}];
        else
            cleanedNames = [cleanedNames hiddenLayerName(strIndex)];
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
pScore(bestRMeanCase)
names(indexes(bestRMeanCase))
means(indexes(bestRMeanCase))


[b, indexes1] = sort(ephos(indexes(bestRMeanCase)), 'ascend');
[pScore2, bestEpochMeanCase] = tTestEphos(indexes(indexes1), ephos, ephosSds,10);
pScore2
names(indexes(indexes1))
ephos(indexes(indexes1))




