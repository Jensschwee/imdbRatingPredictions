function [ tblMovieRevenueAdded ] = addRevenue( tblMovie )
%ADDREVENUE Add revenue

tblMovieRevenueAdded = tblMovie;
tblMovieRevenueAdded.revenue = tblMovie.gross - tblMovie.budget;

end

