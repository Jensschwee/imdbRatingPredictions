function [ tblMovieWithoutOutliers ] = removeOutliers( tblMovie )
%REMOVEOUTLIERS Remove outliers.

zFactor = 3;
%duration
outlier = abs(tblMovie.duration-mean(tblMovie.duration)) > (zFactor * std(tblMovie.duration));
outlieTable = logical(outlier);
%director_facebook_likes
outlier = tblMovie.director_facebook_likes > 1100;
outlieTable = [outlieTable logical(outlier)];
%actor_3_facebook_likes
%outlier = abs(tblMovie.actor_3_facebook_likes-mean(tblMovie.actor_3_facebook_likes)) > (zFactor * std(tblMovie.actor_3_facebook_likes));
%outlieTable = [outlieTable logical(outlier)];
%actor_1_facebook_likes
%outlier = abs(tblMovie.actor_1_facebook_likes-mean(tblMovie.actor_1_facebook_likes)) > (zFactor * std(tblMovie.actor_1_facebook_likes));
%outlieTable = [outlieTable logical(outlier)];
%num_voted_users
%outlier = abs(tblMovie.num_voted_users-mean(tblMovie.num_voted_users)) > (zFactor * std(tblMovie.num_voted_users));
%outlieTable = [outlieTable logical(outlier)];
%cast_total_facebook_likes
outlier = tblMovie.cast_total_facebook_likes > 700000;
outlieTable = [outlieTable logical(outlier)];
%imdb_score
outlier = abs(tblMovie.imdb_score-mean(tblMovie.imdb_score)) > (zFactor * std(tblMovie.imdb_score));
outlieTable = [outlieTable logical(outlier)];
%facenumber_in_poster
%outlier = abs(tblMovie.facenumber_in_poster-mean(tblMovie.facenumber_in_poster)) > (zFactor * std(tblMovie.facenumber_in_poster));
%outlieTable = [outlieTable logical(outlier)];

tblMovieWithoutOutliers = tblMovie(~any(outlieTable,2),:);
end

