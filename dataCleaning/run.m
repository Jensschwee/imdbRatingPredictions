clc; clear all;

% Read uncleaned data.
tblMovie=readtable('../movie_metadata.csv','Format','%C%s%f%f%f%f%s%f%f%s%s%s%f%f%s%C%s%s%f%C%C%C%f%C%f%f%C%f');

% Clean data.
tblMovieCleaned = table(tblMovie.color,tblMovie.duration, tblMovie.genres, tblMovie.facenumber_in_poster, tblMovie.movie_imdb_link, tblMovie.language, tblMovie.country ,tblMovie.content_rating ,tblMovie.title_year, tblMovie.imdb_score, tblMovie.aspect_ratio, tblMovie.cast_total_facebook_likes, tblMovie.director_facebook_likes);
tblMovieCleaned.Properties.VariableNames{'Var1'} = 'color';
tblMovieCleaned.Properties.VariableNames{'Var2'} = 'duration';
tblMovieCleaned.Properties.VariableNames{'Var3'} = 'genres';
tblMovieCleaned.Properties.VariableNames{'Var4'} = 'facenumber_in_poster';
tblMovieCleaned.Properties.VariableNames{'Var5'} = 'movie_imdb_link';
tblMovieCleaned.Properties.VariableNames{'Var6'} = 'language';
tblMovieCleaned.Properties.VariableNames{'Var7'} = 'country';
tblMovieCleaned.Properties.VariableNames{'Var8'} = 'content_rating';
tblMovieCleaned.Properties.VariableNames{'Var9'} = 'title_year';
tblMovieCleaned.Properties.VariableNames{'Var10'} = 'imdb_score';
tblMovieCleaned.Properties.VariableNames{'Var11'} = 'aspect_ratio';
tblMovieCleaned.Properties.VariableNames{'Var12'} = 'cast_total_facebook_likes';
tblMovieCleaned.Properties.VariableNames{'Var13'} = 'director_facebook_likes';

tblMovieCleaned = removeMissing(tblMovieCleaned);
tblMovieCleaned = removeDuplicates(tblMovieCleaned);
tblMovieCleaned = standardizeCountries(tblMovieCleaned);
tblMovieCleaned = standardizeContentRating(tblMovieCleaned);
tblMovieCleaned = normalizeCategoricalDataFromColumnWithRegex(tblMovieCleaned, 3);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 4);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 6);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 7);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 8);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 9);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 11);
%tblMovieCleaned = removeIncorrectCurrencies(tblMovieCleaned, '../foreign_movie_links.csv');
tblMovieCleaned = removeUnusedCategories(tblMovieCleaned);
%tblMovieCleaned = addRevenue(tblMovieCleaned);
tblMovieCleaned = removeOutliers(tblMovieCleaned);
tblMovieCleaned = normalizeNumericalData(tblMovieCleaned);

tblMovieCleaned.color = grp2idx(tblMovieCleaned.color);
tblMovieCleaned.color = tblMovieCleaned.color - 1;

% Write cleaned table
writetable(tblMovieCleaned, '../movie_metadata_cleaned.csv');