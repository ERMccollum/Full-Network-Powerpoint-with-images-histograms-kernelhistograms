% m = load_nii('inputlayer_mask.nii.gz');
mask1 = niftiread('inputlayer_mask.nii.gz');

maxpoolmask2 = sepblockfun(mask1, [2,2,2], 'max');
secondmasknii = make_nii(maxpoolmask2, [],[],[], 'maxpool');
save_nii(secondmasknii, 'secondmask.nii');


maxpoolmask3 = sepblockfun(maxpoolmask2, [2,2,2], 'max');
thirdmasknii = make_nii(maxpoolmask3, [],[],[], 'maxpool');
save_nii(thirdmasknii, 'thirdmask.nii');


maxpoolmask4 = sepblockfun(maxpoolmask3, [2,2,2], 'max');
fourthmasknii = make_nii(maxpoolmask4, [],[],[], 'maxpool');
save_nii(fourthmasknii, 'fourthmask.nii');

