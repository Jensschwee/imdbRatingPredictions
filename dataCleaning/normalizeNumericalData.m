function [ tblMovieNumericalDataNormalized ] = normalizeNumericalData( tblMovie )
%NORMALIZENUMERICALDATA Normalize numerical data.

tblMovieNumericalDataNormalized = tblMovie;

tblMovieNumericalDataNormalized.num_critic_for_reviews = mat2gray(tblMovie.num_critic_for_reviews); % Column 3
tblMovieNumericalDataNormalized.duration = mat2gray(tblMovie.duration); % Column 4
tblMovieNumericalDataNormalized.director_facebook_likes = mat2gray(tblMovie.director_facebook_likes); % Column 5
tblMovieNumericalDataNormalized.actor_3_facebook_likes = mat2gray(tblMovie.actor_3_facebook_likes); % Column 6
tblMovieNumericalDataNormalized.actor_1_facebook_likes = mat2gray(tblMovie.actor_1_facebook_likes); % Column 8
tblMovieNumericalDataNormalized.num_voted_users = mat2gray(tblMovie.num_voted_users); % Column 13
tblMovieNumericalDataNormalized.cast_total_facebook_likes = mat2gray(tblMovie.cast_total_facebook_likes); % Column 14
%tblMovieNumericalDataNormalized.facenumber_in_poster = mat2gray(tblMovie.facenumber_in_poster); % Column 16
tblMovieNumericalDataNormalized.num_user_for_reviews = mat2gray(tblMovie.num_user_for_reviews); % Column 19
%tblMovieNumericalDataNormalized.budget = mat2gray(tblMovie.budget); % Column 23
tblMovieNumericalDataNormalized.actor_2_facebook_likes = mat2gray(tblMovie.actor_2_facebook_likes); % Column 25
%tblMovieNumericalDataNormalized.imdb_score = mat2gray(tblMovie.imdb_score); % Column 26
tblMovieNumericalDataNormalized.movie_facebook_likes_ = mat2gray(tblMovie.movie_facebook_likes_); % Column 28
%tblMovieNumericalDataNormalized.gross = mat2gray(tblMovie.gross); % Column 28
%tblMovieNumericalDataNormalized.revenue = mat2gray(tblMovie.revenue); % Column 30

end

