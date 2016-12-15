rsquard = [0.476 0.4625 0.4035];
CI = [0.0301 0.0565 0.0236];
labels = {'140' '100 55' '140 100 55'};
XLabel = 'ANN PCA Hidden Layer Settings';
amount = 1:length(rsquard);

figure
hold on
bar(amount,rsquard)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(amount,rsquard,CI,'.','color' , [1 0 0])
xlabel(XLabel)
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,...
 'xtick',[amount],...
 'xticklabel',labels)
set(gca,'fontsize',18)