function results = k_NN(train_data, train_imageIds, test_data, test_imageIds, K);


%% Init 
results = [];

%% Check inputs
if nargin ~=5
    disp('Wrong number of input parameters! The function requires at least four input arguments.')
    return;
end

%check test and train size is same

if length(train_data)~=length(test_data)
    disp('Train and test feature sizes are not the same')
    return;
end

% TODO Canan Sondaki iki parametrenin farklı versiyonlarını dene
%results = knnclassify(test_data,train_data,train_imageIds,K,'euclidean','Consensus');
results = knnclassify(test_data,train_data,train_imageIds,K,'euclidean');
end

