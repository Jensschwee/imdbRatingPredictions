figure
hold on
bar(AlphaTuning(:,1),AlphaTuning(:,4))
errorbar(AlphaTuning(:,1),AlphaTuning(:,4),AlphaTuning(:,5),'.')
xlabel('Alpha')
ylabel('r squared')
title('Alpha tunning for Linear Regression PCA dataset')
set(gca, 'Ylim', [0 1])
set(gca,'fontsize',18)
