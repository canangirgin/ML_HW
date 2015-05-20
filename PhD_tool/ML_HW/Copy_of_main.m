clear;
K=3;

%% Load image
disp('**Load Image **')
loadImageOk = 1;
all_data = [];
imageIds = [];
try
    for i=1:40
        for j=1:10
            imagePath = sprintf('database/s%i/%i.pgm',i,j);
            image=double(imread(imagePath));
            all_data= [all_data,image(:)];
            imageIds = [imageIds;i];
        end
    end
    [size_y,size_x] = size(all_data);    
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
   cont = 1;
    for i=1:40
        for j=1:10
            if j<4
                train_data = [train_data,all_data(:,cont)];
                train_ids  = [train_imageIds, imageIds(cont)];
            else
                test_data = [test_data,all_data(:,cont)];
                test_ids  = [test_imageIds,imageIds(cont)];
            end
            cont = cont + 1;
        end 
    end
    
    %TODO Canan Buralar silinecek
    train_data2 = train_data.';
    test_features2 = test_data.';
    test_ids2 = test_ids.';
    train_ids2 = train_ids.'; 
    disp('Finished with Step 2 (data partitioning).')
    disp('Press any key to continue ...')
    pause();
    
    %
    
%% Knn
   disp(' **Knn-2**')
    results = k_NN( train_data2, train_ids2, test_features2, test_ids2, K, 'mahcos');
    disp('k=2 Knn Score:');
    evaulate_results(results,test_ids2);
    
	
    %%  PCA 
    disp(' **PCA**')
    %perform pca
    train_data_pca = perform_pca_PhD(train_data,rank(train_data)-1);    
    %perform pca to testdata
    test_data_pca = linear_subspace_projection_PhD(test_data, train_data_pca, 1);
    results = k_NN( train_data_pca.train.', train_ids2, test_data_pca.', test_ids2, K, 'mahcos');
    disp('PCA Score:');
    evaulate_results(results,test_ids2);
end




















