clc
clear all
%tblMovie=readtable('movie_metadata.csv','Format','%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');

tblMovie=readtable('movie_metadata.csv','Format','%C%s%f%f%f%f%s%f%f%s%s%s%f%f%s%f%s%s%f%C%C%C%f%C%f%f%C%f');
tblMissing = ismissing(tblMovie);
tblMovie = tblMovie(~any(tblMissing,2),:);


clear tblMissing

%Country cleaning
tblMovie.country(find(tblMovie.country == 'New Line')) = 'USA';
tblMovie.country(find(tblMovie.country == 'Official site')) = 'USA';


% Remove duplicates by checking movie links
[~,ind] = unique(tblMovie(:,18));
tblMovie = tblMovie(ind,:);