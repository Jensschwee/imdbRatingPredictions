figure
hold on
%bar(hiddenLayerName,hiddenLayerTestMean)
errorbar(hiddenLayerName,hiddenLayerTestMean,hiddenLayerTestSD,'.')
xlabel('Number of neurons')
ylabel('Epochs')
set(gca, 'Ylim', [0 350])
set(gca,'fontsize',18)

%% Things that can be plotted
%hiddenLayerName
%hiddenLayerTestMean
%hiddenLayerTestSD
%hiddenLayerEpochMean
%hiddenLayerEpochSD
%hiddenLayerFinalMSEMean
%hiddenLayerFinalMSESD