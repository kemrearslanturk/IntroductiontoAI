%Korkut Emre Arslantürk/ 250206039
clc
clear all
close all
load finalq7.mat

Targets=-1*ones(2,420);

for k=1:420
    Targets(gender(k),k)=1;
end

for j = 1:420
    data(j,:) = data(j,:) - mean(data(j,:));
end

DFT_mat = zeros(420,63);
for j = 1:420
    DFT = abs(fft(data(j,:),125));
    DFT_mat(j,:) = DFT(1:63);
    
end
%figure
%plot((DFT(1,:)));
%figure
%plot((DFT_mat(3,:)));

for i=1:63
    DFT_mat(i,:) = (DFT_mat(i,:) - min(DFT_mat(i,:))) / (max(DFT_mat(i,:)) - min(DFT_mat(i,:)));
end


idx = randperm(420);
training_idx = idx(1:250);
val_idx = idx(251:300);
test_idx = idx(301:end);

num_input = 63;
num_hidden = 150;
num_output = 2;
eta=0.0001;

Wih=0.02*(rand(num_input+1,num_hidden)-0.5);
Who=0.02*(rand(num_hidden+1,num_output)-0.5);

f=DFT_mat;

Training= f(training_idx,:)';
TrainingTargets = Targets(:,training_idx);
Validation = f(val_idx,:)';
ValidationTargets = Targets(:,val_idx);
Test = f(test_idx,:)';
TestTargets = Targets(:,test_idx);

num_training=250;
num_validation=50;
num_test=120;

relE=inf;
prevE=inf;
trErrorhistory=[];
valErrorhistory=[];
epoch=0;


while (relE>0.01)
    trE=0;
    for i=1:num_training
        v=Wih'*[Training(:,i);-1];
        o=tanh(v);
        
        vv=Who'*[o;-1];
        oo=tanh(vv);
        
        trE=trE+sum((oo-TrainingTargets(:,i)).^2);
        
        deltao=(oo-TrainingTargets(:,i)).*(1-oo.^2);
        Who=Who+(-eta*[o;-1]*deltao');
        deltah=(Who*deltao).*(1-[o;-1].^2);
        Wih=Wih+(-eta*[Training(:,i);-1]*deltah(1:end-1)');
    end
    epoch=epoch+1;
    trE=trE/num_training;
    val=tanh(Who'*[tanh(Wih'*[Validation;-1*ones(1,num_validation)]);-1*ones(1,num_validation)]);
    E=sum(sum((val-ValidationTargets).^2))/num_validation;
    relE=(prevE-E)/E;
    prevE=E;
    trErrorhistory=[trErrorhistory,trE];
    valErrorhistory=[valErrorhistory,E];
    plot(trErrorhistory)
    hold on;
    plot(valErrorhistory)
    hold off;
    pause(0.1);
    title("The Graph of a Loss as a function of Iteration for Gender Estimation");
    xlabel('Iteration');
    ylabel('Loss');
    legend({'Training Loss','Validation Loss'});
end

est=tanh(Who'*[tanh(Wih'*[Test;-1*ones(1,num_test)]);-1*ones(1,num_test)]);

conf=zeros(2);

for k=1:num_test
    [~,I]=max(est(:,k));
    [~,J]=max(TestTargets(:,k));
    conf(J,I)=conf(J,I)+1;
end

conf

temp = 0;

for i = 1:2
    temp = temp + conf(i,i);
end
