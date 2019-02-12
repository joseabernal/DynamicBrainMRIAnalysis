function LBPTOPhist = calculateLBPTOP(scan, normalise)
% function LBPTOPhist = calculateLBPTOP(scan)
%
% Computes the Local Binary Patterns in the Three Orthogonal Planes
% (LBPTOP)  descriptor of a NxNxDxT dynamic sequence, where NxN represents
% the size of each axial slice, D the number of axial slices, and T the
% number of time points.
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

LBPTOPhist = zeros(timepoints, 3*59);
for t = 1:timepoints
    roi = scan(:, :, :, t);
    roi(roi == 0) = NaN;

    % Call LBP function to calculate the LBPTOP histogram per axial slice.
    % Download it from http://www.cse.oulu.fi/wsgi/CMV/Downloads
    LBPTOPhist_tmp = LBPTOP(roi, FxRadius, FyRadius, TInterval,...
        NeighborPoints, TimeLength, BorderLength, bBilinearInterpolation, ...
        Bincount, Code);
    
    LBPTOPhist(t, :) = LBPTOPhist_tmp(:);
    
    if normalise == 0
        LBPTOPhist(t, :) = bsxfun(@rdivide, LBPTOPhist(t, :), sqrt(sum(LBPTOPhist(t, :).^2)));
    end
end