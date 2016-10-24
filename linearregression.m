% Split data into training and test data
trainingSetSize = 0.85; %Size of the traning set in %
tblIndex = randperm(length(tblMovieNoOutliers.movie_imdb_link));
testSize = length(tblMovieNoOutliers.movie_imdb_link)*(1-trainingSetSize);
trainingSize = length(tblMovieNoOutliers.movie_imdb_link)*trainingSetSize;

%Spilt data ind i tables
tblTest = tblMovieNoOutliers(tblIndex(1:testSize),:);
tblTraining = tblMovieNoOutliers(tblIndex(testSize+1:testSize+trainingSize),:);

clear tblIndex
clear testSize
clear trainingSize
clear trainingSetSize

modelspec = 'revenue ~ ';
modelspec = strcat(modelspec,'duration + director_facebook_likes + actor_3_facebook_likes + actor_2_facebook_likes+actor_1_facebook_likes+cast_total_facebook_likes+facenumber_in_poster');

genres1 = '';
for i=1:size(tblMovie);
    genres=regexp(tblMovie{i,10},'[|]+','split');
    genres1 = [genres1, categorical(genres{1})];
end;
genres1 = unique(genres1);

%modelspec = '+ director_facebook_likes + actor_3_facebook_likes + actor_2_facebook_likes+actor_1_facebook_likes+cast_total_facebook_likes+facenumber_in_poster';
%modelspec = strcat(modelspec, '+movie_title+director_name+actor_3_name+actor_2_name+actor_1_name');
%modelspec = strcat(modelspec, '+budget');
%modelspec = strcat(modelspec, '+language+country+content_rating+title_year');
for i=1:length(genres1);
    modelspec = strcat(modelspec, strcat('+genre_',strrep(char(genres1(i)),'-','')));
end;
mdl = fitlm(tblTraining,modelspec);
