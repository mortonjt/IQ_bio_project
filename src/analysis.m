
wells = 'BCDEFG';

for i=1:6
    figure(i)
    hold all;
    load(sprintf('results/%s_results.mat',wells(i)));
    size(ratio_mat)
    for w=1:10 %iterate over all well concentrations
        plot(ratio_mat(w,:));
    end
    title(sprintf('well %s',wells(i)))
    legend('plot1','plot2','plot3','plot4','plot5','plot6','plot7','plot8','plot9','plot10');
    savefig(sprintf('well_%s.fig',wells(i)))
    
    figure(i+6)
    %Look only at the wells without inhibitor
    hold all;
    for s=1:4
        plot(squeeze(raw_ratio_mat(1,s,2:23)));
    end
    savefig(sprintf('egf_%s.fig',wells(i)))
    
end