function LBPhist = calculateLBP(scan, normalise)
% function LBPhist = calculateLBP(scan)
%
% Computes the Local Binary Pattern (LBP) descriptor of a NxNxDxT dynamic
% sequence, where NxN represents the size of each axial slice, D the number
% of number of axial slices, and T the number of time points.
%
% (C) J. Bernal, 2019

FxRadius = 1; 
FyRadius = 1;
TInterval = 1;
TimeLength = 1;
BorderLength = 1;
bBilinearInterpolation = 1;
Bincount = 59; %59 / 0
NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively

% uniform patterns for neighboring points with 8
U8File = importdata('UniformLBP8.txt');
% BinNum = U8File(1, 1);
% nDim = U8File(1, 2); %dimensionality of uniform patterns
Code = U8File(2 : end, :);
clear U8File;

LBPhist = zeros(timepoints, 59);
for t = 1:timepoints
    roi = scan(:, :, :, t);
    roi(roi == 0) = NaN;

    for slicej=1:size(roi, 3)
        % Do not consider empty slices
        if sum(sum(1-isnan(roi(:, :, slicej)))) == 0
            continue
        end
        
        % Call LBP function to calculate the LBP histogram per axial slice.
        % Download it from http://www.cse.oulu.fi/wsgi/CMV/Downloads
        LBPhist_tmp = double(LBP(roi(:, :, slicej), ...
            FxRadius, FyRadius, TInterval, NeighborPoints, TimeLength,...
            BorderLength, bBilinearInterpolation, Bincount, Code));
        
        LBPhist(t, :) = LBPhist(t, :) + LBPhist_tmp;
    end
    
    if normalise == 0
        LBPhist(t, :) = bsxfun(@rdivide, LBPhist(t, :), sqrt(sum(LBPhist(t, :).^2)));
    end
end