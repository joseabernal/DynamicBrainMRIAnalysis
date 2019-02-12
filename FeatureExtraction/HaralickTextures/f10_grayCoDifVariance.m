function GLCMDifVariance = f10_grayCoDifVariance(p_xMy)
%
% Computes the difference variance of a co-occurrence matrix as described
% by Haralick in his article "Textural features for image classification"
% INPUT:
%   - p_xMy: Vector p_x-y of the co-occurrence matrix
% OUTPUT:
%   - GLCMDifVariance: Difference variance of the matrix
%
% VGC Nov 2007

    GLCMDifVariance = var(p_xMy);

end