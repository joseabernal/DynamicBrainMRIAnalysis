function GLCMEntropy = f9_grayCoEntropy(GLCMNorm)
%
% Computes the entropy of a co-occurrence matrix as described by
% Haralick in his article "Textural features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
% OUTPUT:
%   - GLCMEntropy: Entropy of the matrix
%
% VGC Nov 2007

    GLCMEntropy = 0;
    
    %Since some of the probabilities of sumVec may be 0 and log2(0) is not
    %defined, it is recommended to use log2(p+EPSILON) rather than log2(p)
    %in entropy computations
    EPSILON = 0.000000001;
    
    for i=1:size(GLCMNorm,1)
        for j=1:size(GLCMNorm,2)
            GLCMEntropy = GLCMEntropy - (GLCMNorm(i,j)*log2(GLCMNorm(i,j)+EPSILON));
        end
    end
end
