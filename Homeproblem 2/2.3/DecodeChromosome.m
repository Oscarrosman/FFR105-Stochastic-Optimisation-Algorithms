% nIn = the number of inputs
% nHidden = the number of hidden neurons
% nOut = the number of output neurons
% Weights (and biases) should take values in the range [-wMax,wMax]

function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax)

% Determine the size of wIH and extract the correct genes
iWIH = nHidden;
jWIH = nIn + 1;
nWIH = iWIH*jWIH;
wIHFlat = chromosome(1, 1:nWIH)*wMax;


% Determine the size of wHO and extract the correct genes
iWHO = nOut;
jWHO = nHidden + 1;
nWHO = iWHO*jWHO;
wHOFlat = chromosome(1, (nWIH + 1):(nWIH + nWHO))*wMax;


% Reshape the flat wIH and wHO to original shape

wIH = reshape(wIHFlat, [jWIH, iWIH])';

wHO = reshape(wHOFlat, [jWHO, iWHO])';


end