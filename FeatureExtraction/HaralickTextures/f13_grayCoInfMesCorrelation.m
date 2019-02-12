function GLCMInfMesCorrelation_f13 = f13_grayCoInfMesCorrelation(GLCMNorm)
%
% Computes the second value of the information measures of correlation of a
% co-occurrence matrix as described by Haralick in his article "Textural
% features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
% OUTPUT:
%   - GLCMInfMesCorrelation_f13: Second information measure of correlation
%   of the matrix
%
% VGC Nov 2007

    EPSILON = 0.000000001;
    
    %We obtain Px by summing the rows of GLCMNorm
    Px = sum(GLCMNorm,2)';
    %We obtain Py by summing the columns of GLCMNorm
    Py = sum(GLCMNorm,1);
    
    %HXY is the entropy of GLCMNorm
    HXY = f9_grayCoEntropy(GLCMNorm);
    
    %Calculation of HXY2
    HXY2 = 0;
    for i=1:size(GLCMNorm,1)
        for j=1:size(GLCMNorm,2)
            HXY2 = HXY2 - ((Px(i)*Py(j))*log2(Px(i)*Py(j) + EPSILON));
        end
    end
    
    %Calculation of f13
    GLCMInfMesCorrelation_f13 = sqrt(abs(1 - exp(-2.0*(HXY2 - HXY))));

end