BestRSD = AlphaTuning(9,5);
BestRMean = AlphaTuning(9,4);
BestEphosSD = AlphaTuning(9,7);
BestEphosMean = AlphaTuning(9,6);
bestRMeanCase = [];
BestEphos = [];

for i=1:size(AlphaTuning);
    SE = sqrt(((BestRSD).^2/10) + (AlphaTuning(i,5).^2/10));
    diffMean = BestRMean - AlphaTuning(i,4) ;
    tScore = diffMean/SE;
    pScore(i) =1- tcdf(tScore,9);
    if(pScore(i) >= 0.05)
        bestRMeanCase = [bestRMeanCase i];
    end
end

pScore = [];

for i=1:length(bestRMeanCase);
    SE = sqrt(((BestEphosSD).^2/10) + (AlphaTuning(bestRMeanCase(i),7).^2/10));
    diffMean = BestEphosMean - AlphaTuning(bestRMeanCase(i),6) ;
    tScore = diffMean/SE;
    pScore(i) = 1- tcdf(tScore,9);
    if(pScore(i) >= 0.05)
        bestRMeanCase(i)
        BestEphos = [BestEphos bestRMeanCase(i)];
    end
end
BestEphos


