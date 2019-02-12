function GLCMEnergy = f1_grayCoEnergy(GLCM)
%
%This function computes the energy of the cooccurrence matrix as
%described by Haralick in his article "Textural features for image
%classification"
%
% INPUT:
%   - GLCM: Cooccurrence matrix without normalising
% OUTPUT:
%   - GLCMEnergy: Energy of the given matrix
%
% VGC Nov 2007

    stats = graycoprops(GLCM,'Energy');
    GLCMEnergy = stats.Energy;

end