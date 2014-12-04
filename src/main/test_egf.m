testdir='/Volumes/PASSPORT/IQBio/data/0hr';

egf = csvread('../params/egf.csv');
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
timepoint=1;


fret_im_files = getFiles(dirname,var_well,1,timepoint);
cfp_im_files = getFiles(dirname,var_well,2,timepoint);

empty_fret_files = getEmptyFiles(dirname,empty_well,1,timepoint);
empty_cfp_files = getEmptyFiles(dirname,empty_well,2,timepoint);
well1_ratio = intensities(fret_im_files(1,:),cfp_im_files(1,:),empty_fret_files{1},'site_1');
well2_ratio = intensities(fret_im_files(2,:),cfp_im_files(2,:),empty_fret_files{2},'site_2');
well3_ratio = intensities(fret_im_files(3,:),cfp_im_files(3,:),empty_fret_files{3},'site_3');
well4_ratio = intensities(fret_im_files(4,:),cfp_im_files(4,:),empty_fret_files{4},'site_4');

raw_ratios = [well1_ratio; well2_ratio; well3_ratio; well4_ratio];
mratios = mean(raw_ratios,1);
top = max(mratios);
bot = min(mratios);
mratios = (mratios-bot)/(top-bot);
top = max(max(raw_ratios));
bot = min(min(raw_ratios));
ratios = (raw_ratios-bot)/(top-bot);

t=1;
%for t=1:23
%[mratios,errs,raw_ratios,IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,t,egf);
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


