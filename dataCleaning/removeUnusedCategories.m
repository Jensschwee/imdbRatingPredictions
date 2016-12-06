function [ tblMovieUnusedCategoriesRemoved ] = removeUnusedCategories( tblMovie )
%REMOVEUNUSEDCATEGORIES Remove unused categories.

tblMovieUnusedCategoriesRemoved = tblMovie;

tblMovieUnusedCategoriesRemoved.color = removecats(tblMovie.color);
tblMovieUnusedCategoriesRemoved.aspect_ratio = removecats(tblMovie.aspect_ratio);
tblMovieUnusedCategoriesRemoved.language = removecats(tblMovie.language);
tblMovieUnusedCategoriesRemoved.country = removecats(tblMovie.country);
tblMovieUnusedCategoriesRemoved.content_rating = removecats(tblMovie.content_rating);
tblMovieUnusedCategoriesRemoved.title_year = removecats(tblMovie.title_year);

end

