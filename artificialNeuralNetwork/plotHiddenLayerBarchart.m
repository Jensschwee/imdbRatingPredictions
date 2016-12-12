SEM = hiddenLayerTestSD/sqrt(20);               % Standard Error
ts = tinv([0.025  0.975],19);      % T-Score
for i=1:length(hiddenLayerTestSD);
    CITest(i)= (ts(1) .* SEM(i));                      % Confidence Intervals
end
SEM = hiddenLayerEpochSD/sqrt(20);               % Standard Error
ts = tinv([0.025  0.975],19);      % T-Score
for i=1:length(hiddenLayerEpochSD);
    CIEpoch(i)= (ts(1) .* SEM(i));                      % Confidence Intervals
end

figure
hold on
bar(hiddenLayerName,hiddenLayerTestMean)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(hiddenLayerName,hiddenLayerTestMean,CITest,'.','color',[1 0 0])
xlabel('Number of neurons')
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,'fontsize',18)

figure
hold on
bar(hiddenLayerName,hiddenLayerEpochMean)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(hiddenLayerName,hiddenLayerEpochMean,CIEpoch,'.','color',[1 0 0])
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