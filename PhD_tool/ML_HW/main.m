clear;
K=3;

%% Load image
disp('**Load Image **')
loadImageOk = 1;
all_data = [];
all_imageIds = [];
try
    for i=1:40
        for j=1:10
            imagePath = sprintf('database/s%i/%i.pgm',i,j);
            image=double(imread(imagePath));
            all_data= [all_data;image(:).'];
            all_imageIds = [all_imageIds;i];
        end
    end
    [size_x,size_y] = size(all_data);    
catch
   loadImageOk = 0;
   disp(sprintf('Could not find images'));
end

%% Prepare Train and Test Data
if(loadImageOk)
   disp('**Prepare Train and Test Data**');
   train_imageIds = [];
   test_imageIds = [];
   train_data = [];
   test_data = [];
   count = 1;
    for i=1:40
        for j=1:10
            if j<4
                train_data = [train_data;all_data(count,:)];
                train_imageIds  = [train_imageIds; all_imageIds(count)];
            else
                test_data = [test_data;all_data(count,:)];
                test_imageIds  = [test_imageIds;all_imageIds(count)];
            end
            count = count + 1;
        end 
    end
    

%% Knn
 disp(' **Knn-2**')
 resultsKnn = k_NN( train_data, train_imageIds, test_data, K);
 disp('k=2 Knn Score:');
 score=evaulate_results(resultsKnn,test_imageIds);
 sprintf('Score = %d \n',score)
   
 %% using PCA
 disp(' **PCA**')
[coef train_data_pca]=pca(train_data);
m=mean(train_data);
test_data_pca=(test_data-repmat(m,[280,1]))*coef;
resultsKnn2=k_NN(train_data_pca,train_imageIds,test_data_pca,1);
scorePCA=evaulate_results(resultsKnn2,test_imageIds);
sprintf('Score = %d \n',scorePCA);

%% using LDA
% disp(' **LDA**')
% resultLDA=classify(test_data,train_data,train_imageIds,'linear');
% scoreLDA=classperf(test_imageIds,resultLDA);
% sprintf('Score = %d \n',scoreLDA);

%% Sil

W= LDA(train_data,train_imageIds);

end