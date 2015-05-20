function model = pca(train_data, n);

%% Init
model = [];

%% Check inputs

%check number of inputs
if nargin <1
    disp('Wrong number of input parameters! The function requires at least one input argument.')
    return;
elseif nargin >2
    disp('Wrong number of input parameters! The function takes no more than two input arguments.')
    return;
elseif nargin==1
    [a,b]=size(train_data);
    n = min([a,b])-1;
    %n = rank(X)-1; %this would be the right (computationally expensive) way to go
end

%% Init operations

%check the size of the training data and report to command prompt
[a,b]=size(train_data);

if n > (min([a,b])-1) %(rank(X)-1) %this would be the right way to go
    disp(sprintf('The number of retained PCA components can not exceed %i.', (min([a,b])-1)))
    return;
end

%we assume that the data is contained in the columns
disp(sprintf('The training data comprises %i samples (images) with %i variables (pixels).', b, a))
disp('If this should be the other way around, please transpose the training-data matrix.')


%% Compute the PCA subspace - main part

%we center the data around the median (for robustness) - normaly this would
%be the mean (with enough data and a valid gaussian assumption on the
%variables this is identical)

%first model output
% model.P = median(X,2); %this is the mean face
model.P = mean(X,2); %this is the mean face
model.dim = n;

%center data
X = X-repmat(model.P,1,b); %if you have memory problems put this in a for loop

%compute PCA transform using the Eigenface trick
if b < a
    [U,V,L] = svd(X'*X);
    clear L %save some memory
    model.W = normc(X*U(:,1:n)); %here are the eigenfaces - display a column in image form to visualize them  
    clear U
else
    [U,V,L] = svd(X*X');
    clear L %save some memory
    model.W = normc(U(:,1:n)); %here are the eigenfaces - display a column in image form to visualize them 
    clear U
end

%% Produce traninig features for possible Mahalanobis matching

%compute features
model.train = model.W'*X;
model.eigenVal = diag(V);














