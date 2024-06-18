function minima = PlotResults(positions, range)

%% K-means for clustering

% Centroid and cluster initialization
EuclidianDistance = @(city1, city2) sqrt(((city1(1) - city2(1))^2) + ((city1(2) - city2(2))^2));
c1 = [5,5];
c2 = [-5,5];
c3 = [5,-5];
c4 = [-5, -5];
centroids = [c1;c2;c3;c4];
cluster1 = [1000,5, 5]; i1 = 2;
cluster2 = [1000,-5, 5]; i2 = 2;
cluster3 = [1000,5, -5]; i3 = 2;
cluster4 = [1000,-5, -5]; i4 = 2;

% Classification
for i = 1:size(positions, 1)
    distances = zeros(1, 4);
    for j = 1:size(centroids)
        distances(j) = EuclidianDistance(positions(i, 2:3), centroids(j, :));
    end

    [minValue, minIndex1] = min(distances);

    if minIndex1 == 1
        cluster1(i1, :) = positions(i, :);
        i1 = i1 + 1;
    elseif minIndex1 == 2
        cluster2(i2, :) = positions(i, :);
        i2 = i2 + 1;
    elseif minIndex1 == 3
        cluster3(i3, :) = positions(i, :);
        i3 = i3 + 1;
    else
        cluster4(i4, :) = positions(i, :);
    end   
end

%% Plotting

xMin = range(1);
xMax = range(2);

x1 = linspace(xMin, xMax, 100);
x2 = linspace(xMin, xMax, 100);
[x1, x2] = meshgrid(x1, x2);

f = (((x1.^2) + x2 - 11).^2) + (x1 + (x2.^2) - 7).^2;

figure(1)

subplot(2, 2, 1)
surf(x1, x2, f)
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('Plot of f(x1, x2)');
colorbar;

subplot(2, 2, 3)
contour(x1, x2, f, 50)
xlabel('x1');
ylabel('x2');
title('Contour Plot f(x1, x2');

subplot(2, 2, 2)
surf(x1, x2, f)
hold on
scatter3(cluster1(:, 2), cluster1(:, 3), cluster1(:, 1), '+', 'green')
scatter3(cluster2(:, 2), cluster2(:, 3), cluster2(:, 1), '+', 'red')
scatter3(cluster3(:, 2), cluster3(:, 3), cluster3(:, 1), '+', 'yellow')
scatter3(cluster4(:, 2), cluster4(:, 3), cluster4(:, 1), '+', 'white')
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('Plot of f(x1, x2) with particles');
colorbar;
hold off

subplot(2, 2, 4)
contour(x1, x2, f, 50)
hold on
scatter3(cluster1(:, 2), cluster1(:, 3), cluster1(:, 1), '+', 'green')
scatter3(cluster2(:, 2), cluster2(:, 3), cluster2(:, 1), '+', 'red')
scatter3(cluster3(:, 2), cluster3(:, 3), cluster3(:, 1), '+', 'blue')
scatter3(cluster4(:, 2), cluster4(:, 3), cluster4(:, 1), '+')
xline(0, 'black')
yline(0, 'black')
xlabel('x1');
ylabel('x2');
title('Contour Plot f(x1, x2) with particles');
hold off

%% Printing
fprintf('Statistics \n')
fprintf('---------------------------------- \n')
nMinima = 0;
if size(cluster1, 1) > 1
    nMinima = nMinima + 1;
    [minValue, minIndex1] = min(cluster1(:, 1));
    fprintf(' > Minimum %2d: f(x1, x2) = %2.5f,   x1 = %2.5f,  x2 = %2.5f \n', nMinima, minValue, cluster1(minIndex1, 2), cluster1(minIndex1, 3))
end

if size(cluster2, 1) > 1
    nMinima = nMinima + 1;
    [minValue, minIndex2] = min(cluster2(:, 1));
    fprintf(' > Minimum %2d: f(x1, x2) = %2.5f,   x1 = %2.5f, x2 = %2.5f \n', nMinima, minValue, cluster2(minIndex2, 2), cluster2(minIndex2, 3))
end

if size(cluster3, 1) > 1
    nMinima = nMinima + 1;
    [minValue, minIndex3] = min(cluster3(:, 1));
    fprintf(' > Minimum %2d: f(x1, x2) = %2.5f,   x1 = %2.5f,  x2 = %2.5f \n', nMinima, minValue, cluster3(minIndex3, 2), cluster3(minIndex3, 3))
end

if size(cluster4, 1) >= 1
    nMinima = nMinima + 1;
    [minValue, minIndex4] = min(cluster4(:, 1));
    fprintf(' > Minimum %2d: f(x1, x2) = %2.5f,  x1 = %2.5f, x2 = %2.5f \n', nMinima, minValue, cluster4(minIndex4, 2), cluster4(minIndex4, 3))
end

fprintf(' > Total minima found: %d \n', nMinima)

minima = zeros(4, 3);

for i = 1:3
    minima(1, i) = cluster1(minIndex1, i);
    minima(2, i) = cluster2(minIndex2, i);
    minima(3, i) = cluster3(minIndex3, i);
    minima(4, i) = cluster4(minIndex4, i);
end
end