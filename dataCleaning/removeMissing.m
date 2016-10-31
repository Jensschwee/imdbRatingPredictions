function [ tblMovieMissingRemoved ] = removeMissing( tblMovie )
%REMOVEMISSING Removes rows in the table with missing variables.

tblMissing = ismissing(tblMovie);
tblMovieMissingRemoved = tblMovie(~any(tblMissing,2),:);

end

