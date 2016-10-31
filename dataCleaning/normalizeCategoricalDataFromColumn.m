function [ tblMovieCategoricalColumnNormalized ] = normalizeCategoricalDataFromColumn( tblMovie, columnId )
%SPLITCATEGORICAL Normalize categorical column of the specified columnId

tblMovieCategoricalColumnNormalized = tblMovie;

allCategories = unique(tblMovie(:,columnId));

%Create genre table for temp generes
categoryCells = [];
for i=1:height(allCategories)
    namePart1 = tblMovie.Properties.VariableNames(columnId);
    namePart2 = strrep(char(allCategories{i,1}),'-','');
    categoryCells = [categoryCells table(0,'VariableNames',strcat(namePart1,'_',namePart2))];
end;

%Write 1 to temp gener table
for i=1:height(tblMovie)
    categories=unique(tblMovie(i,columnId));
    for n=1:width(categories)
        warning('off','all')        
        categoryCells(i,find(allCategories{:,1} == categories{n,1})) = {1};
    end;
end;
warning('on','all')

%Add genre table to movie table
tblMovieCategoricalColumnNormalized = [tblMovieCategoricalColumnNormalized categoryCells];
clear genres
clear genresCells
clear allGenres

end

