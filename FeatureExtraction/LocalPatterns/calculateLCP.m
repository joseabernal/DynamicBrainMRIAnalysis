function LCPhist = calculateLCP(scan, normalise)
% function LCPhist = calculateLCP(scan, normalise)
%
% Computes the Local Phase Quantization (LPQ) descriptor of a NxNxDxT
% dynamic sequence, where NxN represents the size of each axial slice, D
% the number of axial slices, and T the number of time points.
%
% (C) J. Bernal, 2019

mapping=getmapping(8,'riu2');

LCPhist = zeros(timepoints, 81);
for t = 1:timepoints
    roi = scan(:, :, :, t);
    roi(roi == 0) = NaN;

    for slicej=1:size(roi, 3)
        % Do not consider empty slices
        if sum(sum(1-isnan(roi(:, :, slicej)))) == 0
            continue
        end
        
        % Call LBP function to calculate the LPQ histogram per axial slice.
        % Download it from http://www.cse.oulu.fi/wsgi/CMV/Downloads
        LCPhist_tmp = double(LCP(roi(:, :, slicej), 1, 8, mapping, 'i'))';
        LCPhist(t, :) = LCPhist(t, :) + LCPhist_tmp;
    end
    
    if normalise == 0
        LCPhist(t, :) = bsxfun(@rdivide, LCPhist(t, :), sqrt(sum(LCPhist(t, :).^2)));
    end
end