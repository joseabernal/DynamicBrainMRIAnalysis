function features = fCompFeatsFromGLCM(GLCM,listFeat)
%
% This function calculates the chosen haralick descriptors from a
% co-occurrence matrix.
% INPUT:
%   - GLCM: Co-occurrence matrix.
%   - listFeat: List of the names of the descriptors that we want to
%   calculate. The options are:
%       'f1'  -> Energy
%       'f2'  -> Contrast
%       'f3'  -> Correlation
%       'f4'  -> Variance
%       'f5'  -> Inverse difference moment (Homogeneity)
%       'f6'  -> Sum average
%       'f7'  -> Sum variance
%       'f8'  -> Sum entropy
%       'f9'  -> Entropy
%       'f10' -> Difference variance
%       'f11' -> Difference entropy
%       'f12' -> First information measure of correlation
%       'f13' -> Second information measure of correlation
%       'f14' -> Maximal correlation coefficient
%
% OUTPUT:
%   - features: Vector with the requested Haralick's texture features
%
% VGC Nov 2007

    numFeatures = size(listFeat,2);
    features = zeros(1,numFeatures);
    GLCMNorm = normalizeMatrix(GLCM);
    p_xPy = sumProbMatrix(GLCMNorm);
    p_xMy = minusProbMatrix(GLCMNorm);
    
    for i=1:numFeatures
        switch lower(listFeat{i})
            case 'f1'
                features(i) = f1_grayCoEnergy(GLCM); % Not necessary to normalize GLCM, as the Matlab built-in function is used
            case 'f2'
                features(i) = f2_grayCoContrast(GLCM); % Not necessary to normalize GLCM, as the Matlab built-in function is used
            case 'f3'
                features(i) = f3_grayCoCorrelation(GLCM); % Not necessary to normalize GLCM, as the Matlab built-in function is used
            case 'f4'
                features(i) = f4_grayCoVariance(GLCMNorm);
            case 'f5'
                features(i) = f5_grayCoInvDifMom(GLCMNorm);
            case 'f6'
                features(i) = f6_grayCoSumAvg(GLCMNorm, p_xPy);
            case 'f7'
                features(i) = f7_grayCoSumVariance(GLCMNorm, p_xPy, f8_grayCoSumEntropy(GLCMNorm, p_xPy));
            case 'f8'
                features(i) = f8_grayCoSumEntropy(GLCMNorm, p_xPy);
            case 'f9'
                features(i) = f9_grayCoEntropy(GLCMNorm);
            case 'f10'
                features(i) = f10_grayCoDifVariance(p_xMy);
            case 'f11'
                features(i) = f11_grayCoDifEntropy(GLCMNorm, p_xMy);
            case 'f12'
                features(i) = f12_grayCoInfMesCorrelation(GLCMNorm);
            case 'f13'
                features(i) = f13_grayCoInfMesCorrelation(GLCMNorm);
            case 'f14'
                %This feature could be NaN. so it would be not used
                features(i) = f14_grayCoIMaxCorrCoeff(GLCMNorm);
            otherwise
                error('This is not a texture feature proposed of the ones proposed by Haralick');
        end
    end

end