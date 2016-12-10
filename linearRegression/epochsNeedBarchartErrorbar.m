figure
hold on
x = AlphaTuning(:,2);                     % Create Data
SEM = AlphaTuning(:,3)/sqrt(10);               % Standard Error
ts = tinv([0.025  0.975],9);      % T-Score
for i=1:size(x);
    CI(i)= (ts(1) .* SEM(i));                      % Confidence Intervals
end
bar(AlphaTuning(:,1),AlphaTuning(:,2))
colormap([0.6901960784313725,0.8784313725490196,0.9019607843137255])
errorbar(AlphaTuning(:,1),AlphaTuning(:,2),CI,'.', 'color' , [1 0 0])
xlabel('Alpha')
ylabel('Epochs')
%title('Epochs need for Linear Regression')
set(gca, 'Ylim', [0 350])
set(gca,'fontsize',18)