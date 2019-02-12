function GLCMVar = f4_grayCoVariance_2(GLCMNorm)
%
% This function computes the variance of the cooccurrence matrix as
% described by Haralick in his article "Textural features for image
% classification"
% This version of the file tries to solve the issue with Mu (Haralik did
% not specify its meaning)
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
    %mu = mean2(GLCMNorm);
    % WARNING: IT IS NOT CLEAR WHAT THIS IS IN HARALICK PAPER
    % In Teruel et al., NMR Biomed. 2014; 27: 887–896 it is stated that the
    % mean is the mean for the px distribution. They compute the
    % variance of the px distribution; not on the
    % POSSIBLE SOLUTION: this mean is the average between mu_x and mu_y
    % (the mean of px and py)
    mu_x = sum((1:size(GLCMNorm,1)).*sum(GLCMNorm,2)');
    mu_y = sum((1:size(GLCMNorm,2)).*sum(GLCMNorm,1));
%     mu = (mu_x+mu_y)/2;

    % BILL NAILON MAKES:
    % [~,i] = meshgrid(1:size(GLCMNorm,1))
    % ux=i.*CoMat;
    % h=ux.*i;
    % var = sum(h(:))
    % However, this is not the same as Haralick's equation, and the result 
    % should be similar (GLCMean should not be very high) as mine.
    
   
    %Calculate the matrix' sum of squares (variance)

    [j,i] = meshgrid(1:size(GLCMNorm,1));
    %matAux = ((i-mu).^2).*GLCMNorm; HARALICK EQUATION
    %matAux = ((i-mu_x).*(j-mu_y)).*GLCMNorm; OTHER POSSIBLE SOLUTION
    matAux = ((i-mu_x).^2).*GLCMNorm;
    var = sum(matAux(:));
        
    GLCMVar = var;
    
end