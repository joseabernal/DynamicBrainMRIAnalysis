function GLCMSumEntropy = f8_grayCoSumEntropy(GLCMNorm, p_xPy)
%
% Computes the sum entropy of a co-occurrence matrix as described by
% Haralick in his article "Textural features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
%   - p_xPy: Vector p_x+y of the co-occurrence matrix
% OUTPUT:
%   - GLCMSumEntropy: Sum entropy of the matrix
%
% VGC Nov 2007

    GLCMSumEntropy = 0;
    
    %Since some of the probabilities of sumVec may be 0 and log2(0) is not
    %defined, it is recommended to use log2(p+EPSILON) rather than log2(p)
    %in entropy computations
    EPSILON = 0.000000001;
    for i=2:(size(GLCMNorm,1)*2)
        GLCMSumEntropy = GLCMSumEntropy - (p_xPy(i)*log2(p_xPy(i)+EPSILON));
    end

end