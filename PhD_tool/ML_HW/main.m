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
    resultsKnn = k_NN( train_data, train_imageIds, test_data, test_imageIds, K);
    disp('k=2 Knn Score:');
    score=evaulate_results(resultsKnn,test_imageIds);
    sprintf('Score = %d \n',score);

   %%Sil
   
 %using pca


tic
pc= princomp(train_data);
toc

mean_face = mean(train_data);
pc_n=100;
f_pc= pc(1:pc_n,:)';
data_pca_tr = (train_data - repmat(mean_face, [s,1])) * f_pc;
data_pca_te = (test_data - repmat(mean_face, [n-s,1])) * f_pc;

tic
[nn_ind, estimated_label] = EuclDistClassifier(data_pca_tr,train_imageIds,data_pca_te);
toc

rate = sum(estimated_label == test_imageIds)/size(test_imageIds,1)



    %%  PCA 
    disp(' **PCA**')
    %perform pca
    train_data_pca = pca(train_data.').';    
    %perform pca to testdata
    test_data_pca = linear_subspace_projection_PhD(test_data, train_data_pca, 1);
    results = k_NN( train_data_pca, train_imageIds, test_data_pca, test_imageIds, K);
    disp('PCA Score:');
    evaulate_results(results,test_imageIds);
end




















