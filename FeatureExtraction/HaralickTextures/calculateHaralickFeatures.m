function features = calculateHaralickFeatures(scan, featurenames)
% function features = calculateRPS(scan, featurenames)
%
% Computes the Haralick textures of a NxNxDxT dynamic sequence. Where
% NxN represents the size of each axial slice, D the number of axial
% slices, and T the number of time points. The variable featurenames is a
% cell containing the code for each one of the Haralick features. The codes
% are as follows:
% 'f1'  -> Energy
% 'f2'  -> Contrast
% 'f3'  -> Correlation
% 'f4'  -> Variance
% 'f5'  -> Inverse difference moment
% 'f6'  -> Sum average
% 'f7'  -> Sum variance
% 'f8'  -> Sum entropy
% 'f9'  -> Entropy
% 'f10' -> Difference variance
% 'f11' -> Difference entropy
% 'f12' -> First information measure of correlation
% 'f13' -> Second information measure of correlation
% 'f14' -> Maximal correlation coefficient
%
% (C) J. Bernal, 2019

% Process image size information
orientRoot = 1:13;
timepoints = size(scan, 4);

features = zeros(timepoints, length(featurenames));
for t = 1:timepoints
    roi = scan(:, :, :, t);
    
    % Set background to NaN to avoid calculating textures in that region
    roi(roi == 0) = NaN;
    
    % Call cooc3d function to calculate 3D GLCM. Refer
    % to MATLAB central for additional information
    % https://uk.mathworks.com/matlabcentral/fileexchange/19058-cooc3d
    coocmatrix = cooc3d(roi);
    
    % Compute the textures in all possible directions
    descAux = zeros(length(orientRoot), length(featurenames));
    for k=1:length(orientRoot)
        descAux(k,:) = fCompFeatsFromGLCM(coocmatrix(:, :, k), nameFeats);
    end

    % Extract median value as summary of each one of the textures
    features(t, :) = median(descAux);
end