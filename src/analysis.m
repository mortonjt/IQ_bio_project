
wells = 'BCDEFG';
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
egf = csvread('../params/egf.csv');
B_egf=egf(1,:);
C_egf=egf(2,:);
D_egf=egf(3,:);
E_egf=egf(4,:);
F_egf=egf(5,:);
G_egf=egf(6,:);
n=23;
t = 0:16.3:16.3*(n-1);
for i=1:6
    f=figure(i)
    hold all;
    load(sprintf('../results/0hr/%s_results.mat',wells(i)));
    size(ratio_mat)
    for w=1:10 %iterate over all well concentrations
        raw_means = squeeze(mean(raw_ratio_mat(:,w,:),1));
        plot(t,raw_means,'Color',colors(w,:)/255);
    end
    title(sprintf('well %s',wells(i)))
    ylabel('Intensity')
    xlabel('Time (seconds)')
    legend(num2str(egf(i,:)));
    legend(strtrim(cellstr(num2str(egf(i,:)'))'))
    %savefig(sprintf('well_%s.fig',wells(i)))
    saveas(f,sprintf('well_%s.png',wells(i)))
    f=figure(i+6)
    %Look only at the wells without inhibitor
    hold all;
    for s=1:4
        plot(t,squeeze(raw_ratio_mat(s,1,:)));
    end
    title(sprintf('well %s',wells(i)))
    ylabel('Intensity')
    xlabel('Time (seconds)')
    
    %savefig(sprintf('egf_%s.fig',wells(i)))
    saveas(f,sprintf('egf_%s.png',wells(i)))
    
end