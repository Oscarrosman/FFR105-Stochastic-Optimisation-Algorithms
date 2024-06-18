function fitness = Evaluation(positions)

% Definition of the function

f = @(x1, x2) (((x1^2) + x2 - 11)^2) + (x1 + (x2^2) - 7)^2;
fitness = zeros(size(positions, 1), 1);

% Function value is used as fitness value
for i = 1:size(positions, 1)
    fitness(i) = f(positions(i, 1), positions(i, 2));
end

end