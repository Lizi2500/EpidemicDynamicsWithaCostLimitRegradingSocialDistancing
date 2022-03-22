
clc
clear
tic

%% Parameters

time=500;

lambda=0.0:0.01:1.0;
gamma=1.0;

alpha=0.8;
beta=1.0;

eta=0.8;

average_degree_1=6.0;
average_degree_2=2.0;
degree_min_1=0;
degree_max_1=4*average_degree_1;
degree_min_2=0;
degree_max_2=4*average_degree_2;

N=10^4;
epsilon=10^-3;

%%

%% Initialization

P_k=zeros(numel(degree_min_1:degree_max_1),numel(degree_min_2:degree_max_2));
for x2=1:numel(degree_min_1:degree_max_1)
    for y2=1:numel(degree_min_2:degree_max_2)
        P_k(x2,y2)=average_degree_1^(degree_min_1+x2-1)*exp(-average_degree_1)/factorial(degree_min_1+x2-1)...
            *average_degree_2^(degree_min_2+y2-1)*exp(-average_degree_2)/factorial(degree_min_2+y2-1);
    end
end
P_k=P_k./sum(sum(P_k));

seq1=zeros(numel(0:degree_max_1),1);
for t=1:numel(seq1)
    seq1(t)=t;
end
seq_cum_1=cumsum(seq1);
seq2=zeros(numel(0:degree_max_2),1);
for t=1:numel(seq2)
    seq2(t)=t;
end
seq_cum_2=cumsum(seq2);

index_set_s1=zeros(sum(seq1),1);
index_set_i1=zeros(sum(seq1),1);
index_set_s2=zeros(sum(seq2),1);
index_set_i2=zeros(sum(seq2),1);
for i=1:numel(seq1)
    for j=1:seq1(i)
        index_set_s1(sum(seq1(1:i-1))+j)=i-1-j+1;
        index_set_i1(sum(seq1(1:i-1))+j)=j-1;
    end
end
for i=1:numel(seq2)
    for j=1:seq2(i)
        index_set_s2(sum(seq2(1:i-1))+j)=i-1-j+1;
        index_set_i2(sum(seq2(1:i-1))+j)=j-1;
    end
end

index_set_1=zeros(sum(seq1),sum(seq2));
index_set_2=zeros(sum(seq1),sum(seq2));
index_set_3=zeros(sum(seq1),sum(seq2));
index_set_4=zeros(sum(seq1),sum(seq2));
for j=1:sum(seq1)
    index_set_1(j,:)=index_set_s1(j);
    index_set_3(j,:)=index_set_i1(j);
end
for j=1:sum(seq2)
    index_set_2(:,j)=index_set_s2(j);
    index_set_4(:,j)=index_set_i2(j);
end

%%

S_Y_set_0=cell(numel(lambda),1);
I_set_0=cell(numel(lambda),1);
R_set_0=cell(numel(lambda),1);
total_R_set_0=zeros(numel(lambda),1);
V_set_0=cell(numel(lambda),1);
total_V_set_0=zeros(numel(lambda),1);

%% Numerical simulations

for m=1:numel(lambda)
    lambda0=lambda(m)
    Model
    S_Y_set_0{m}=S_Y;
    I_set_0{m}=I;
    R_set_0{m}=R;
    total_R_set_0(m)=R(step+1);
    V_set_0{m}=V;
    total_V_set_0(m)=V(step);
end

%%

save('dataN62_new_2.mat','lambda','gamma','alpha','beta','eta','average_degree_1','average_degree_2','N',...
    'S_Y_set_0','I_set_0','R_set_0','total_R_set_0','V_set_0','total_V_set_0')

toc
