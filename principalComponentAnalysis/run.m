clc
clear all
close all

showFigures = 1;
cvTacket = 90;

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

%Fild data set
X = table2array(tblMovieCleaned(:, 1)); %Color
X = [X, table2array(tblMovieCleaned(:, 4))]; %Duration
X = [X, table2array(tblMovieCleaned(:, 5))]; %director_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 6))]; %actor_3_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 8))]; %actor_1_facebook_likes
X = [X,table2array(tblMovieCleaned(:, 14))]; %cast_total_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 226:244))]; %facenumber_in_poster
X = [X, table2array(tblMovieCleaned(:, 25))]; %actor_2_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 29:50))]; %genre
X = [X, table2array(tblMovieCleaned(:, 51:84))]; %language
X = [X, table2array(tblMovieCleaned(:, 85:127))]; %country
X = [X, table2array(tblMovieCleaned(:, 128:133))]; %content_rating
X = [X, table2array(tblMovieCleaned(:, 134:207))]; %title_year
X = [X, table2array(tblMovieCleaned(:, 208:225))]; %aspect_ratio
X = [X, table2array(tblMovieCleaned(:, 226:244))]; %facenumber_in_poster

C=cov(X);
[V,L]=eig(C);
L=diag(L);
[Y,I]=sort(L,'descend');
cv=cumsum(100*Y/sum(Y));
for nc=1: size(Y,1)
    cvCurrent=cumsum(100*Y(1:nc)/sum(Y));
    if max(cvCurrent) >= cvTacket
        break
    end;
end;

if showFigures == 1
    figure
    hold on
    plot(cv,'linewidth',2)
    line([nc nc],[0 max(cvCurrent)], 'Color', [1 0 0 ])
    set(gca,'fontsize',20)
    xlabel('Number of PCs')
    ylabel('Cumulative variance (%)')
    title(strcat({'PCA with a Cumulative variance of '},num2str(cvTacket), {' % needs '}, num2str(nc), ' featers') )
    hold off
end;

ev=C(:,1:nc);
y=X*ev;%transform to PCA space
y = [y, table2array(tblMovieCleaned(:, 245))];

%Export
tbl = array2table(y);
writetable(tbl, '../movie_metadata_cleaned_pca.csv');
