X = [randn(10,2); randn(15,2) + 1.5]; Y = [zeros(10,1); ones(15,1)];
W = LDA(X,Y);