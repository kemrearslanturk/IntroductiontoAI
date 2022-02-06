close all
clc
%% part.a

%In order to work this code please import data file 

wdbc.M = grp2idx(wdbc.M)-1;
info_matrix = table2array(wdbc);
classes = info_matrix(:,2);
features = info_matrix(:,3:end);
c = cvpartition(length(features),'KFold',10);


index = zeros(1,length(info_matrix));
predicted = zeros(1,length(info_matrix));
data0 = features(classes == 0,:);
mu0 = mean(data0,1);
sigma0 = cov(data0);
data1 = features(classes == 1,:);
mu1 = mean(data1,1);
sigma1 = cov(data1);



for i = 1:length(info_matrix)
    newsample = info_matrix(i,3:end);
    y0 = mvnpdf(newsample,mu0,0.2*sigma0);
    y1 = mvnpdf(newsample,mu1,sigma1);
    [~,idx] = max([y0 y1]);
    index(i) = info_matrix(i,2);
    predicted(i) = idx-1;
end
figure;
plotconfusion(index,predicted);

CM = zeros(2);

for i = 1:c.NumTestSets
    training = features(c.training(i),:);
    test = features(c.test(i),:);
    trueclass_labels = classes(c.test(i));
    train0 = training(classes(c.training(i))==0,:);
    train1 = training(classes(c.training(i))==1,:);
    var = 5;
    for j = 1:length(test)
        data = test(j,:);
        y0 = KDE(data,train0,var); y1 = KDE(data,train1,var);
        y_arr = [y0 y1];
        [~,idx] = max(y_arr);
        row = idx;
        column = trueclass_labels(j) + 1;
        CM(row,column) = CM(row,column) + 1;
    end
end
CM;

function y=KDE(x,training,h)

n=size(training,1);

sum=0;

for k=1:n
    F=exp(-(x-training(k,:))*(x-training(k,:))'/(2*h^2));
    sum=sum+F;
end

sum=sum/(n*h);

y=sum;
end