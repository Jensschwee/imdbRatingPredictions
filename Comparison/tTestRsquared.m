function [pScore, bestRMeanCase] = tTestRsquared(Indexs, means, sds, sampleSize)
    BestRSD = sds(Indexs(1));
    BestRMean = means(Indexs(1));
    bestRMeanCase = [];
    for i=1:length(Indexs);
        SE = sqrt(((BestRSD).^2/sampleSize) + (sds(Indexs(i)).^2/sampleSize));
        diffMean = BestRMean - means(Indexs(i)) ;
        tScore = diffMean/SE;
        pScore(i) = tcdf(tScore,sampleSize-1);
        if(pScore(i) >= 0.05)
            bestRMeanCase = [bestRMeanCase i];
        end
    end
    
end


