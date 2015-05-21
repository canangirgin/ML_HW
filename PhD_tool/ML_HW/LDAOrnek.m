clear;
% A?a??daki 4 farkl? dataset için program? çal??t?r?p inceleyin
% Data2 ve Data3 için sorunsuz s?n?fland?rma
% Data4 do?rusal olmayan s?n?fland?rma yap?lmal?
% Data5 içerisinde 3 s?n?f var ve a?a??daki kodlar iki do?ru denklemi için geli?tirilmelidir.

load 'Data2.mat';
%load 'Data3.mat';
%load 'Data4.mat';
%load 'Data5.mat';

[N M] = size(train_data);
%verinin X giri?lerini de 0 ve 1 aral???na normalize etmeliyiz
train_dataLDA=(train_data-repmat(min(train_data),N,1))./(repmat(max(train_data),N,1)-repmat(min(train_data),N,1));

% LDA katsay?lar?n? hesapla
W = LDA(train_dataLDA, D);

% Verinin LDA katsay?lar?na göre do?rusal sonuçlar?n? hesapla
L = [ones(N,1) train_dataLDA] * W';

% S?n?f olas?l?klar?n? hesapla
P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);

figure;
subplot(1,2,1);
plot(train_dataLDA(D==1,1),X(D==1,2),'r.');
hold on;
plot(train_dataLDA(D==0,1),X(D==0,2),'b.');

subplot(1,2,2);
plot(P(D==1,1),P(D==1,2),'r.');
hold on;
plot(P(D==0,1),P(D==0,2),'b.');