close all; clearvars; clc
iterations = 100;
minima = 1000*ones(4, 3);

for i = 1:iterations
    fprintf('\n Iteration: %3d \n', i)
    runMinima = RunPSO;

    for j = 1:size(runMinima, 1)
        if runMinima(j, 1) < minima(j, 1)
            minima(j, :) = runMinima(j, :);
        end
    end
end

fprintf('\n \n \n')
fprintf('Iterative PSO: %3d \n', iterations)
fprintf('----------------------------------- \n')
for i = 1:size(minima, 1)
    fprintf(' > Minimum %2d: f(x1, x2) = %2.5f,  x1 = %2.5f, x2 = %2.5f \n', i, minima(i, 1), minima(i, 2), minima(i, 3))
end