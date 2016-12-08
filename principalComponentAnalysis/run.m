clc
clear all
close all

showFigures = 1;
cvTacket = 95;

tblMovieCleaned=readtable('../movie_metadata_cleaned.csv');

%Fild data set
X = table2array(tblMovieCleaned(:, 1)); %Color
X = [X, table2array(tblMovieCleaned(:, 2))]; %Duration
X = [X, table2array(tblMovieCleaned(:, 13))]; %director_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 12))]; %cast_total_facebook_likes
X = [X, table2array(tblMovieCleaned(:, 14:36))]; %genre
X = [X, table2array(tblMovieCleaned(:, 55:93))]; %language
X = [X, table2array(tblMovieCleaned(:, 94:155))]; %country
X = [X, table2array(tblMovieCleaned(:, 128:133))]; %content_rating
X = [X, table2array(tblMovieCleaned(:, 156:243))]; %title_year
X = [X, table2array(tblMovieCleaned(:, 244:262))]; %aspect_ratio
X = [X, table2array(tblMovieCleaned(:, 37:54))]; %facenumber_in_poster

t1 = tic;%initilise counter

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
    title(strcat({'PCA with a Cumulative variance of '},num2str(cvTacket), {' %'}) )
    t = text(nc+1,nc,strcat(num2str(nc), {' PCs'}));
    t.FontSize = 20;
    set(gca, 'Ylim', [0 100])
    hold off
end;

ev=C(:,1:nc);
y=X*ev; %transform to PCA space
y = [y, table2array(tblMovieCleaned(:, 10))]; %IMDB score

toc(t1)%compute elapsed time

%Export
tbl = array2table(y);
writetable(tbl, '../movie_metadata_cleaned_pca.csv');
