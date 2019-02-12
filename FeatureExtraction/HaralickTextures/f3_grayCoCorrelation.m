function GLCMCorrelation = f3_grayCoCorrelation(GLCM)
%
%This function computes the correlation of the cooccurrence matrix as
%described by Haralick in his article "Textural features for image
%classification"
%
% INPUT:
%   - GLCM: Cooccurrence matrix without normalising
% OUTPUT:
%   - GLCMCorrelation: Correlation of the given matrix
%
% VGC Nov 2007

    stats = graycoprops(GLCM,'Correlation');
    GLCMCorrelation = stats.Correlation;

end