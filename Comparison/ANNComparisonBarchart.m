
%% WITHOUT PCA
%rsquard = [0.5208 0.4839 0.4960];
%CI = [0.0301 0.0217 0.0195];
%labels = {'180' '90  55' '100 35 55'};

%% WITH PCA
rsquard = [0.4015 0.3988 0.4035];
CI = [0.0263 0.0168 0.0236];
labels = {'140' '100  55' '140  120  55'};

%%

amount = 1:length(rsquard);

figure
hold on
bar(amount,rsquard)
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(amount,rsquard,CI,'.','color' , [1 0 0])
xlabel('Hidden Layer Configuration')
ylabel('R Squared')
set(gca, 'Ylim', [0 1])
set(gca,...
 'xtick',[amount],...
 'xticklabel',labels)
set(gca,'fontsize',18)