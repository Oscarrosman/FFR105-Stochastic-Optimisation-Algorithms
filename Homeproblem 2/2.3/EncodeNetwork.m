function chromosome = EncodeNetwork(wIH, wHO, wMax)
% Find size of ingoing matrices
[iWIH, jWIH] = size(wIH);
nWIH = iWIH*jWIH;

[iWHO, jWHO] = size(wHO);
nWHO = iWHO*jWHO;

chromosome = zeros(1, (nWIH + nWHO));

nGene = 1;

% Flatten matrices, assign value to correct place in chromosome
for i = 1:iWIH
    for j = 1:jWIH
        % Scaling
        chromosome(nGene) = wIH(i, j)/wMax;
        if chromosome(nGene) > 1
            chromosome(nGene) = 1;
        elseif chromosome(nGene) < -1
            chromosome(nGene) = -1;
        end
        nGene = nGene + 1;
    end
end

% Excatly the same as the loop above
for i = 1:iWHO
    for j = 1:jWHO
        chromosome(nGene) = wHO(i, j)/wMax;
        if chromosome(nGene) > 1
            chromosome(nGene) = 1;
        elseif chromosome(nGene) < -1
            chromosome(nGene) = -1;
        end
        nGene = nGene + 1;
    end
end
end