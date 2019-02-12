function GLCMSumVariance = f7_grayCoSumVariance(GLCMNorm, p_xPy, sumEnt)
%
% Computes the sum variance of a co-occurrence matrix as described by
% Haralick in his article "Textural features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
%   - p_xPy: Vector p_x+y of the co-occurrence matrix
%   - sumEnt: Sum entropy of the co-occurrence matrix
% OUTPUT:
%   - GLCMSumVariance: Sum variance of the matrix
%
% VGC Nov 2007

    GLCMSumVariance = 0;
    for i=2:(size(GLCMNorm,1)*2)
        GLCMSumVariance = GLCMSumVariance + (((i-sumEnt)^2)*p_xPy(i));
    end

end