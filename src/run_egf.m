%Run on egf experiment
maindir = '/Users/jamo1880/Documents/IQ_bio_project2/test/data';

main = dir(dirname);


empty_fret_im_file = regexpi({f.name},'empty.*w1.*tif','match');
empty_fret_im_file = [empty_fret_im_file{:}];
empty_cfp_im_file = regexpi({f.name},'empty.*w2.*tif','match');
empty_cfp_im_file = [empty_cfp_im_file{:}];

%Separate fret and cfp files into B,C,D,E,F,G
B_fret_im_files = regexpi({f.name},'.*serum_B.*w1.*tif','match');
B_fret_im_files = [B_fret_im_files{:}];
C_fret_im_files = regexpi({f.name},'.*serum_C.*w1.*tif','match');
C_fret_im_files = [C_fret_im_files{:}];
D_fret_im_files = regexpi({f.name},'.*serum_D.*w1.*tif','match');
D_fret_im_files = [D_fret_im_files{:}];

B_cfp_im_files = regexpi({f.name},'.*serum_B.*w2.*tif','match');
B_cfp_im_files = [B_cfp_im_files{:}];
C_cfp_im_files = regexpi({f.name},'.*serum_C.*w2.*tif','match');
C_cfp_im_files = [C_cfp_im_files{:}];
D_cfp_im_files = regexpi({f.name},'.*serum_D.*w2.*tif','match');
D_cfp_im_files = [D_cfp_im_files{:}];


B_frets = intensities(dirname,B_fret_im_files,empty_fret_im_file{1});
C_frets = intensities(dirname,C_fret_im_files,empty_fret_im_file{1});
D_frets = intensities(dirname,D_fret_im_files,empty_fret_im_file{1});
B_cfp = intensities(dirname,B_cfp_im_files,empty_fret_im_file{1});
C_cfp = intensities(dirname,C_cfp_im_files,empty_fret_im_file{1});
D_cfp = intensities(dirname,D_cfp_im_files,empty_fret_im_file{1});
B_ratio = B_frets./B_cfp;
C_ratio = C_frets./C_cfp;
D_ratio = D_frets./D_cfp;
ratios = [B_ratio;C_ratio;D_ratio];
%ratios = ratios - min(min(ratios));
%ratios = ratios/max(max(ratios));

mratios = mean(ratios,1);
top = max(mratios);
bot = min(mratios);
mratios = (mratios-bot)/(top-bot);
top = max(max(ratios));
bot = min(min(ratios));
ratios = (ratios-bot)/(top-bot);

egf = [0, .128, .64, 3.2, 16, 80, 400, 2000, 10000, 50000];


figure
%y = linspace(min(egf),max(egf),100000);
y = logspace(-1,log10(max(egf)),1000);
nlr = @(p,x)[1./(1+p(1)./x)];
[EC50,r,J,cov,mse] = nlinfit(egf,mratios, nlr,[10]);
%EC50 = 1000;
fy = nlr(EC50,y);
e = std(ratios).*ones(size(mratios));
fratios = nlr(EC50,egf);
C = corrcoef(mratios,fratios);
rsq1 = C(1,2)^2;
rsq2 = 1 - sum(r.^2) / sum((fratios - mean(mratios)).^2);
EC50
ci = nlparci(EC50,r,'Jacobian',J)

hold all;
%semilogx(m,B_ratio,'ok',m,C_ratio,'og',m,D_ratio,'ob',m,mratios,'-r');
plot(y,fy,'-r');
errorbar(egf,mratios,e,'ob');
ax = gca;
set(ax,'XScale','log')
xlabel('[EGF] (pM)')
ylabel('Percent intensity')
title('Dose response of EGF concentration in the presence of FBS')


annotation('textbox',...
    [0.60 0.15 0.3 0.15],...
    'String',{'R^2 =',[num2str(rsq2)]},...
    'FontSize',14,...
    'FontName','Arial',...
    'LineStyle','--',...
    'EdgeColor',[1 1 0],...
    'LineWidth',2,...
    'BackgroundColor',[0.9  0.9 0.9],...
    'Color',[0.84 0.16 0]);




%Separate fret and cfp files into B,C,D,E,F,G
E_fret_im_files = regexpi({f.name},'.*serum_E.*w1.*tif','match');
E_fret_im_files = [E_fret_im_files{:}];
F_fret_im_files = regexpi({f.name},'.*serum_F.*w1.*tif','match');
F_fret_im_files = [F_fret_im_files{:}];
G_fret_im_files = regexpi({f.name},'.*serum_G.*w1.*tif','match');
G_fret_im_files = [G_fret_im_files{:}];

E_cfp_im_files = regexpi({f.name},'.*serum_E.*w2.*tif','match');
E_cfp_im_files = [E_cfp_im_files{:}];
F_cfp_im_files = regexpi({f.name},'.*serum_F.*w2.*tif','match');
F_cfp_im_files = [F_cfp_im_files{:}];
G_cfp_im_files = regexpi({f.name},'.*serum_G.*w2.*tif','match');
G_cfp_im_files = [G_cfp_im_files{:}];


E_frets = intensities(dirname,E_fret_im_files,empty_fret_im_file{1});
F_frets = intensities(dirname,F_fret_im_files,empty_fret_im_file{1});
G_frets = intensities(dirname,G_fret_im_files,empty_fret_im_file{1});
E_cfp = intensities(dirname,E_cfp_im_files,empty_fret_im_file{1});
F_cfp = intensities(dirname,F_cfp_im_files,empty_fret_im_file{1});
G_cfp = intensities(dirname,G_cfp_im_files,empty_fret_im_file{1});
E_ratio = E_frets./E_cfp;
F_ratio = F_frets./F_cfp;
G_ratio = G_frets./G_cfp;
ratios = [E_ratio;F_ratio;G_ratio];
%ratios = ratios - min(min(ratios));
%ratios = ratios/max(max(ratios));

mratios = mean(ratios,1);
top = max(mratios);
bot = min(mratios);
mratios = (mratios-bot)/(top-bot);
top = max(max(ratios));
bot = min(min(ratios));
ratios = (ratios-bot)/(top-bot);
figure
egf = [0, .128, .64, 3.2, 16, 80, 400, 2000, 10000, 50000];



%y = linspace(min(egf),max(egf),100000);
y = logspace(-1,log10(max(egf)),1000);
nlr = @(p,x)[1./(1+p(1)./x)];
[EC50,r,J,cov,mse] = nlinfit(egf,mratios, nlr,[10]);
%EC50 = 1000;
fy = nlr(EC50,y);
e = std(ratios).*ones(size(mratios));
fratios = nlr(EC50,egf);
C = corrcoef(mratios,fratios);
rsq1 = C(1,2)^2;
rsq2 = 1 - sum(r.^2) / sum((fratios - mean(mratios)).^2);
EC50
ci = nlparci(EC50,r,'Jacobian',J)

hold all;
%semilogx(m,B_ratio,'ok',m,C_ratio,'og',m,D_ratio,'ob',m,mratios,'-r');
plot(y,fy,'-r');
errorbar(egf,mratios,e,'ob');
ax = gca;
set(ax,'XScale','log')
xlabel('[EGF] (pM)')
ylabel('Percent intensity')
title('Dose response of EGF concentration without the presence of FBS')


annotation('textbox',...
    [0.15 0.65 0.3 0.15],...
    'String',{'R^2 =',[num2str(rsq2)]},...
    'FontSize',14,...
    'FontName','Arial',...
    'LineStyle','--',...
    'EdgeColor',[1 1 0],...
    'LineWidth',2,...
    'BackgroundColor',[0.9  0.9 0.9],...
    'Color',[0.84 0.16 0]);
