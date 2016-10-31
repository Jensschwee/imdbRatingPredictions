function [ tblMovieWithoutIncorrectCurrencies ] = removeIncorrectCurrencies( tblMovie, toRemoveCsv )
%REMOVEINCORRECTCURRENCIES Remove incurrect currencies based on a csv.
%   Detailed explanation goes here

tblMovieToRemove=readtable(toRemoveCsv, 'Delimiter', ',');
for i=1:length(tblMovieToRemove.link)
    tblMovie = tblMovie(cellfun(@isempty,strfind(tblMovie.movie_imdb_link,tblMovieToRemove.link(i))),:);
end;

tblMovieWithoutIncorrectCurrencies = tblMovie;

end

