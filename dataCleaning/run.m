clc; clear all;

% Read uncleaned data.
tblMovie=readtable('../movie_metadata.csv','Format','%C%s%f%f%f%f%s%f%f%s%s%s%f%f%s%f%s%s%f%C%C%C%f%C%f%f%C%f');

% Clean data.
tblMovieCleaned = removeMissing(tblMovie);
tblMovieCleaned = removeDuplicates(tblMovieCleaned);
tblMovieCleaned = standardizeCountries(tblMovieCleaned);
tblMovieCleaned = standardizeContentRating(tblMovieCleaned);
tblMovieCleaned = normalizeCategoricalDataFromColumnWithRegex(tblMovieCleaned, 10);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 20);
tblMovieCleaned = removeIncorrectCurrencies(tblMovieCleaned, '../foreign_movie_links.csv');
tblMovieCleaned = removeUnusedCategories(tblMovieCleaned);
tblMovieCleaned = addRevenue(tblMovieCleaned);
tblMovieCleaned = removeOutliers(tblMovieCleaned);
tblMovieCleaned = normalizeNumericalData(tblMovieCleaned);

tblMovieCleaned.color(tblMovieCleaned.color == 'Black and White') = '0';
tblMovieCleaned.color(tblMovieCleaned.color == 'Color') = '1';



% Write cleaned table
%writetable(tblMovieCleaned, '../movie_metadata_cleaned.csv');