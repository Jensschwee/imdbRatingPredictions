function plotRSS(RSS,NumberOfReperts,NumberOfIterations, NumberOfParameters )
RSSmean = [];
RSSsd = [];
for i=1:size(NumberOfIterations,2)
    RSSmean(i) = mean2(RSS(:,i));
    RSSsd(i) = std(RSS(:,i));
end;

%PLOT This function plots linear regression
%   Detailed stuff..
    errorbar(NumberOfIterations,RSSmean,RSSsd)
    set(gca,'fontsize',18)
    xlabel('Number Of Iterations')
    ylabel('RSS')
    test = 'Linear Regression of  ';
    test = strcat(test,num2str(NumberOfParameters));
    test = strcat(test,' parameters with ');
    test = strcat(test,num2str(NumberOfReperts));
    test = strcat(test,' reperts');
    title(test)
    print('LinerRegression','-dpng');
end

