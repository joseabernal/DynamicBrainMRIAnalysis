function GLCMInfMesCorrelation_f12 = f12_grayCoInfMesCorrelation(GLCMNorm)
%
% Computes the first value of the information measures of correlation of a
% co-occurrence matrix as described by Haralick in his article "Textural
% features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
% OUTPUT:
%   - GLCMInfMesCorrelation_f12: First information measure of correlation
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
    %Calculation of HXY1
    HXY1 = 0;
    for i=1:size(GLCMNorm,1)
        for j=1:size(GLCMNorm,2)
            HXY1 = HXY1 - (GLCMNorm(i,j)*log2(Px(i)*Py(j) + EPSILON));
        end
    end
    
    %HX and HY are the entropies of Px and Py:
    HX = 0;
    HY = 0;
    for i=1:size(Px,2)
        HX = HX - (Px(i)*log2(Px(i)+EPSILON));
    end
    for j=1:size(Py,2)
        HY = HY - (Py(j)*log2(Py(j)+EPSILON));
    end
    
    %Calculation of the value of f12
    GLCMInfMesCorrelation_f12 = (HXY-HXY1)/max(HX,HY);

end