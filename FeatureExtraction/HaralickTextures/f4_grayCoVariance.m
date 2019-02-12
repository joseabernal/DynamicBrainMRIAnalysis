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
% VGC Mar 2015 - Fixed issue with the mean

%     var = 0;
    
    %Matrix' mean 
    mu = mean2(GLCMNorm);
    % WARNING: IT IS NOT CLEAR WHAT THIS IS IN HARALICK PAPER
    % In Teruel et al., NMR Biomed. 2014; 27: 887–896 it is stated that the
    % mean is the mean for the px distribution. They compute the
    % variance of the px distribution; not on the
    % POSSIBLE SOLUTION: this mean is the average between mu_x and mu_y
    % (the mean of px and py)
%     mu_x = sum((1:size(GLCMNorm,2)).*sum(GLCMNorm,1));
%     mu_y = sum((1:size(GLCMNorm,1)).*sum(GLCMNorm,2)');
%     mu = (mu_x+mu_y)/2;

    % OTHER POSSIBLE SOLUTION: i-j (considering that mu is a typo and
    % Haralick used j)
%     [j,i] = meshgrid(1:size(GLCMNorm,1));
%     matAux = ((i-j).^2).*GLCMNorm;
%     var = sum(matAux(:));

    % BILL NAILON MAKES:
    % [~,i] = meshgrid(1:size(GLCMNorm,1))
    % ux=i.*CoMat;
    % h=ux.*i;
    % var = sum(h(:))
    % However, this is not the same as Haralick's equation, and the result 
    % should be similar (GLCMean should not be very high) as mine.
    
   
     %Calculate the matrix' variance
%     for i=1:size(GLCMNorm,1)
%         for j=1:size(GLCMNorm,2)
%             var = var + (((i-GLCMean)^2)*GLCMNorm(i,j));
%         end
%     end
    [~,i] = meshgrid(1:size(GLCMNorm,1));
    matAux = ((i-mu).^2).*GLCMNorm;
    var = sum(matAux(:));
        
    GLCMVar = var;
    
end