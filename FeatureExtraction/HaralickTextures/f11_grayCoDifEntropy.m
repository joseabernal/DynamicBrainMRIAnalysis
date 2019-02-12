function GLCMDifEntropy = f11_grayCoDifEntropy(GLCMNorm, p_xMy)
%
% Computes the difference entropy of a co-occurrence matrix as described
% by Haralick in his article "Textural features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
%   - p_xMy: Vector p_x-y of the co-occurrence matrix
% OUTPUT:
%   - GLCMDifEntropy: Difference entropy of the matrix
%
% VGC Nov 2007

    GLCMDifEntropy = 0;
    
    %Since some of the probabilities of sumVec may be 0 and log2(0) is not
    %defined, it is recommended to use log2(p+EPSILON) rather than log2(p)
    %in entropy computations
    EPSILON = 0.000000001;
    
    for i=1:size(GLCMNorm,1)
        GLCMDifEntropy = GLCMDifEntropy - (p_xMy(i)*log2(p_xMy(i)+EPSILON));
    end

end