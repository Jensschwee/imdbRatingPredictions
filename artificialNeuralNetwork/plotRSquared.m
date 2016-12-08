function plotRSS(rsquaredTest,rsquaredTrain,rsquaredValidation)
rsquaredTestMean = [];
rsquaredTestSd = [];
rsquaredTrainMean = [];
rsquaredTrainSd = [];
rsquaredValidationMean = [];
rsquaredValidationSd = [];
for i=1:size(NumberOfIterations,2)
    rsquaredTestMean(i) = mean2(rsquaredTest(:,i));
    rsquaredTestSd(i) = std(rsquaredTest(:,i));
    rsquaredTrainMean(i) = mean2(rsquaredTrain(:,i));
    rsquaredTrainSd(i) = std(rsquaredTrain(:,i));
    rsquaredValidationMean(i) = mean2(rsquaredValidation(:,i));
    rsquaredValidationSd(i) = std(rsquaredValidation(:,i));
end;
medianOfVaules(1:size(tbl)) = median(tbl);
rSquredMedian(1:size(NumberOfIterations,2)) = rSquareValue(medianOfVaules,tbl);
rSquredSD(1:size(NumberOfIterations,2)) = std(medianOfVaules,tbl);

%PLOT This function plots linear regression
%   Detailed stuff..
    hold on
    errorbar(NumberOfIterations,rsquaredTestMean,rsquaredTestSd,'color', [0 0 1])
    errorbar(NumberOfIterations,rsquaredTranMean,rsquaredTranSd,'color', [1 0 0])
    errorbar(NumberOfIterations,rsquaredValidationMean,rsquaredValidationSd,'color', [0 1 0])
    errorbar(NumberOfIterations,rSquredMedian,rSquredSD,'color', [0.6 0.6 0.6])
    set(gca,'fontsize',18)
    xlabel('Number Of Epochs')
    ylabel('r squared')
    legend('Test','Training','Validation','Median','Location','northwest')
    set(gca, 'Xlim', [-1 max(NumberOfIterations)])
    hold off
    print('ANNRSquared','-dpng');
end
