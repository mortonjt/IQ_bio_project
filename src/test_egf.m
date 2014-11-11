testdir='/Volumes/PASSPORT/IQBio/data/0hr';

egf = csvread('../egf.csv');
B_egf=egf(1,:);
C_egf=egf(2,:);
D_egf=egf(3,:);
E_egf=egf(4,:);
F_egf=egf(5,:);
G_egf=egf(6,:);
dirname=testdir;
empty_well='B';
var_well='B';

egf=B_egf;
t=23;
%for t=1:23
[mratios,errs,raw_ratios,empty_ratio,IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,t,egf);
%end

% y = logspace(-1,log10(max(egf)),1000);
% nlr = @(p,x)[1./(1+x./p(1))];
% [IC50,r,J,cov,mse] = nlinfit(egf,mratios, nlr,[mean(egf)]);
% fy = nlr(IC50,y);
% plot(y,fy,'-r');
% errorbar(egf,mratios,errs,'ob');
% ax = gca;
% set(ax,'XScale','log')
% xlabel('[EGF] (pM)')
% ylabel('Percent intensity')
% title('Dose response of EGF concentration without the presence of FBS')

%%Todo
%% 1) Look at the value of activity of different inhibitor concentrations 
%%    over time (e.g ratio values).  This correlates with ERK activity. 
%%    Only 1 EGF concentration.
%% 2) Heatmap of inhibitor concentrations over EGF concentration
%% 3) Look at time graphs wrt activity for each inhibitor concentration
%% Some of the inhibitors have a dip in time


