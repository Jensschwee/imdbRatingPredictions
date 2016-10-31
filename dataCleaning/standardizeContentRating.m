function [ tblMovieContentRatingStandardized ] = standardizeContentRating( tblMovie )
%STANDARDIZECONTENTRATING Standardize movie content rating to MPAA content
%ratings (US standard)

tblMovieContentRatingStandardized = tblMovie;

tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'M') = 'PG-13';
tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'GP') = 'PG';
tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'X') = 'No rating';
tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'Approved') = 'No rating';
tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'Not Rated') = 'No rating';
tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'Unrated') = 'No rating';
tblMovieContentRatingStandardized.content_rating(tblMovie.content_rating == 'Passed') = 'No rating';

end

