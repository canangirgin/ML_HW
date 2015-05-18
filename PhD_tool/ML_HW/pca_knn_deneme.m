clear;
K=3;

%% Load sample image
disp(sprintf('This is a demo script for the PhD toolbox. It demonstrates how to use several \nfunctions from the toolbox to construct a PCA-based face recognition system \nand how to test it on the ORL database. At the end, some results are generated.'));
disp(' ')
disp('Step 1:')
disp('Load images from a database. In our case, from the ORL database')

proceed = 1;
data_matrix = [];
ids = [];
try
    % construct image string and load image
    for i=1:40
        for j=1:10
            s = sprintf('database/s%i/%i.pgm',i,j);
            X=double(imread(s));
            data_matrix = [data_matrix,X(:)];
            ids = [ids;i];
        end
    end
    [size_y,size_x] = size(X);    
catch
   proceed = 0;
   disp(sprintf('Could not load images from the ORL database. Did you unpack it into \nthe appropriate directory? If NOT please follow the instructions \nin the user manual or the provided install script. Ending demo prematurely.'));
end

if(proceed)
    disp('Finished with Step 1 (database loading).')
    disp('Press any key to continue ...')
    pause();

    %% Partitioning of the data
    disp(' ')
    disp('Step 2:')
    disp('Partition data into training and test sets. In our case, the first 3 images')
    disp('of each ORL subject will serve as the training/gallery/target set and the remaining')
    disp('images will serve as test/evaluation/query images.')

    train_ids = [];
    test_ids = [];
    train_data = [];
    test_data = [];
    
    cont = 1;
    for i=1:40
        for j=1:10
            if j<4
                train_data = [train_data,data_matrix(:,cont)];
                train_ids  = [train_ids, ids(cont)];
            else
                test_data = [test_data,data_matrix(:,cont)];
                test_ids  = [test_ids,ids(cont)];
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




















