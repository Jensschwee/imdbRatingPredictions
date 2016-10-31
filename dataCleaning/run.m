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
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 21);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 22);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 24);
tblMovieCleaned = normalizeCategoricalDataFromColumn(tblMovieCleaned, 27);
tblMovieCleaned = removeIncorrectCurrencies(tblMovieCleaned, '../foreign_movie_links.csv');
tblMovieCleaned = removeUnusedCategories(tblMovieCleaned);
tblMovieCleaned = addRevenue(tblMovieCleaned);
tblMovieCleaned = removeOutliers(tblMovieCleaned);
tblMovieCleaned = normalizeNumericalData(tblMovieCleaned);

tblMovieCleaned.color = grp2idx(tblMovieCleaned.color);
tblMovieCleaned.color = tblMovieCleaned.color - 1;

% Write cleaned table
writetable(tblMovieCleaned, '../movie_metadata_cleaned.csv');