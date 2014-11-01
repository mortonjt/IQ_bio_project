function [IC50,ci] = calculateIC50(empty_dir,dirname,dt)
  ef = dir(empty_dir);
  f = dir(dirname);
  empty_fret_files = regexpi({ef.name},'site 1 wavelength 1.*tif','match');
  empty_fret_files = [empty_fret_files{:}];
  empty_cfp_files = regexpi({ef.name},'site 1 wavelength 2.*tif','match');
  empty_cfp_files = [empty_cfp_files{:}];

  fret_im_files1 = regexpi({f.name},'site 1 wavelength 1.*tif','match');
  fret_im_files1 = [fret_im_files1{:}];
  cfp_im_files1 = regexpi({f.name},'site 1 wavelength 2.*tif','match');
  cfp_im_files1 = [cfp_im_files1{:}];

  fret_im_files2 = regexpi({f.name},'site 2 wavelength 1.*tif','match');
  cfp_im_files2 = regexpi({f.name},'site 2 wavelength 2.*tif','match');
  fret_im_files2 = [fret_im_files2{:}];
  cfp_im_files2 = [cfp_im_files2{:}];

  fret_im_files3 = regexpi({f.name},'site 3 wavelength 1.*tif','match');
  cfp_im_files3 = regexpi({f.name},'site 3 wavelength 2.*tif','match');
  fret_im_files3 = [fret_im_files3{:}];
  cfp_im_files3 = [cfp_im_files3{:}];
  
  fret_im_files4 = regexpi({f.name},'site 4 wavelength 1.*tif','match');
  cfp_im_files4 = regexpi({f.name},'site 4 wavelength 2.*tif','match');
  fret_im_files4 = [fret_im_files4{:}];
  cfp_im_files4 = [cfp_im_files4{:}];

  frets1 = intensities(dirname,fret_im_files1,empty_fret_files);
  cfp1 = intensities(dirname,cfp_im_files1,empty_cfp_files);
 
  frets2 = intensities(dirname,fret_im_files2,empty_fret_files);
  cfp2 = intensities(dirname,cfp_im_files2,empty_cfp_files);
 
  frets3 = intensities(dirname,fret_im_files3,empty_fret_files);
  cfp3 = intensities(dirname,cfp_im_files3,empty_cfp_files);

  frets4 = intensities(dirname,fret_im_files4,empty_fret_files);
  cfp4 = intensities(dirname,cfp_im_files4,empty_cfp_files);
  
  well1_ratio = frets1./cfp1;
  well2_ratio = frets2./cfp2;
  well3_ratio = frets3./cfp3;
  well4_ratio = frets4./cfp4;
  
  ratios = [well1_ratio;well2_ratio;well3_ratio;well4_ratio];
  mratios = mean(ratios,1);
  top = max(mratios);
  bot = min(mratios);
  mratios = (mratios-bot)/(top-bot);
  top = max(max(ratios));
  bot = min(min(ratios));
  ratios = (ratios-bot)/(top-bot);
  egf = dt*(0:length(empty_fret_files)-1);
    

  nlr = @(p,x)[1./(1+x./p(1))];
  [IC50,r,J,cov,mse] = nlinfit(egf,mratios, nlr,[10]);
  
  e = std(ratios).*ones(size(mratios));
  fratios = nlr(IC50,egf);
  C = corrcoef(mratios,fratios);
  rsq1 = C(1,2)^2;
  rsq2 = 1 - sum(r.^2) / sum((fratios - mean(mratios)).^2);   
  ci = nlparci(IC50,r,'Jacobian',J);
   
end
