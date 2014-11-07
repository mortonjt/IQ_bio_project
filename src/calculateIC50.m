%Calculate the IC50 for a specified timepoint
function [mratios,errs,raw_ratios,IC50,ci,rsq2] = calculateIC50(dirname,empty_well,var_well,timepoint,egf)

    fret_im_files = getFiles(dirname,var_well,1,timepoint);
    cfp_im_files = getFiles(dirname,var_well,2,timepoint);
    %empty_fret_files = getEmptyFiles(dirname,empty_well,1,timepoint);
    empty_cfp_files = getEmptyFiles(dirname,empty_well,2,timepoint);

    well1_ratio = intensities(fret_im_files(1,:),cfp_im_files(1,:),empty_cfp_files{1});
    well2_ratio = intensities(fret_im_files(2,:),cfp_im_files(2,:),empty_cfp_files{1});
    well3_ratio = intensities(fret_im_files(3,:),cfp_im_files(3,:),empty_cfp_files{1});
    well4_ratio = intensities(fret_im_files(4,:),cfp_im_files(4,:),empty_cfp_files{1});

    raw_ratios = [well1_ratio; well2_ratio; well3_ratio; well4_ratio];
    mratios = mean(raw_ratios,1);
    top = max(mratios);
    bot = min(mratios);
    mratios = (mratios-bot)/(top-bot);
    top = max(max(raw_ratios));
    bot = min(min(raw_ratios));
    ratios = (raw_ratios-bot)/(top-bot);

    nlr = @(p,x)[1./(1+x./p(1))];
    %% TODO: Give starting point based on data
    %%       Careful about normalizing
    [IC50,r,J,cov,mse] = nlinfit(egf,mratios, nlr,[mean(egf)]);

    errs = std(ratios).*ones(size(mratios));
    fratios = nlr(IC50,egf);
    C = corrcoef(mratios,fratios);
    rsq1 = C(1,2)^2;
    rsq2 = 1 - sum(r.^2) / sum((fratios - mean(mratios)).^2);   
    ci = nlparci(IC50,r,'Jacobian',J);

end