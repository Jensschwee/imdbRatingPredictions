function [rsquared] = evaluateRegression(tblTest,theta)
        %EVAL This function evaluates results from linear regression
        %   Detailed stuff..
        X = table2array(tblTest(:, 1)); %Color
        X = [X, table2array(tblTest(:, 4))]; %Duration
        %X = [X, table2array(tblTest(:, 5))]; %director_facebook_likes
        %X = [X,table2array(tblTest(:, 6))]; %actor_3_facebook_likes
        %X = [X,table2array(tblTest(:, 8))]; %actor_1_facebook_likes
        X = [X,table2array(tblTest(:, 14))]; %cast_total_facebook_likes
        %X = [X, table2array(tblTest(:, 226:244))]; %facenumber_in_poster
        %X = [X, table2array(tblTest(:, 25))]; %actor_2_facebook_likes
        X = [X, table2array(tblTest(:, 29:50))]; %genre
        X = [X, table2array(tblTest(:, 51:84))]; %language
        X = [X, table2array(tblTest(:, 85:127))]; %country
        %X = [X, table2array(tblTest(:, 128:133))]; %content_rating
        X = [X, table2array(tblTest(:, 134:207))]; %title_year
        %X = [X, table2array(tblTest(:, 208:225))]; %aspect_ratio
        y = table2array(tblTest(:, 245));
        X = [ones(length(y), 1) X];
        estimateRevenue = X * theta; 

        %RSS=sum((y-estimateRevenue).^2);
        %SST=sum(y-mean(y));

        %error = y - estimateRevenue;

        %rsquared = 1-(RSS/SST);
        
        rsquared = 1 - sum((y - estimateRevenue).^2)/sum((y - mean(y)).^2);
end