function [ tblMovieCountriesStandardized ] = standardizeCountries( tblMovie )
%CLEANCOUNTRIES Change variables that are not countries.

tblMovieCountriesStandardized = tblMovie;

tblMovieCountriesStandardized.country(tblMovie.country == 'New Line') = 'USA';
tblMovieCountriesStandardized.country(tblMovie.country == 'Official site') = 'USA';

end

