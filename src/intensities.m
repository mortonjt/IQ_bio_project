%%For a set of images return a vector of intensities
%%
%% TODO: Multiply masks together
%%       Make sure same pixels in both images are analyzed
function ratios = intensities(fret_im_files,cfp_im_files,empty_im_file,site)
    % im_files - array of image filenames
    % empty_im_file - empty file name
    n = length(fret_im_files);
    ratios = zeros(1,n);
    empty_im = imread(fullfile(empty_im_file));
    empty_im2 = imopen(empty_im,strel('disk',5));
    empty_back=uint16(empty_im2);
    parfor i=1:n
        [fret_seg_im,fret_mask] = segment_cells(empty_back,fret_im_files{i},site,'fret');
        [cfp_seg_im,cfp_mask] = segment_cells(empty_back,cfp_im_files{i},site,'cfp');
        fret_seg_im = fret_seg_im.*cfp_mask;
        cfp_seg_im = cfp_seg_im.*cfp_mask;
        ratio_im=double(fret_seg_im)./double(cfp_seg_im);
        ratio_im(isnan(ratio_im)==1)=0;
        %ints(i) = sum(sum(seg_im))/nnz(seg_im);
        ratios(i) = sum(sum(ratio_im))/nnz(ratio_im);
        
    end
end

