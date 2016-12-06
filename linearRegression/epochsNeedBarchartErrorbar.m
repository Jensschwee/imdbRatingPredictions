figure
hold on
bar(AlphaTuning(:,1),AlphaTuning(:,2))
errorbar(AlphaTuning(:,1),AlphaTuning(:,2),AlphaTuning(:,3),'.')
xlabel('Alpha')
ylabel('Epochs')
title('Epochs need for Linear Regression')
set(gca, 'Ylim', [0 350])
set(gca,'fontsize',18)