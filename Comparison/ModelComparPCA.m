names = ['Linear' 'ANN' 'Median'];
means = [0.39 0.4015 0.25];
sds = [0.0154299003865390 0.0314980009097480 0];
ephos = [74.36 111.07 0];
ephosSds = [1.9505 73.9389237242612 0];

[b, indexes] = sort(means, 'descend');

[pScore1, bestRMeanCase] = tTestRsquared(indexes, means, sds,10);
pScore1
bestRMeanCase
names(indexes(bestRMeanCase))

[b1, indexes1] = sort(ephos(indexes(bestRMeanCase)), 'ascend');
[pScoreE, bestEpohsMeanCase] = tTestEphos(indexes(indexes1), ephos, ephosSds,10);
pScoreE
bestEpohsMeanCase
names(indexes(indexes1(bestEpohsMeanCase)))
