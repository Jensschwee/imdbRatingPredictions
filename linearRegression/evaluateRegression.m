function [rsquared] = evaluateRegression(tblTest,theta)
        %EVAL This function evaluates results from linear regression
        %   Detailed stuff..
        X = table2array(tblTest(:, 1)); %Color
        X = [X, table2array(tblTest(:, 2))]; %Duration
        X = [X, table2array(tblTest(:, 13))]; %director_facebook_likes
        X = [X, table2array(tblTest(:, 12))]; %cast_total_facebook_likes
        X = [X, table2array(tblTest(:, 14:36))]; %genre
        X = [X, table2array(tblTest(:, 55:93))]; %language
        X = [X, table2array(tblTest(:, 94:155))]; %country
        X = [X, table2array(tblTest(:, 128:133))]; %content_rating
        X = [X, table2array(tblTest(:, 156:243))]; %title_year
        X = [X, table2array(tblTest(:, 244:262))]; %aspect_ratio
        X = [X, table2array(tblTest(:, 37:54))]; %facenumber_in_poster
        y = table2array(tblTest(:, 10));
        X = [ones(length(y), 1) X];
        
        estimateRevenue = X * theta;

        %RSS=sum((y-estimateRevenue).^2);
        %SST=sum(y-mean(y));

        %error = y - estimateRevenue;

        %rsquared = 1-(RSS/SST);
        
        R = (cov(estimateRevenue,y) / [(var(y)).^0.5 (var(y)).^0.5]);
        rsquared = R(2).^2;
        
        %rsquared = 1 - sum((y - estimateRevenue).^2)/sum((y - mean(y)).^2);
end