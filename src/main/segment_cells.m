
%% segment all of the cells
function [processed_im,total_mask] = segment_cells(empty_im,imname,site,wavelength)
    % imname - name of image
    % empty_im - empty image
    % site - site name
    % wavelength - wavelength (fret or cfp)
    % processed_im - processed image
    % total_mask - image mask for processed image
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
    bkg = 500;
    im3(im3<bkg)=0;
    im4=im3;
    bw=im2bw(im4,0);
    bw2=bwareaopen(bw,5);
    %cc = bwconncomp(im4);  
    im4(bw2==0)=0;
    processed_im = im4;
    total_mask = uint16(bw2);
    %total_mask = uint16(zeros(size(im3)));
    %im5 = uint16(zeros(size(im)));
%     for cell = 1:cc.NumObjects        
%         bwc=zeros(size(im3));
%         bwc(cc.PixelIdxList{cell})=1;
%         mask = uint16(bwc);
%         tmpim = im4.*mask;
%         %figure
%         %imshow(imcomplement(tmpim));
%         if(nnz(tmpim)>10)
%             im5 = im5+tmpim;
%             total_mask = total_mask+mask;
%         end
%     end
%     [pathstr,name,ext] = fileparts(imname);
%     [pathstr,well,ext] = fileparts(pathstr);
%     
%     imwrite(empty_im,sprintf('images/%s_%s/empty/%s_%s.tif',site,wavelength,well,name));
%     imwrite(im,sprintf('images/%s_%s/im1/%s_%s.tif',site,wavelength,well,name));
%     imwrite(im2,sprintf('images/%s_%s/im2/%s_%s.tif',site,wavelength,well,name));
%     imwrite(im3,sprintf('images/%s_%s/im3/%s_%s.tif',site,wavelength,well,name));
%     imwrite(im4,sprintf('images/%s_%s/im4/%s_%s.tif',site,wavelength,well,name));
    %imwrite(im5,sprintf('images/%s_%s/im5/%s_%s.tif',site,wavelength,well,name));

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
