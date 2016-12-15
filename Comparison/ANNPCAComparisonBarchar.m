rsquard = [0.5208 0. 0.4960];
CI = [0.0301 0. 0.0195];
labels = {'180' '90 55' '100 35 55'};
XLabel = 'ANN Hidden Layer Settings';
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