function rps = calculateRPS(scan)
% function rps = calculateRPS(scan)
%
% Computes the radial power spectrum of a NxNxDxT dynamic sequence. Where
% NxN represents the size of each axial slice, D the number of axial
% slices, and T the number of time points.
%
% (C) J. Bernal, 2019

% Process image size information
N = size(scan, 1);
depth = size(scan, 3);
timepoints = size(scan, 4);

rps = zeros(timepoints, fix(N/2) + 1);
for t = 1:timepoints
    Pf = zeros(1, fix(N/2) + 1);
    Pc = zeros(1, fix(N/2) + 1);
    
    % Calculate the radial power spectrum per axial slice
    for slicej = 1:depth
        scan_t = scan(:, :, slicej, t);
        if sum(sum(scan_t ~= 0)) == 0
            continue
        end
        
        % Call raPsd2d function to calculate the psd per axial slice. Refer
        % to MATLAB central for additional information
        % 23636-radially-averaged-power-spectrum-of-2d-real-valued-matrix
        [Pf_tmp, Pc_tmp] = raPsd2d(scan_t);
        Pf = Pf + Pf_tmp;
        Pc = Pc + Pc_tmp;
    end
    
    % Average the RPS values element-wise
    rps(t, :) = Pf ./ Pc;
end
end