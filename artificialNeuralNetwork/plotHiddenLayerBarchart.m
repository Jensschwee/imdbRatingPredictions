figure
hold on
bar(hiddenLayerName,hiddenLayerTestMean)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(hiddenLayerName,hiddenLayerTestMean,hiddenLayerTestSD,'.','color',[1 0 0])
xlabel('Number of neurons')
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,'fontsize',18)

figure
hold on
bar(hiddenLayerName,hiddenLayerEpochMean)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(hiddenLayerName,hiddenLayerEpochMean,hiddenLayerEpochSD,'.','color',[1 0 0])
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