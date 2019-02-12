function GLCMSumAvg = f6_grayCoSumAvg(GLCMNorm, p_xPy)
%
% Computes the sum average of a co-occurrence matrix as described by
% Haralick in his article "Textural features for image classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
%   - p_xPy: Vector p_x+y of the co-occurrence matrix
% OUTPUT:
%   - GLCMSumAvg: Sum average of the matrix
%
% VGC Nov 2007

    GLCMSumAvg = 0;
    for i=2:(size(GLCMNorm,1)*2)
        GLCMSumAvg = GLCMSumAvg + (i*p_xPy(i));
    end

end