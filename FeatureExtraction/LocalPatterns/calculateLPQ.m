function LPQhist = calculateLPQ(scan, normalise)
% function LPQhist = calculateLPQ(scan, normalise)
%
% Computes the LPQ descriptor of a NxNxDxT dynamic sequence. Where
% NxN represents the size of each axial slice, D the number of axial
% slices, and T the number of time points.
%
% (C) J. Bernal, 2019

mapping=getmapping(8,'riu2');

LPQhist = zeros(timepoints, 256);
for t = 1:timepoints
    roi = scan(:, :, :, t);
    roi(roi == 0) = NaN;

    for slicej=1:size(roi, 3)
        % Do not consider empty slices
        if sum(sum(1-isnan(roi(:, :, slicej)))) == 0
            continue
        end
        
        % Call LPQ function to calculate the LBP histogram per axial slice.
        % Download it from http://www.cse.oulu.fi/wsgi/CMV/Downloads
        LPQhist_tmp = double(lpq(roi(:, :, slicej), 3, 1, 1, 'h'));
        LPQhist(t, :) = LPQhist(t, :) + LPQhist_tmp;
    end
    
    if normalise == 0
        LPQhist(t, :) = bsxfun(@rdivide, LPQhist(t, :), sqrt(sum(LPQhist(t, :).^2)));
    end
end