
%% WITHOUT PCA
%rsquard = [160.98 145.9083 211.66];
%CI = [51.8601 51.2371 65.2171];
%labels = {'180' '90  55' '100 35 55'};

%% WITH PCA
rsquard = [131.69 187.96 250.597];
CI = [47.4256 34.3519 80.2969];
labels = {'140' '100  55' '140  120  55'};

%%

amount = 1:length(rsquard);

figure
hold on
bar(amount,rsquard)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(amount,rsquard,CI,'.','color' , [1 0 0])
xlabel('Hidden Layer Configuration')
ylabel('Training Time (s)')
set(gca, 'Ylim', [0 350])
set(gca,...
 'xtick',[amount],...
 'xticklabel',labels)
set(gca,'fontsize',18)