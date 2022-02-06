clc
close all
clear all
w = rand(1,4);
ww=w;
datas = [0 0 0 0; 0 0 1 1; 0 1 0 0; 0 1 1 1; 1 0 0 0; 1 0 1 1; 1 1 0 1; 1 1 1 1];
eta=0.6;
trE=1;
e=eps;
count=0;
while trE>e
    trE=1;
    for i = 1:8
        x1 = datas(i,1);
        x2 = datas(i,2);
        x3 = datas(i,3);
        t = datas(i,4);
        o = neuron(x1,x2,x3,w);
        Err=((t-o)^2)/2;
        trE = trE+Err;
        delta = (t-o)*der_neuron(x1,x2,x3,w);
        w = w+(eta*delta*[x1 x2 x3 -1]);
    end 
    trE=(trE-1)/8;
    count=count+1;
end


x11=[];x22=[];y11=[];y22=[];z11=[];z22=[];
for i=1:8
    x(i)=[datas(i,1)];
    y(i)=[datas(i,2)];
    z(i)=[datas(i,3)];
    o = neuron(x(i),y(i),z(i),w);
    if o<0.5
        x11=[x11 datas(i,1)];
        y11=[y11 datas(i,2)];
        z11=[z11 datas(i,3)];
    elseif o>0.5
        x22=[x22 datas(i,1)];
        y22=[y22 datas(i,2)];
        z22=[z22 datas(i,3)];
    end
end
plot3(x11,y11,z11,'o')
title("The Class Distinction ")
hold on
plot3(x22,y22,z22,'x')
xlabel('X')
ylabel('Y')
zlabel('Z')

function f=neuron(x1,x2,x3,w)

a = x1*w(1)+x2*w(2)+x3*w(3)-1*w(4);

if a<-0.5
    f=0;
elseif -0.5<a && a<0.5
    f=a+0.5;
elseif 0.5<a
    f=1;
end
end

function f=der_neuron(x1,x2,x3,w)
a = x1*w(1)+x2*w(2)+x3*w(3)-1*w(4);
if -0.5<a && a<0.5
    f=1;
else 
    f=0;
end

end
