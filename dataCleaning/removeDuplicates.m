function [ tblMovieDuplicatesRemoved ] = removeDuplicates( tblMovie )
%REMOVEDUPLICATES Remove duplicates based on imdb_link

[~,ind] = unique(tblMovie.movie_imdb_link);
tblMovieDuplicatesRemoved = tblMovie(ind,:);

end

