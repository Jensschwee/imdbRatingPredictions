function [rsquared] = evaluateRegression(tblTest,theta)
        %EVAL This function evaluates results from linear regression
        X = table2array(tblTest(:, 1:size(tblTest,2)-2));
        %X = table2array(tblTest(:, 1));
        y = table2array(tblTest(:, size(tblTest,2)));
        X = [ones(length(y), 1) X];
        estimateRevenue = X * theta; 

        %RSS=sum((y-estimateRevenue).^2);
        %REG=sum((y-mean(y)).^2);

        %error = y - estimateRevenue;

        %rsquared = 1-(RSS/REG);
        
        R = (cov(estimateRevenue,y) / [(var(y)).^0.5 (var(y)).^0.5]);
        rsquared = R(2).^2;
    
        %rsquared = 1 - sum((y - estimateRevenue).^2)/sum((y - mean(y)).^2);

end