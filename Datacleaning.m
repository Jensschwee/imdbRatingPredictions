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

% Remove duplicates by checking movie hlinks
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
%genres = '';
%genres = [genres, tblMovie.genres{:}];

% Change plot_keywords to categorical data
for i=1:size(tblMovie)
    plot_keywords=regexp(tblMovie{i,17},'[|]+','split');
    tblMovie.plot_keywords{i} = categorical(plot_keywords{1});
end;

clear plot_keywords
%plot_keywords = '';
%plot_keywords = [plot_keywords, tblMovie.plot_keywords{:}];
clear i

%Remove Outlines
zFactor = 2.5;
%num_critic_for_reviews
outlier = abs(tblMovie.num_critic_for_reviews-mean(tblMovie.num_critic_for_reviews)) > (zFactor * std(tblMovie.num_critic_for_reviews));
outlieTable = logical(outlier); 
%duration
outlier = abs(tblMovie.duration-mean(tblMovie.duration)) > (zFactor * std(tblMovie.duration));
outlieTable = [outlieTable logical(outlier)];
%director_facebook_likes
outlier = abs(tblMovie.director_facebook_likes-mean(tblMovie.director_facebook_likes)) > (zFactor * std(tblMovie.director_facebook_likes));
outlieTable = [outlieTable logical(outlier)];
%actor_3_facebook_likes
outlier = abs(tblMovie.actor_3_facebook_likes-mean(tblMovie.actor_3_facebook_likes)) > (zFactor * std(tblMovie.actor_3_facebook_likes));
outlieTable = [outlieTable logical(outlier)];
%actor_1_facebook_likes
outlier = abs(tblMovie.actor_1_facebook_likes-mean(tblMovie.actor_1_facebook_likes)) > (zFactor * std(tblMovie.actor_1_facebook_likes));
outlieTable = [outlieTable logical(outlier)];
%num_voted_users
outlier = abs(tblMovie.num_voted_users-mean(tblMovie.num_voted_users)) > (zFactor * std(tblMovie.num_voted_users));
outlieTable = [outlieTable logical(outlier)];
%cast_total_facebook_likes
outlier = abs(tblMovie.cast_total_facebook_likes-mean(tblMovie.cast_total_facebook_likes)) > (zFactor * std(tblMovie.cast_total_facebook_likes));
outlieTable = [outlieTable logical(outlier)];
%facenumber_in_poster
outlier = abs(tblMovie.facenumber_in_poster-mean(tblMovie.facenumber_in_poster)) > (zFactor * std(tblMovie.facenumber_in_poster));
outlieTable = [outlieTable logical(outlier)];
%num_user_for_reviews
outlier = abs(tblMovie.num_user_for_reviews-mean(tblMovie.num_user_for_reviews)) > (zFactor * std(tblMovie.num_user_for_reviews));
outlieTable = [outlieTable logical(outlier)];
%budget
%outlier = abs(tblMovie.budget-mean(tblMovie.budget)) > (zFactor * std(tblMovie.budget));
%outlieTable = [outlieTable logical(outlier)];
%gross
%outlier = abs(tblMovie.gross-mean(tblMovie.gross)) > (zFactor * std(tblMovie.gross));
%outlieTable = [outlieTable logical(outlier)];
%actor_2_facebook_likes
outlier = abs(tblMovie.actor_2_facebook_likes-mean(tblMovie.actor_2_facebook_likes)) > (zFactor * std(tblMovie.actor_2_facebook_likes));
outlieTable = [outlieTable logical(outlier)];
%movie_facebook_likes_
outlier = abs(tblMovie.movie_facebook_likes_-mean(tblMovie.movie_facebook_likes_)) > (zFactor * std(tblMovie.movie_facebook_likes_));
outlieTable = [outlieTable logical(outlier)];
tblMovieNoOutliers = tblMovie(~any(outlieTable,2),:);

clear outlieTable
clear outlier
clear zFactor;

%Remove catagories that is 0 of
tblMovie.color = removecats(tblMovie.color);
tblMovie.aspect_ratio = removecats(tblMovie.aspect_ratio);
tblMovie.language = removecats(tblMovie.language);
tblMovie.content_rating = removecats(tblMovie.content_rating);
tblMovie.title_year = removecats(tblMovie.title_year);


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
