function [rsquared] = evaluateRegression(tblTest,theta)
        %EVAL This function evaluates results from linear regression
        X = table2array(tblTest(:, 1:size(tblTest,2)-1));
        %X = table2array(tblTest(:, 1));
        y = table2array(tblTest(:, size(tblTest,2)));
        X = [ones(length(y), 1) X];
        estimateRevenue = X * theta; 

        %RSS=sum((y-estimateRevenue).^2);
        %SST=sum(y-mean(y));

        %error = y - estimateRevenue;

        %rsquared = 1-(RSS/SST);
        
        rsquared = 1 - sum((y - estimateRevenue).^2)/sum((y - mean(y)).^2);

end