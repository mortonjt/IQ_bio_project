
%% segment all of the cells
function [processed_im,total_mask] = segment_cells(empty_im,imname)
    % imname - name of image
    % empty_im - empty image
    im=imread(fullfile(imname));
    im2=uint16(double(im)./double(empty_im)*mean(mean(empty_im)));
    
    %Background correction
    imsort=sort(reshape(im2,1,numel(im2)));
    background=.75;
    imb=mean(imsort(1:numel(imsort)*background));
    im3=im2-imb;
    
    %Calculate background intensity
    %v = reshape(im2,[1,numel(im2)]);
    %bkg = prctile(v,[99.5]);
    bkg = 750;
    im3(im3<bkg)=0;
    im4=im3;
    bw=im2bw(im4,0);
    bw2=bwareaopen(bw,5);
    cc = bwconncomp(im4);  
    im4(bw2==0)=0;
    processed_im = im4;
    total_mask = uint16(zeros(size(im3)));
    im5 = uint16(zeros(size(im)));
    for cell = 1:cc.NumObjects        
        bwc=zeros(size(im3));
        bwc(cc.PixelIdxList{cell})=1;
        mask = uint16(bwc);
        tmpim = im4.*mask;
        %figure
        %imshow(imcomplement(tmpim));
        if(nnz(tmpim)>10)
            total_mask = total_mask+mask;
        end
    end
    [pathstr,name,ext] = fileparts(imname);
    [pathstr,well,ext] = fileparts(pathstr);

    imwrite(imcomplement(empty_im),sprintf('images/%s_%s_empty.tif',well,name));
    imwrite(imcomplement(im),sprintf('images/%s_%s_im1.tif',well,name));
    imwrite(imcomplement(im2),sprintf('images/%s_%s_im2.tif',well,name));
    imwrite(imcomplement(im3),sprintf('images/%s_%s_im3.tif',well,name));
    imwrite(imcomplement(im4),sprintf('images/%s_%s_im4.tif',well,name));
    imwrite(imcomplement(im5),sprintf('images/%s_%s_im5.tif',well,name));
%     imshow(imcomplement(im));
%     figure
%     imshow(imcomplement(im2));
%     figure
%     imshow(imcomplement(im3));
%     figure
%     imshow(imcomplement(im4));
%     figure
%     imshow(imcomplement(im5));
end
