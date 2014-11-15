
%testdir='/data2/IQBIO2014/Inhibitor Timecourses/0hr';
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
var_well='G';
numWells=10;
numSites=4;
numTimePoints=23;
egf=G_egf;
raw_ratio_mat = zeros(numSites,numWells,numTimePoints);
ratio_mat = zeros(numWells,numTimePoints); %ratio image
err_mat = zeros(numWells,numTimePoints); %error matrix
emptys = zeros(1,numTimePoints); %Empty inhibitor values
IC50s = zeros(1,numTimePoints); %IC50 values
CIs = zeros(2,numTimePoints); %Confidence Intervals
Rsqs = zeros(1,numTimePoints);%R squares
parfor t=1:numTimePoints
    
  [mratios,errs,raw_ratios,IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,t,egf);
  
  IC50s(t)=IC50;
  CIs(:,t)=ci;
  Rsqs(t)=rsq2;
  raw_ratio_mat(:,:,t) = raw_ratios;
  ratio_mat(:,t) = mratios;
  err_mat(:,t) = errs;
end

figure()
%Look only at the wells without inhibitor
hold all;
for s=1:4
    plot(squeeze(raw_ratio_mat(1,s,1:23)));
end
savefig(sprintf('egf_%s.fig',var_well))

save('results.mat')
