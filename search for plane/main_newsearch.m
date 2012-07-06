%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%											%
%	IMAGE COMMUNICATION - EPFL COURSE		%
%				June 2012					%
%		Inpaiting of depth image			%
%											%
% Yannik Messerli: yannik.messerli@epfl.ch	%
% 	Nicolas Jorns: nicolas.jorns@epfl.ch	%
%											%
% 		Supervised by Thomas Maugey			%
%											%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;
addpath('../estimation');


patch_size = 5;

% Estimation done. Load it:
mask = im2double(imread('mask.png'));
imholes = zeros(size(mask));
im = im2double(imread('result.png'));
[nCol nRow] = size(im);

pointToFill = find(mask > 0);

for i=1:length(pointToFill)
	Hp = getpatch([nCol nRow], pointToFill(i), patch_size);
	Hp = Hp( mask(Hp) < 1 );
	if length(Hp) > (patch_size^2)*0.9
		im(pointToFill(i)) = mean(im(Hp));
	else
		imholes(pointToFill(i)) = 1.0;
	end
end
%figure; imshow(im);
imfinal = im;
[components nbComp] = bwlabeln(imholes);
find_region_all(im, imholes);
 %for j = 1:nbComp;
 %	cord_points_region = find(components == j);
% 	mask = ones(size(im));
 %	mask(cord_points_region) = 0.0;
 %	fillRegion = ~mask;
 %	
 %	find_region_all(im, fillRegion);
%end