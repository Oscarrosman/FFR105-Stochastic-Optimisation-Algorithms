function individual = Mutation(individual, pMut, pCreep, creepRate)
% Mutation carried out on chromosome while still encoded so all values are
% selected in the range [-1, 1]

for i = 1:size(individual, 2)
    r = rand;
    % Mutation with probability
    if r < pMut
        r = rand;
        % Creep with probability
        if r < pCreep
            r = rand;
            individual(i) = individual(i) - (creepRate/2) + r*creepRate;
            % Make sure values stay within range
            if individual(i) < -1
                individual(i) = -1;
            elseif individual(i) > 1
                individual(i) = 1;
            end
        else
            % Selects new value randomly in [-1, 1]
            r = rand;
            individual(i) = 2*r - 1;
        end
    end
end
