%Korkut Emre Arslantürk/ 250206039
clc
clear all
close all
load finalq7.mat

for j = 1:420
    data(j,:) = data(j,:) - mean(data(j,:));
end

DFT_mat = zeros(420,63);

for j = 1:420
    DFT = abs(fft(data(j,:),125));
    DFT_mat(j,:) = DFT(1:63);
end
    
for i=1:63
    DFT_mat(i,:) = (DFT_mat(i,:) - min(DFT_mat(i,:))) / (max(DFT_mat(i,:)) - min(DFT_mat(i,:)));
end

idx = randperm(420);
training_idx = idx(1:300);
test_idx = idx(301:end);
true_class = participants(test_idx);

KNN = fitcknn(DFT_mat(training_idx,:),participants(training_idx)','NumNeighbors',5);

label = predict(KNN,DFT_mat(test_idx,:));

conf = zeros(7);

for i = 1:120
    conf(label(i),true_class(i)) = conf(label(i),true_class(i)) + 1;
end
conf

temp = 0;

for i = 1:7
    temp = temp + conf(i,i);
end
