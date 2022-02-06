% Part A
nu_1c=[0 0]; nu_2c=[1 1];
sigma_1c_a=[1 0;0 1]; sigma_2c_a=[1 0;0 1];
R = chol(sigma_1c_a);
z1 = repmat(nu_1c,100,1) + randn(100,2)*R;
R = chol(sigma_2c_a);
z2 = repmat(nu_2c,100,1) + randn(100,2)*R;
figure
plot(z1(:,1),z1(:,2),'b.')
hold on;
plot(z2(:,1),z2(:,2),'r.')
syms x1 x2;
g1_e = -0.5*([x1;x2]-nu_1c')'*inv(sigma_1c_a)*([x1;x2]-nu_1c')-0.5*log(det(sigma_1c_a))+log(0.5);
g2_e = -0.5*([x1;x2]-nu_2c')'*inv(sigma_2c_a)*([x1;x2]-nu_2c')-0.5*log(det(sigma_1c_a))+log(0.5);

g_e=g1_e-g2_e; % boundary region equation
fimplicit(g_e); 
title('Part A: Equation of Bayes  D. boundary for the equal prior probabilities');
legend('Gaussian Ran. Var. (g1)','Gaussian Ran. Var. (g2)','Decision B.');
hold off

% Part B
Pw1_1=1/4; Pw2_1=3/4;
nu1_b=[0 0]; nu2_b=[1 1];
sigma1_a=[1 0;0 1]; sigma2_b=[1 0;0 1];
figure
R_b = chol(sigma1_a);
z1_b = repmat(nu1_b,100,1) + randn(100,2)*R_b;
R_b = chol(sigma2_b);
z2_b = repmat(nu2_b,100,1) + randn(100,2)*R_b;
plot(z1_b(:,1),z1_b(:,2),'b.')
hold on;
plot(z2_b(:,1),z2_b(:,2),'r.')
syms x1 x2;
g1b_e = -0.5*([x1;x2]-nu1_b')'*inv(sigma1_a)*([x1;x2]-nu1_b')-0.5*log(det(sigma1_a))+log(Pw1_1);
g2b_e = -0.5*([x1;x2]-nu2_b')'*inv(sigma2_b)*([x1;x2]-nu2_b')-0.5*log(det(sigma1_a))+log(Pw2_1);
g_e1=g1b_e-g2b_e; 
fimplicit(g_e1);
title('Part B: Equation of the Bayes d. boundary for P(w1) = 1/4 and P(w2) = 3/4');
legend('Gaussian random variable (g1)','Gaussian random variable (g2)','Decision Boundary');
hold off;

% Part C for part A
nu_1c=[0 0]; nu_2c=[1 1];
sigma_1c_a=[2 0.5;0.5 2]; sigma_2c_a=[5 4;4 5];
figure
R = chol(sigma_1c_a);
z1 = repmat(nu_1c,100,1) + randn(100,2)*R;
R = chol(sigma_2c_a);
z2 = repmat(nu_2c,100,1) + randn(100,2)*R;
plot(z1(:,1),z1(:,2),'b.')
hold on;
plot(z2(:,1),z2(:,2),'r.')
syms x1 x2;
g1b_e = -0.5*([x1;x2]-nu_1c')'*inv(sigma_1c_a)*([x1;x2]-nu_1c')-0.5*log(det(sigma_1c_a))+log(0.5);
g2b_e = -0.5*([x1;x2]-nu_2c')'*inv(sigma_2c_a)*([x1;x2]-nu_2c')--0.5*log(det(sigma_1c_a))+log(0.5);
g_e=g1b_e-g2b_e; 
fimplicit(g_e);
title(' Part C: Equation of the Bayes d.b for P(w1) = P(w2) for new values');
legend('Gaussian random variable (g1)','Gaussian random variable (g2)','Decision Boundary');
hold off;
% Part C for part B
Pw_3c_b=1/4; Pw_4c_b=3/4;
mu1_d=[0 0]; mu2_d=[1 1];
sigma1_3=[2 0.5;0.5 2]; sigma2_3=[5 4;4 5];
R_3 = chol(sigma1_3); R_2_3 = chol(sigma2_3);
z1_3 = repmat(mu1_d,100,1) + randn(100,2)*R_3;
z2_3 = repmat(mu2_d,100,1) + randn(100,2)*R_2_3;
figure
plot(z1_3(:,1),z1_3(:,2),'b.')
hold on;
plot(z2_3(:,1),z2_3(:,2),'r.')      
syms x1 x2;
g13_e = -0.5*([x1;x2]-mu1_d')'*inv(sigma1_3)*([x1;x2]-mu1_d')-0.5*log(det(sigma1_3))-log(Pw_3c_b);
g23_e = -0.5*([x1;x2]-mu2_d')'*inv(sigma2_3)*([x1;x2]-mu2_d')-0.5*log(det(sigma1_3))-log(Pw_4c_b);
g_e_3=g13_e-g23_e; % equation of boundary region
fimplicit(g_e_3);
title(' Part C: Equation of the Bayes d.b for P(w1) = 1/4 anSd SP(w2) = 3/4 for new values')
legend('Gaussian random variable g1','Gaussian random variable g2','Decision Boundary');
hold off;
% Part D
Pw1=2/4; Pw2=2/4;
nu_1c=[0 0]; nu_2c=[1 1];
sigma_1c_a=[1 0;0 1]; sigma_2c_a=[3 0;0 3];
R = chol(sigma_1c_a); R = chol(sigma_2c_a);
z1 = repmat(nu_1c,100,1) + randn(100,2)*R;
z2 = repmat(nu_2c,100,1) + randn(100,2)*R;
figure
plot(z1(:,1),z1(:,2),'b.')
hold on;
plot(z2(:,1),z2(:,2),'r.')
syms x1 x2;
g1b_e = -0.5*([x1;x2]-nu_1c')'*inv(sigma_1c_a)*([x1;x2]-nu_1c')-0.5*log(det(sigma_1c_a))+log(Pw1);
g2b_e = -0.5*([x1;x2]-nu_2c')'*inv(sigma_2c_a)*([x1;x2]-nu_2c')-0.5*log(det(sigma_1c_a))+log(Pw2);
g_e=g1b_e-g2b_e; % equation of boundary region
fimplicit(g_e);
title('Part D Figure of possible set to get an ellipse');
legend('Gaussian random variable (g1)','Gaussian random variable (g2)','Decision Boundary');
hold off;