function [pScore, bestEphosMeanCase] = tTestEphos(Indexs, ephos, sds, sampleSize)
    BestRSD = sds(Indexs(1));
    BestEphosMean = ephos(Indexs(1));
    bestEphosMeanCase = [];
    for i=1:length(Indexs);
        SE = sqrt(((BestRSD).^2/sampleSize) + (sds(Indexs(i)).^2/sampleSize));
        diffMean = BestEphosMean - ephos(Indexs(i)) ;
        tScore = diffMean/SE;
        pScore(i) =1- tcdf(tScore,sampleSize-1);
        if(pScore(i) >= 0.05)
            bestEphosMeanCase = [bestEphosMeanCase i];
        end
    end
end


