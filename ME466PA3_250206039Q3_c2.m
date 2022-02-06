clear; clc;

load uci_har.mat

Targets_ref=-1*ones(6,10299);

for k=1:10299
    Targets_ref(classes(k),k)=1;
end

new_features = pca(features,'NumComponents',10);
new_features = new_features';
%%
num_input=10;
num_hidden=100;
num_output=6;
eta=0.001;

for i= 1:30
    ind(i,:)=~(participants == i);
end

f=new_features;

%%


relE=inf;
prevE=inf;
trErrorhistory=[];


conf=zeros(6);

for j = 1:30
    
    Wih=0.02*(rand(num_input+1,num_hidden)-0.5);
    Who=0.02*(rand(num_hidden+1,num_output)-0.5);

   
    Inputs=f;
    Targets=Targets_ref;
    num_training=sum(ind(j,:) == 1);
    num_test=10299-num_training;
    Training=Inputs(:,ind(j,:)==1);
    TrainingTargets=Targets(:,ind(j,:)==1);
    
    Test=Inputs(:,ind(j,:)==0);
    TestTargets=Targets(:,ind(j,:)==0);    
    epoch=0;
    while (epoch<500)
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
        
        trErrorhistory=[trErrorhistory,trE];
        
        plot(trErrorhistory)
        hold on;
        pause(0.1)
    end
    
    est=tanh(Who'*[tanh(Wih'*[Test;-1*ones(1,num_test)]);-1*ones(1,num_test)]);
    
    
    
    for k=1:num_test
        [~,I]=max(est(:,k));
        [~,J]=max(TestTargets(:,k));
        conf(J,I)=conf(J,I)+1;
    end
end

conf