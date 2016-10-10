clc
clear all
%tblMovie=readtable('movie_metadata.csv','Format','%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');

tblMovie=readtable('movie_metadata.csv','Format','%C%s%f%f%f%f%s%f%f%s%s%s%f%f%s%f%s%s%f%C%C%C%f%C%f%f%C%f');
tblMissing = ismissing(tblMovie);
tblMovie = tblMovie(~any(tblMissing,2),:);


clear tblMissing

% Country cleaning
tblMovie.country(find(tblMovie.country == 'New Line')) = 'USA';
tblMovie.country(find(tblMovie.country == 'Official site')) = 'USA';


% Remove duplicates by checking movie links
[~,ind] = unique(tblMovie(:,18));
tblMovie = tblMovie(ind,:);

% Change genres to categorical data
for i=1:size(tblMovie)
    genres=regexp(tblMovie{i,10},'[|]+','split');
    tblMovie.genres{i} = categorical(genres{1});
end;
clear genres

% Change plot_keywords to categorical data
for i=1:size(tblMovie)
    plot_keywords=regexp(tblMovie{i,17},'[|]+','split');
    tblMovie.plot_keywords{i} = categorical(plot_keywords{1});
end;
clear plot_keywords

% Content rating in same std.
tblMovie.content_rating(find(tblMovie.content_rating == 'M')) = 'PG-13';
tblMovie.content_rating(find(tblMovie.content_rating == 'GP')) = 'PG';
tblMovie.content_rating(find(tblMovie.content_rating == 'X')) = 'No rating';
tblMovie.content_rating(find(tblMovie.content_rating == 'Approved')) = 'No rating';
tblMovie.content_rating(find(tblMovie.content_rating == 'Not Rated')) = 'No rating';
tblMovie.content_rating(find(tblMovie.content_rating == 'Unrated')) = 'No rating';
tblMovie.content_rating(find(tblMovie.content_rating == 'Passed')) = 'No rating';
