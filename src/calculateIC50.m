%Calculate the IC50 for a specified timepoint
function [IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,timepoint,egf)

  ef = dir(empty_well);
  f = dir(dirname);
  empty_fret_files = regexpi({ef.name},'site 1 wavelength 1.*tif','match');
  empty_fret_files = [empty_fret_files{:}];
  empty_cfp_files = regexpi({ef.name},'site 1 wavelength 2.*tif','match');
  empty_cfp_files = [empty_cfp_files{:}];

  fret_im_files = getFiles(dirname,var_well,1,timepoint);
  cfp_im_files = getFiles(dirname,var_well,2,timepoint);
  empty_fret_files = getEmptyFiles(dirname,empty_well,1,timepoint);
  empty_cfp_files = getEmptyFiles(dirname,empty_well,2,timepoint);

  frets1 = intensities(fret_im_files(1,:),empty_fret_files{1});
  cfp1 = intensities(cfp_im_files(1,:),empty_cfp_files{1});
 
  frets2 = intensities(fret_im_files(2,:),empty_fret_files{1});
  cfp2 = intensities(cfp_im_files(2,:),empty_cfp_files{1});
 
  frets3 = intensities(fret_im_files(3,:),empty_fret_files{1});
  cfp3 = intensities(cfp_im_files(3,:),empty_cfp_files{1});

  frets4 = intensities(fret_im_files(4,:),empty_fret_files{1});
  cfp4 = intensities(cfp_im_files(4,:),empty_cfp_files{1});
  
  well1_ratio = frets1./cfp1;
  well2_ratio = frets2./cfp2;
  well3_ratio = frets3./cfp3;
  well4_ratio = frets4./cfp4;
  
  ratios = [well1_ratio; well2_ratio; well3_ratio; well4_ratio];
  mratios = mean(ratios,1);
  top = max(mratios);
  bot = min(mratios);
  mratios = (mratios-bot)/(top-bot);
  top = max(max(ratios));
  bot = min(min(ratios));
  ratios = (ratios-bot)/(top-bot);
    

  nlr = @(p,x)[1./(1+x./p(1))];
  [IC50,r,J,cov,mse] = nlinfit(egf,mratios, nlr,[10]);
  
  e = std(ratios).*ones(size(mratios));
  fratios = nlr(IC50,egf);
  C = corrcoef(mratios,fratios);
  rsq1 = C(1,2)^2;
  rsq2 = 1 - sum(r.^2) / sum((fratios - mean(mratios)).^2);   
  ci = nlparci(IC50,r,'Jacobian',J);
   
end
