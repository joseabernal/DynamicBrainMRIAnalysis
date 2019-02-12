function GLCMVar = f4_grayCoVariance(GLCMNorm)
%
%This function computes the variance of the cooccurrence matrix as
%described by Haralick in his article "Textural features for image
%classification"
%
% INPUT:
%   - GLCMNorm: Normalized cooccurrence matrix
% OUTPUT:
%   - GLCMVar: Variance of the given matrix
%
% VGC Nov 2007

    var = 0;
    
    %Matrix' mean
    GLCMean = mean(mean(GLCMNorm));
    
    %Calculate the matrix' variance
    for i=1:size(GLCMNorm,1)
        for j=1:size(GLCMNorm,2)
            var = var + (((i-GLCMean)^2)*GLCMNorm(i,j));
        end
    end
    
    GLCMVar = var;
    
end