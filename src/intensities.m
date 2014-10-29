%%For a set of images return a vector of intensities
function ints = intensities(dirname,im_files,empty_im_file)
    % dirname - directory name
    % im_files - array of image filenames
    % empty_im_file - empty file name
    n = length(im_files);
    ints = zeros(1,n);
    empty_im = imread(fullfile(dirname,empty_im_file));
    empty_im2 = imopen(empty_im,strel('disk',5));
    empty_back=uint16(empty_im2);
    for i=1:n
        im = imread(fullfile(dirname,im_files{i}));
        seg_im = segment_cells(im,empty_back,im_files{i});
        ints(i) = sum(sum(seg_im))/nnz(seg_im);
    end
end

