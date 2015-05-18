% Performs matching score calculation based on the nearest neighbor classifier
% 
% PROTOTYPE
% results = nn_classification_PhD(train, train_ids, test, test_ids, n, dist, match_kind);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       % we randomly generate a few 100-dimensional training and testing  
%       % feature vectors belonging to 20 classes; 
%       % this shows the use of the 'all' match_kind option; each feature 
%       % vector ID is in the training as well as the testing set
         n=100;
        train_feature_vectors=[];
         test_feature_vectors=[];
         test_ids = [];
         train_ids = [];
         for i=1:20
         for j=1:10
                 train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
                 train_ids = [train_ids,i];
                 test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
                 test_ids = [test_ids,i];
             end
         end    
         results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','all')
 
%     Example 2:
%       % we randomly generate a few 100-dimensional training and testing  
%       % feature vectors belonging to 20 classes; 
%       % this shows the use of the 'sep' match_kind option; there are a 
%       % few feature vector IDs that are in our testing set but not in the
%       % training set
%         n=100;
%         train_feature_vectors=[];
%         test_feature_vectors=[];
%         test_ids = [];
%         train_ids = [];
%         for i=1:20
%             for j=1:10
%                 if(i<10)
%                   train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
%                   train_ids = [train_ids,i];
%                 end
%                 test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
%                 test_ids = [test_ids,i];
%             end
%         end
%         results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','sep');
%       
%
%




