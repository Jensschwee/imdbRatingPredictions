function [ tblMovieDuplicatesRemoved ] = removeDuplicates( tblMovie )
%REMOVEDUPLICATES Remove duplicates based on imdb_link

[~,ind] = unique(tblMovie(:,18));
tblMovieDuplicatesRemoved = tblMovie(ind,:);

end

