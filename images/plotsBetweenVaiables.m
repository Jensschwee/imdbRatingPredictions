%color 
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.color, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('color')
ylabel('revenue')
title('color over revenue')
print('color','-dpng');

%num_critic_for_reviews
scatter(tblMovieNormalized.num_critic_for_reviews, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('num critic for reviews')
ylabel('revenue')
title('num critic for reviews over revenue')
print('num_critic_for_reviews','-dpng');

%duration
scatter(tblMovieNormalized.duration, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('duration')
ylabel('revenue')
title('duration over revenue')
print('duration','-dpng');

%director_facebook_likes
scatter(tblMovieNormalized.director_facebook_likes, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('director facebook likes')
ylabel('revenue')
title('director facebook likes over revenue')
print('director_facebook_likes','-dpng');

%actor_3_facebook_likes
scatter(tblMovieNormalized.actor_3_facebook_likes, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('actor 3 facebook likes')
ylabel('revenue')
title('actor 3 facebook likes over revenue')
print('actor_3_facebook_likes','-dpng');

%actor_1_facebook_likes
scatter(tblMovieNormalized.actor_1_facebook_likes, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('actor 1 facebook likes')
ylabel('revenue')
title('actor 1 facebook likes over revenue')
print('actor_1_facebook_likes','-dpng');

%cast_total_facebook_likes
scatter(tblMovieNormalized.cast_total_facebook_likes, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('cast total facebook likes')
ylabel('revenue')
title('cast total facebook likes over revenue')
print('cast_total_facebook_likes','-dpng');

%actor_2_facebook_likes
scatter(tblMovieNormalized.actor_2_facebook_likes, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('actor 2 facebook likes')
ylabel('revenue')
title('actor 2 facebook likes over revenue')
print('actor_2_facebook_likes','-dpng');

%facenumber_in_poster
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.facenumber_in_poster, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('facenumber in poster')
ylabel('revenue')
title('facenumber in poster over revenue')
print('facenumber_in_poster','-dpng');

%aspect_ratio
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.aspect_ratio, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('aspect ratio')
ylabel('revenue')
title('aspect ratio over revenue')
print('aspect_ratio','-dpng');

%content_rating
%TODO, make boxplot of both cats
scatter(tblMovieNormalized.content_rating, tblMovieNormalized.revenue)
set(gca,'fontsize',18)
xlabel('content rating')
ylabel('revenue')
title('content rating over revenue')
print('content_rating','-dpng');