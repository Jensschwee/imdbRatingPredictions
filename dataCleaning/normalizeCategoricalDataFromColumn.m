function [ tblMovieCategoricalColumnNormalized ] = normalizeCategoricalDataFromColumn( tblMovie, columnId )
%SPLITCATEGORICAL Normalize categorical column of the specified columnId

tblMovieCategoricalColumnNormalized = tblMovie;

allCategories = '';
for i=1:size(tblMovie)
    categories=regexp(tblMovie{i,columnId},'[|]+','split');
    allCategories = [allCategories, categorical(categories{1})];
end;
allCategories = unique(allCategories);

%Create genre table for temp generes
categoryCells = '';
for i=1:length(allCategories) % TODO replace genre below with columnname
    namePart1 = tblMovie.Properties.VariableNames(columnId);
    namePart2 = strrep(char(allCategories(i)),'-','');
    categoryCells = [categoryCells table(0,'VariableNames',strcat(namePart1,'_',namePart2))];
end;

%Write 1 to temp gener table
for i=1:size(tblMovie)
    categories=regexp(tblMovie{i,columnId},'[|]+','split');
    for n=1:length(categories{1})
        warning('off','all')
        categoryCells(i,find(allCategories == categories{1}(n))) = {1};
    end;
end;
warning('on','all')

%Add genre table to movie table
tblMovieCategoricalColumnNormalized = [tblMovieCategoricalColumnNormalized categoryCells];
clear genres
clear genresCells
clear allGenres

end

