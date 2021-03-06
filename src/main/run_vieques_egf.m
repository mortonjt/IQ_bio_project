
testdir='/data2/IQBIO2014/Inhibitor Timecourses/0hr';

egf = csvread('../../egf.csv');
B_egf=egf(1,:);
C_egf=egf(2,:);
D_egf=egf(3,:);
E_egf=egf(4,:);
F_egf=egf(5,:);
G_egf=egf(6,:);
dirname=testdir;
empty_well='B';
var_wells='BCDEFG';
numWells=10;
numSites=4;
numTimePoints=23;
raw_ratio_mat = zeros(numSites,numWells,numTimePoints);
ratio_mat = zeros(numWells,numTimePoints); %ratio image
err_mat = zeros(numWells,numTimePoints); %error matrix
IC50s = zeros(1,numTimePoints); %IC50 values
CIs = zeros(2,numTimePoints); %Confidence Intervals
Rsqs = zeros(1,numTimePoints);%R squares
for i=1:6
   var_well=var_wells(i)
   well_egf=egf(i,:);
   parfor t=1:numTimePoints

     [mratios,errs,raw_ratios,IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,t,well_egf);
     IC50s(t)=IC50
     CIs(:,t)=ci;
     Rsqs(t)=rsq2;
     raw_ratio_mat(:,:,t) = raw_ratios;
     ratio_mat(:,t) = mratios;
     err_mat(:,t) = errs;
   end
   save(sprintf('../../results/0hr/%s_results.mat',var_well))
end

