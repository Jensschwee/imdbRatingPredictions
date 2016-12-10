figure
hold on
x = AlphaTuning(:,4);                     % Create Data
SEM = AlphaTuning(:,5)/sqrt(10);               % Standard Error
ts = tinv([0.025  0.975],9);      % T-Score
for i=1:size(x);
    CI(i)= (ts(1) .* SEM(i));                      % Confidence Intervals
end
bar(AlphaTuning(:,1),AlphaTuning(:,4))
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(AlphaTuning(:,1),AlphaTuning(:,4),CI,'.','color' , [1 0 0])
xlabel('Alpha')
ylabel('R Squared')
%title('Alpha tunning for Linear Regression orginal dataset')
set(gca, 'Ylim', [0 1])
set(gca, 'Xlim', [-0.002 0.048])
set(gca,'fontsize',18)