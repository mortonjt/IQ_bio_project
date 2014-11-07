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

for t=1:23
  [mratios,errs,IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,t,egf);
end
