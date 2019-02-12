function GLCMInvDifMom = f5_grayCoInvDifMom(GLCMNorm)
%
% Computes the inverse difference moment of a co-occurrence matrix as
% described by Haralick in his article "Textural features for image
% classification"
% INPUT:
%   - GLCMNorm: Normalized co-occurrence matrix.
% OUTPUT:
%   - GLCMInvDifMom: Inverse difference moment of the matrix (Homogeneity)
%
% VGC Nov 2007
% Update VGC Feb 2015: Vectorization

%     mom = 0;
    
    %Calculate the inverse difference moment
%     for i=1:size(GLCMNorm,1)
%         for j=1:size(GLCMNorm,2)
%             momParc = GLCMNorm(i,j)/(1+((i-j)^2));
%             mom = mom + momParc;
%         end
%     end
    
%     GLCMInvDifMom = mom;
    
    [j, i]=meshgrid(1:size(GLCMNorm,1));
    h = GLCMNorm./(1 + (i - j).^2);
	GLCMInvDifMom = sum(h(:));
    

end