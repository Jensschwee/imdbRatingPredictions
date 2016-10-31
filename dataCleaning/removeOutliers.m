function [ tblMovieWithoutOutliers ] = removeOutliers( tblMovie )
%REMOVEOUTLIERS Remove outliers.

zFactor = 3;
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
outlier = abs(tblMovie.budget-mean(tblMovie.budget)) > (zFactor * std(tblMovie.budget));
outlieTable = [outlieTable logical(outlier)];
%gross
outlier = abs(tblMovie.gross-mean(tblMovie.gross)) > (zFactor * std(tblMovie.gross));
outlieTable = [outlieTable logical(outlier)];
%actor_2_facebook_likes
outlier = abs(tblMovie.actor_2_facebook_likes-mean(tblMovie.actor_2_facebook_likes)) > (zFactor * std(tblMovie.actor_2_facebook_likes));
outlieTable = [outlieTable logical(outlier)];
%movie_facebook_likes_
outlier = abs(tblMovie.movie_facebook_likes_-mean(tblMovie.movie_facebook_likes_)) > (zFactor * std(tblMovie.movie_facebook_likes_));
outlieTable = [outlieTable logical(outlier)];
tblMovieWithoutOutliers = tblMovie(~any(outlieTable,2),:);

end

