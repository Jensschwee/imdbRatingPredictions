function plotMSE(mseTest,mseTrain,mseValidation)
mseTestMean = [];
mseTestSd = [];
mseTranMean = [];
mseTranSd = [];
mseValidationMean = [];
mseValidationSd = [];
for i=1:size(NumberOfIterations,2)
    mseTestMean(i) = mean2(mseTest(:,i));
    mseTestSd(i) = std(mseTest(:,i));
    mseTranMean(i) = mean2(mseTrain(:,i));
    mseTranSd(i) = std(mseTrain(:,i));
    mseValidationMean(i) = mean2(mseValidation(:,i));
    mseValidationSd(i) = std(mseValidation(:,i));
end;

%PLOT This function plots linear regression
%   Detailed stuff..
    hold on
    errorbar(NumberOfIterations,mseTestMean,mseTestSd,'color', [0 0 1])
    errorbar(NumberOfIterations,mseValidationMean,mseValidationSd,'color', [0 1 0])
    errorbar(NumberOfIterations,mseTrainMean,mseTrainSd,'color', [1 0 0])
    set(gca,'fontsize',18)
    xlabel('Number Of Epochs')
    ylabel('MSE')
    legend('Test','Validation','Training','Location','northwest')
    %legend('Test','Location','northwest')
    set(gca, 'Xlim', [-1 max(NumberOfIterations)])
    hold off
    print('ANNMSE','-dpng');
end
