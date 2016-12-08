function plotRSS(rsquaredTest,rsquaredTran,NumberOfReperts,NumberOfIterations, NumberOfParameters, tbl )
rsquaredTestMean = [];
rsquaredTestSd = [];
rsquaredTranMean = [];
rsquaredTranSd = [];
for i=1:size(NumberOfIterations,2)
    rsquaredTestMean(i) = mean2(rsquaredTest(:,i));
    rsquaredTestSd(i) = std(rsquaredTest(:,i));
    rsquaredTranMean(i) = mean2(rsquaredTran(:,i));
    rsquaredTranSd(i) = std(rsquaredTran(:,i));
end;
medianOfVaules(1:size(tbl)) = median(tbl);
rSquredMedian(1:size(NumberOfIterations,2)) = rSquareValue(medianOfVaules,tbl);
rSquredSD(1:size(NumberOfIterations,2)) = std(medianOfVaules,tbl);

%PLOT This function plots linear regression
%   Detailed stuff..
    hold on
    errorbar(NumberOfIterations,rsquaredTestMean,rsquaredTestSd,'color', [0 1 0])
    errorbar(NumberOfIterations,rsquaredTranMean,rsquaredTranSd,'color', [1 0 0])
    errorbar(NumberOfIterations,rSquredMedian,rSquredSD,'color', [0.6 0.6 0.6])
    set(gca,'fontsize',18)
    xlabel('Number Of Epochs')
    ylabel('r squared')
    test = 'Linear Regression of  ';
    test = strcat({test},num2str(NumberOfParameters));
    test = strcat(test,{' parameters with '});
    test = strcat(test,num2str(NumberOfReperts));
    test = strcat(test,{' repeats'});
    title(test)
    legend('Test','Training','Median','Location','northwest')
    set(gca, 'Xlim', [-1 max(NumberOfIterations)])
    hold off
    print('LinerRegression','-dpng');
end
