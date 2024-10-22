rsquard = [0.55 0.39 0.2522];
CI = [0.0297 0.0130 0];
labels = {'Linear' 'Linear PCA' 'Median'};
XLabel = 'Model';
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