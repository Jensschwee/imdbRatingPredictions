function plotMSE(mseTest,mseTran,NumberOfReperts,NumberOfIterations, NumberOfParameters)
rsquaredTestMean = [];
rsquaredTestSd = [];
rsquaredTranMean = [];
rsquaredTranSd = [];
for i=1:size(NumberOfIterations,2)
    rsquaredTestMean(i) = mean2(mseTest(:,i));
    rsquaredTestSd(i) = std(mseTest(:,i));
    rsquaredTranMean(i) = mean2(mseTran(:,i));
    rsquaredTranSd(i) = std(mseTran(:,i));
end;

%PLOT This function plots linear regression
%   Detailed stuff..
    hold on
    errorbar(NumberOfIterations,rsquaredTestMean,rsquaredTestSd,'color', [0 0 1])
    errorbar(NumberOfIterations,rsquaredTranMean,rsquaredTranSd,'color', [1 0 0])
    set(gca,'fontsize',18)
    xlabel('Number Of Epochs')
    ylabel('MSE')
    test = 'Linear Regression of  ';
    test = strcat({test},num2str(NumberOfParameters));
    test = strcat(test,{' parameters with '});
    test = strcat(test,num2str(NumberOfReperts));
    test = strcat(test,{' repeats'});
    title(test)
    legend('Test','Training','Location','northwest')
    %legend('Test','Location','northwest')
    set(gca, 'Xlim', [-1 max(NumberOfIterations)])
    hold off
    print('LinerRegressionMSE','-dpng');
end
