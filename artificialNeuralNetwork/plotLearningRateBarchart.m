figure
hold on
bar(learningRateName,learningRateTestMean)
errorbar(learningRateName,learningRateTestMean,learningRateTestSD,'color',[1 0 0])
xlabel('Alpha')
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,'fontsize',18)

figure
hold on
bar(learningRateName,learningRateEpochMean)
errorbar(learningRateName,learningRateEpochMean,learningRateEpochSD,'color',[1 0 0])
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