%softmax

exportToPPTX('saveandclose', 'softmaxnetmov');


exportToPPTX('new')
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.nii')); %gets all txt files in struct
for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  num = niftiread(fullFileName);   %or readtable
  % all of your actions for filtering and plotting go here
  mask = niftiread('inputlayer3dmask.nii.gz');
  niiimage = load_nii(fullFileName);
  
  figure(1)

  h = histogram(num, 32);

  plot(conv(h.BinEdges, [0.5 0.5], 'valid'), h.BinCounts)
     title(strcat ('Softmax Channel', " ", num2str(k)));
  xlabel('Intensity')
  ylabel('Number of Pixels')
%   xlim([-.5,90]);
%   ylim([0,2.5*10e5]);
  
    holder_img1 = fliplr(imrotate(squeeze(niiimage.img(:,:,65)),90)); 
  figure(2)  
  imagesc(imrotate(holder_img1,180));
  colormap gray;
  title(strcat('Layer 40 Softmax Image Output Channel', " ", num2str(k) ));
colorbar;


    
  exportToPPTX('addslide')
  exportToPPTX('addpicture', figure(2), 'Position', [0  2   5 5]);
  exportToPPTX('addpicture', figure(1), 'Position', [5  2   5 5]);
  
  
end

exportToPPTX('saveandclose', 'softmaxnetmov');