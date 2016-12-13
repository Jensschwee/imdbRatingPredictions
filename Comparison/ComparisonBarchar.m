rsquard = [0.5 0.2];
CI = [0.1 0.15];
amount = 1:length(rsquard);
labels = {'label0' 'label1'};

figure
hold on
bar(amount,rsquard)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(amount,rsquard,CI,'.','color' , [1 0 0])
xlabel('Model')
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,...
 'xtick',[amount],...
 'xticklabel',labels)
set(gca,'fontsize',18)