%%analyze_opt.m
clear,clc

colors = [255 0 0; 
          255 128 0; 
          255 255 0; 
          128 255 0; 
          0 255 0; 
          0 255 128; 
          0 255 255;
          0 128 255;
          0 0   255;
          128 0 255];

addpath ../eric

load('../../results/fmin_opt/fmin_optimization_results.mat');

erk(1,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','B3:K26');   % GM6001
erk(2,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','M3:V26');   % BMS
erk(3,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','X3:AG26');  % Gefitinib
erk(4,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','AI3:AR26'); % ZM33
erk(5,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','AT3:BC26'); % CI-1040
erk(6,:,:)=xlsread('../../params/Inhib Values.xlsx','0hr','BE3:BN26'); % SCH7
time = xlsread('../../params/Inhib Values.xlsx','0hr','A3:A26'); 

time_course_eq = 0:1:300;
tp_eq=1;te_eq=1;

[~, y_equilib, conc, conc2]=func2_TimeCourse(params,initial_conditions,0,[1,1], ...
                                             time_course_eq,te_eq,tp_eq,conc,conc2);
initial_conditions2=y_equilib(end,:);


num_points=numel(tf);
egf_concs = squeeze(conc2(1,:,:));

num_ep=numel(EGF_conc); %Number of experiments
[tLen, n_rxns] = size(y_equilib);
[n_inh,n_concs] = size(egf_concs); %number of inhibitors and number of concentrations

ERK = zeros(n_concs,1);
aERK = zeros(n_concs,1);
simERK = zeros(n_inh, tLen);
inhib=[1,1]; %inhibitor addition (wtf?)


%Plot each inhibitor
for inh=1:n_inh
    figure()
    hold all;
    subplot(211)
    hold on;    
    %Loop over all concentrations (aka wells)
    for w=1:n_concs
        realERK = squeeze(erk(inh,:,w));
        realT = linspace(time(1),time(end),length(realERK));
        plot(realT,realERK,'Color',colors(w,:)/255);
        title('Actual ERK activity')
    end
    subplot(212)
    hold on;    
    for w=1:n_concs
        [t, y_vals, c, c2]=func2_TimeCourse(best_params,initial_conditions2,...
                                            egf_concs(inh,w), ...   
                                            inhib, ...                       
                                            time_course_eq,te_eq,tp_eq,conc, conc2);
        aERK=y_vals(:,11);
        ERK=y_vals(:,12);
        aERK_t=aERK;
        ERK_t=ERK;
        simERK=aERK_t./(aERK_t+ERK_t);
        simT = linspace(time(1),time(end),length(simERK));
        subplot(212)
        plot(simT,simERK,'Color',colors(w,:)/255);
        title('Predicted ERK activity')
   end
end

                                         
                                         
                                         
                                         
                                         
                                         