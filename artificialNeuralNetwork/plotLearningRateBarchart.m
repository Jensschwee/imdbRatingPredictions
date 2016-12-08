figure
hold on
%bar(learningRateName,AlphaTuning(:,2))
errorbar(learningRateName,learningRateTestMean,learningRateTestSD,'.')
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