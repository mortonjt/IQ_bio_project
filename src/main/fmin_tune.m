%MCMC
clear,clc
addpath ../eric
addpath ../../
k = 1.38e-23; %Boltzmann constant

runNumber = 2

%Load model values
numWalkers = 1;
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

erk(1,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','B3:K26');   % GM6001
erk(2,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','M3:V26');   % BMS
erk(3,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','X3:AG26');  % Gefitinib
erk(4,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','AI3:AR26'); % ZM33
erk(5,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','AT3:BC26'); % CI-1040
erk(6,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','BE3:BN26'); % SCH7

%%Create copies for each walker
for walker = 2:numWalkers
    params(walker,:) = params(1,:)+(rand()-0.5)*params(1,:);
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


%Now generate a random walk
walker = 1
       
%inh=1: GM6001: 51
%inh=2: BMS: 52
%inh=3: Gefitinb: 53
%inh=4: ZM33: 54
%inh=5: CI-1040: 55
%inh=6: SCH7: 56
inh_idx = 50 %starting index for inhibitors in params

for inh = 1:6 %loop over all inhibitors
  
  c = squeeze(conc(walker,:,:));
  c2 = squeeze(conc2(walker,:));
  opts=optimset('Display','iter','MaxFunEvals',1e3,'MaxIter',5e2);

  for w = 1:10
     if w>1
        w_params = [params(walker,inh_idx+inh)]     % Initial parameter estimate
        idxs = [inh_idx+inh]                        % Indexes of parameters
     else
        w_params = [params(walker,1:inh_idx)]       % Initial parameter estimate
	idxs = [1:inh_idx]                          % Indexes of parameters
     end
     
     actual = erk(inh,w,:) %Actual values to calculate SSE
     [p, r2]= fminsearch(@(p) spec_fmin(params(walker,:),initial_conditions, ...
                                        EGF_conc,inhib,time_course, ...
                                        te,tp,fract,tf,c,c2,p,idxs,actual), ...
                         w_params,opts);
     p
     save(sprintf('../../results/fmin_%d_results_run_%d.mat',w,runNumber))
  end
end

save('../../results/fmin_optimization_results_%d.mat',runNumber)






