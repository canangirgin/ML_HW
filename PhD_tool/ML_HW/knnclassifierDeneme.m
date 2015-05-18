sample = [.9 .8;.1 .3;.2 .6]
training=[0 0;.5 .5;1 1]
group = [1;2;3]
class = knnclassify(sample, training, group)


%%
load fisheriris
c = knnclassify(meas,meas,species,4,'euclidean','Consensus');
cp = classperf(species,c)
get(cp);
cp.CorrectRate

%%
load fisheriris
indices = crossvalind('Kfold',species,10);
cp = classperf(species); % initializes the CP object
for i = 1:10
    test = (indices == i); train = ~test;
    class = classify(meas(test,3),meas(train,3),species(train));
    % updates the CP object with the current classification results
    classperf(cp,class,test)  
end
cp.CorrectRate % queries for the correct classification rate