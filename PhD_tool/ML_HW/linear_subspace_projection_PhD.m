

function feat = linear_subspace_projection_PhD(test_data, train_data, orthogon);

%% Init 
feat=[];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >3
    disp('Wrong number of input parameters! The function takes no more than three input arguments.')
    return;
elseif nargin==2
    orthogon = 1;
end

%check model
if isfield(model,'W')~=1
    disp('There is no subspace basis defined. Missing model.W!')
    return;
end

if isfield(model,'P')~=1
    disp('There is no mean face defined. Missing model.P!')
    return;
end

if isfield(model,'dim')~=1
    disp('There is no subspace dimensionality defined. Missing model.dim!')
    return;
end

%% Init operations

%check the size of the test data and report to command prompt
[a,b]=size(test_data);
[c,d]=size(model.W);

if b~=d 
    disp('Train and test feature sizes are not the same')
    return;
end

%% Compute the features (i.e., the subspace projection)
%centering
X = test_data-repmat(model.P,1,b); %if you have memory problems put this in a for loop

%we now have two options, depending on whether the subspace is determined
%by a orthogonal basis (e.g., PCA or LDA) or a non-orthogonal one (e.g.,
%ICA)

if orthogon == 1 %the subspace is orthogonal
    feat = model.W'*X;
else
    feat = inv(model.W'*model.W)*model.W'*test_data;
end


