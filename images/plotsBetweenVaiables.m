tblMovieNormalized=readtable('../movie_metadata_cleaned.csv');

%color 
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.color, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('Color')
ylabel('IMDB score')
title('Color over IMDB score')
print('color','-dpng');

%num_critic_for_reviews
scatter(tblMovieNormalized.num_critic_for_reviews, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('num critic for reviews')
ylabel('IMDB score')
title('num critic for reviews over IMDB score')
print('num_critic_for_reviews','-dpng');

%duration
scatter(tblMovieNormalized.duration, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('duration')
ylabel('IMDB score')
title('Duration over IMDB score')
print('duration','-dpng');

%director_facebook_likes
scatter(tblMovieNormalized.director_facebook_likes, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('director facebook likes')
ylabel('IMDB score')
title('director facebook likes over IMDB score')
print('director_facebook_likes','-dpng');

%actor_3_facebook_likes
scatter(tblMovieNormalized.actor_3_facebook_likes, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('actor 3 facebook likes')
ylabel('IMDB score')
title('actor 3 facebook likes over IMDB score')
print('actor_3_facebook_likes','-dpng');

%actor_1_facebook_likes
scatter(tblMovieNormalized.actor_1_facebook_likes, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('actor 1 facebook likes')
ylabel('IMDB score')
title('actor 1 facebook likes over IMDB score')
print('actor_1_facebook_likes','-dpng');

%cast_total_facebook_likes
scatter(tblMovieNormalized.cast_total_facebook_likes, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('cast total facebook likes')
ylabel('IMDB score')
title('cast total facebook likes over IMDB score')
print('cast_total_facebook_likes','-dpng');

%actor_2_facebook_likes
scatter(tblMovieNormalized.actor_2_facebook_likes, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('actor 2 facebook likes')
ylabel('IMDB score')
title('actor 2 facebook likes over IMDB score')
print('actor_2_facebook_likes','-dpng');

%facenumber_in_poster
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.facenumber_in_poster, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('facenumber in poster')
ylabel('IMDB score')
title('facenumber in poster over IMDB score')
print('facenumber_in_poster','-dpng');

%aspect_ratio
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.aspect_ratio, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('aspect ratio')
ylabel('IMDB score')
title('aspect ratio over IMDB score')
print('aspect_ratio','-dpng');

%content_rating
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.content_rating, tblMovieNormalized.imdb_score)
set(gca,'fontsize',18)
xlabel('content rating')
ylabel('IMDB score')
title('content rating over IMDB score')
print('content_rating','-dpng');