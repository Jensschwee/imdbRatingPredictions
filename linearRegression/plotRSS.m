function plotRSS(rsquared,NumberOfReperts,NumberOfIterations, NumberOfParameters )
rsquaredMean = [];
rsquaredSd = [];
for i=1:size(NumberOfIterations,2)
    rsquaredMean(i) = mean2(rsquared(:,i));
    rsquaredSd(i) = std(rsquared(:,i));
end;

%PLOT This function plots linear regression
%   Detailed stuff..
    errorbar(NumberOfIterations,rsquaredMean,rsquaredSd)
    set(gca,'fontsize',18)
    xlabel('Number Of Epochs')
    ylabel('r squared')
    test = 'Linear Regression of  ';
    test = strcat({test},num2str(NumberOfParameters));
    test = strcat(test,{' parameters with '});
    test = strcat(test,num2str(NumberOfReperts));
    test = strcat(test,{' reperts'});
    title(test)
    print('LinerRegression','-dpng');
end

