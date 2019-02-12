function GLCMContrast = f2_grayCoContrast(GLCM)
%
%This function computes the contrast of the cooccurrence matrix as
%described by Haralick in his article "Textural features for image
%classification"
%
% INPUT:
%   - GLCM: Cooccurrence matrix without normalising
% OUTPUT:
%   - GLCMContrast: Contrast of the given matrix
%
% VGC Nov 2007

    stats = graycoprops(GLCM,'Contrast');
    GLCMContrast = stats.Contrast;

end