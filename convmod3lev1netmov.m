%convolution mod 3 lev 1
% exportToPPTX('saveandclose', 'convmod1lev2netmov')

exportToPPTX('saveandclose', 'convmod3lev1netmov');

exportToPPTX('new')

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.nii')); %gets all txt files in struct
for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  num = niftiread(fullFileName);   %or readtable
  % all of your actions for filtering and plotting go here
  mask = niftiread('thirdmask.nii');
  niiimage = load_nii(fullFileName);
  
  figure(1)

  h = histogram(num(mask==1), 32);

  plot(conv(h.BinEdges, [0.5 0.5], 'valid'), h.BinCounts)
     title(strcat ('Convolution Module 3 Level 1 Channel', " ", num2str(k)));
  xlabel('Intensity')
  ylabel('Number of Pixels')
  xlim([-30,20]);
  ylim([0, 16000]);
  
  
  
  holder_img1 = fliplr(imrotate(squeeze(niiimage.img(:,:,17)),90)); 
  figure(2)  
  imagesc(imrotate(holder_img1,180));
  colormap gray;
  title(strcat('Layer 13 Convolution Module 3 Level 1 Image Channel', " ", num2str(k) ));
colorbar;
 

  kernels = net.Layers(13).Weights(:,:,:,:,k);
  figure(3)
  histogram(kernels, 32)
  title(strcat('Kernels for Channel' , " ", num2str(k)));
  xlabel('Kernel Values');
  ylabel('Frequency');

xlim([-.5,.5]);
  
  exportToPPTX('addslide')
  exportToPPTX('addpicture', figure(2), 'Position', [0  2   3.33 3.33]);
  exportToPPTX('addpicture', figure(1), 'Position', [3.33  2   3.33 3.33]);
  exportToPPTX('addpicture', figure(3),'Position', [6.66  2   3.33 3.33]);
  
  

  
end
exportToPPTX('saveandclose', 'convmod3lev1netmov');