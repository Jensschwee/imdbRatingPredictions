clc
clear all
%tblMovie=readtable('movie_metadata.csv','Format','%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');

tblMovie=readtable('movie_metadata.csv','Format','%C%s%f%f%f%f%s%f%f%s%s%s%f%f%s%f%s%s%f%C%C%C%f%C%f%f%C%f');
tblMissing = ismissing(tblMovie);
tblMovie = tblMovie(~any(tblMissing,2),:);

clear tblMissing

%Country cleaning
tblMovie.country(tblMovie.country == 'New Line') = 'USA';
tblMovie.country(tblMovie.country == 'Official site') = 'USA';

% Remove duplicates by checking movie links
[~,ind] = unique(tblMovie(:,18));
tblMovie = tblMovie(ind,:);
clear ind

%content rating in same std.
tblMovie.content_rating(tblMovie.content_rating == 'M') = 'PG-13';
tblMovie.content_rating(tblMovie.content_rating == 'GP') = 'PG';
tblMovie.content_rating(tblMovie.content_rating == 'X') = 'No rating';
tblMovie.content_rating(tblMovie.content_rating == 'Approved') = 'No rating';
tblMovie.content_rating(tblMovie.content_rating == 'Not Rated') = 'No rating';
tblMovie.content_rating(tblMovie.content_rating == 'Unrated') = 'No rating';
tblMovie.content_rating(tblMovie.content_rating == 'Passed') = 'No rating';

% Change genres to categorical data
for i=1:size(tblMovie)
    genres=regexp(tblMovie{i,10},'[|]+','split');
    tblMovie.genres{i} = categorical(genres{1});
end;
clear genres

% Change plot_keywords to categorical data
for i=1:size(tblMovie)
    plot_keywords=regexp(tblMovie{i,17},'[|]+','split');
    tblMovie.plot_keywords{i} = categorical(plot_keywords{1});
end;
clear plot_keywords

% Normalize data - in a seperate table, because why not.
tblMovieNormalized = tblMovie;
tblMovieNormalized.num_critic_for_reviews = mat2gray(tblMovie.num_critic_for_reviews); % Column 3
tblMovieNormalized.duration = mat2gray(tblMovie.duration); % Column 4
tblMovieNormalized.director_facebook_likes = mat2gray(tblMovie.director_facebook_likes); % Column 5
tblMovieNormalized.actor_3_facebook_likes = mat2gray(tblMovie.actor_3_facebook_likes); % Column 6
tblMovieNormalized.actor_1_facebook_likes = mat2gray(tblMovie.actor_1_facebook_likes); % Column 8
tblMovieNormalized.num_voted_users = mat2gray(tblMovie.num_voted_users); % Column 13
tblMovieNormalized.cast_total_facebook_likes = mat2gray(tblMovie.cast_total_facebook_likes); % Column 14
tblMovieNormalized.facenumber_in_poster = mat2gray(tblMovie.facenumber_in_poster); % Column 16
tblMovieNormalized.num_user_for_reviews = mat2gray(tblMovie.num_user_for_reviews); % Column 19
tblMovieNormalized.budget = mat2gray(tblMovie.budget); % Column 23
tblMovieNormalized.actor_2_facebook_likes = mat2gray(tblMovie.actor_2_facebook_likes); % Column 25
tblMovieNormalized.imdb_score = mat2gray(tblMovie.imdb_score); % Column 26
tblMovieNormalized.movie_facebook_likes_ = mat2gray(tblMovie.movie_facebook_likes_); % Column 28
