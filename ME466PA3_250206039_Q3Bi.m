clear; clc;

load uci_har.mat

Targets_ref=-1*ones(6,10299);

for k=1:10299
    Targets_ref(classes(k),k)=1;
end
c = cvpartition(size(features,2),'KFold',10);
num_input=561;
num_hidden=900;
num_output=6;
eta=0.001;

f=features;

%%

relE=inf;
prevE=inf;
conf=zeros(6);
for j = 1:c.NumTestSets
    
    Wih=0.02*(rand(num_input+1,num_hidden)-0.5);
    Who=0.02*(rand(num_hidden+1,num_output)-0.5);

    ind=randperm(10299);
    Inputs=f(:,ind);
    Targets=Targets_ref(:,ind);
    num_training=c.TrainSize(1,j);
    num_test=c.TestSize(1,j);
    Training=Inputs(:,1:num_training);
    TrainingTargets=Targets(:,1:num_training);
    
    Test=Inputs(:,num_training+1:end);
    TestTargets=Targets(:,num_training+1:end);    
    epoch=0;
    error = 1;
    trErrorhistory=[];
    while (error>0.15)
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
        error = trE;
        trErrorhistory=[trErrorhistory,trE];
        
        plot(trErrorhistory)
        hold on;

    end
    
    est=tanh(Who'*[tanh(Wih'*[Test;-1*ones(1,num_test)]);-1*ones(1,num_test)]);
    
    for k=1:num_test
        [~,I]=max(est(:,k));
        [~,J]=max(TestTargets(:,k));
        conf(J,I)=conf(J,I)+1;
    end
end

conf
