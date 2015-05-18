function results = k_NN(train_data, train_ids, test_data, test_ids, n, dist, match_kind);


%% Init 
results = [];

%% Check inputs

%check number of inputs
if nargin <4
    disp('Wrong number of input parameters! The function requires at least four input arguments.')
    return;
elseif nargin >7
    disp('Wrong number of input parameters! The function takes no more than seven input arguments.')
    return;
elseif nargin==4
    n = size(train,1);
    dist = 'cos';
    match_kind = 'all'
elseif nargin ==5
    dist = 'cos';
    match_kind = 'all';
elseif nargin ==6
    match_kind = 'all';    
end

%check distance
if ischar(dist)~=1
    disp('The parameter "dist" needs to be a string - a valid one!')
    return;
end

%check if test and train features are of same size
[a,b]=size(train_data);
[c,d]=size(test_data);
if b~=d
    disp('The number of features in the training and test vectors needs to be identical.')
    return;
end

%check the matching type 
if ischar(match_kind)~=1
    disp('The parameter "match_kind" has to be a string - a valid one!')
    return;
end

%check if match_kind is a valid string
if strcmp(match_kind,'all')==1 || strcmp(match_kind,'sep')==1 || strcmp(match_kind,'allID')==1
    %ok
else
    disp('The input string "match_kind" is not a valid identifier: all|sep.')
    return;
end

%check if n is not to big
if n>a
    disp('The parameter "n" cannot be larger than the dimensionality of your feature vectors. Decreasing "n" to maximal allowed size.')
    n=a;
end

%check if the distance is valid
if strcmp(dist,'cos')==1 || strcmp(dist,'euc')==1 || strcmp(dist,'ctb')==1 || strcmp(dist,'mahcos')==1
    %ok
else
    disp('The parameter "dist" need to be a valid string identifier: cos, euc, ctb, or mah. Switching to deafults (cos).')
    dist = 'cos';
end

%check if ids (class labels) are vectors
if isvector(train_ids)==0 
    disp('The second parameter "train_ids" needs to be a vector of numeric values.')
    return;
end

if isvector(test_ids)==0
    disp('The second parameter "train_ids" needs to be a vector of numeric values.')
    return;
end

%check that each feature vector has a label
[a,b]=size(train_data);
if a~=length(train_ids)
    disp('The label vector "train_ids" needs to be the same size as the number of samples in "train".')
    return;
end

[c,d]=size(test_data);
if c~=length(test_ids)
    disp('The label vector "test_ids" needs to be the same size as the number of samples in "test".')
    return;
end
% TODO Canan burayý aç results = knnclassify(test_data,train_data,train_ids,4,'euclidean','Consensus');
results = knnclassify(test_data,train_data,train_ids,n,'euclidean');
end

