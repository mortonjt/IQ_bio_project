%MCMC
clear,clc
addpath ../eric

k = 1.38e-23; %Boltzmann constant

%Load model values
numWalkers = 10;
numIterations = 10;
numParams = 56;
params = zeros(numWalkers,numParams);
best_params = zeros(numWalkers,numParams);
scores = zeros(numWalkers);
params(1,:) = xlsread('../../params/simplified values.xlsx','Values2','I2:I57');

conc = zeros(numWalkers,6,10);
%global conc conc2
conc(1,1,:)=xlsread('../../params/Inhib Values.xlsx','0hr','B2:K2');
conc(1,2,:)=xlsread('../../params/Inhib Values.xlsx','0hr','M2:V2');
conc(1,3,:)=xlsread('../../params/Inhib Values.xlsx','0hr','X2:AG2');
conc(1,4,:)=xlsread('../../params/Inhib Values.xlsx','0hr','AI2:AR2');
conc(1,5,:)=xlsread('../../params/Inhib Values.xlsx','0hr','AT2:BC2');
conc(1,6,:)=xlsread('../../params/Inhib Values.xlsx','0hr','BE2:BN2');
conc2 = zeros(numWalkers,6);
equ_fract=.21;
egf_fract=.48;

%%Create copies for each walker
for walker = 2:numWalkers
    params(walker,:) = params(1,:);
    conc(walker,:,:) = conc(1,:,:);
    conc2(walker,:)= squeeze(conc(walker,:,1));
end
initial_conditions=xlsread('../../params/simplified values.xlsx','Values2','E2:E26');
%conc2=conc(:,1);
ERKt=initial_conditions(11)+initial_conditions(12);

opts=optimset('Display','iter','MaxFunEvals',1e3,'MaxIter',5e2);
fract=[equ_fract; egf_fract];
EGF_conc=[0; 100];%in Molar
tf=[600 700 800];
inhib=[1,1];
conc2(inhib(1))=inhib(2);

time_course = 0:801;
tp=1;te=500;
%r2 = func3_fmin(params,initial_conditions,EGF_conc,inhib,time_course,te,tp,fract,tf,conc, conc2);
%res=fminsearch(@(params) func3_fmin(params,initial_conditions,EGF_conc,inhib,time_course,te,tp,fract,tf),params,opts);

%%Run Monte Carlo Markov Chain algorithm (Metropolis Hastings algorithm)
%%http://en.wikipedia.org/wiki/Metropolis%E2%80%93Hastings_algorithm
%%Also known as simulated annealing
parfor walker = 1:numWalkers
    %Now generate a random walk
    walker
    c = squeeze(conc(walker,:,:));
    c2 = squeeze(conc2(walker,:));
    [p, r2] = simulannealbnd(@(p) func3_fmin(p,initial_conditions,EGF_conc,inhib,time_course,te,tp,fract,tf,c,c2), ...
                                  params(walker,:),0,Inf);
    scores(walker) = r2;
    best_params(walker,:) = p;
end
save('../../results/optimization_results.mat')






