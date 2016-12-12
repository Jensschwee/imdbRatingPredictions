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
bar(learningRateName,learningRateTestMean)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(learningRateName,learningRateTestMean,CITest,'color',[1 0 0])
xlabel('Alpha')
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,'fontsize',18)

figure
hold on
bar(learningRateName,learningRateEpochMean)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(learningRateName,learningRateEpochMean,CIEpoch,'color',[1 0 0])
xlabel('Alpha')
ylabel('Epochs')
set(gca, 'Ylim', [0 350])
set(gca,'fontsize',18)

%% Things that can be plotted
%learningRateName
%learningRateTestMean
%learningRateTestSD
%learningRateEpochMean
%learningRateEpochSD
%learningRateFinalMSEMean
%learningRateFinalMSESD