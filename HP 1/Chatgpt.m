%function shortestPath = Chatgpt(nodes, startNode, endNode)
nodes = LoadCityLocations;
startNode = randi([1, size(cities, 1)])
endNode = randi([1, size(cities, 1)])
    numNodes = size(nodes, 1);
    distances = Inf(1, numNodes);
    previous = zeros(1, numNodes);
    unvisitedNodes = 1:numNodes;
    distances(startNode) = 0;

    while ~isempty(unvisitedNodes)
        [~, currentNodeIndex] = min(distances(unvisitedNodes));
        currentNode = unvisitedNodes(currentNodeIndex);
        unvisitedNodes(currentNodeIndex) = [];

        for i = 1:numNodes
            if ismember(i, unvisitedNodes)
                % Calculate Euclidean distance between nodes currentNode and i
                distance = sqrt((nodes(currentNode, 1) - nodes(i, 1))^2 + (nodes(currentNode, 2) - nodes(i, 2))^2);
                tentativeDistance = distances(currentNode) + distance;
                if tentativeDistance < distances(i)
                    distances(i) = tentativeDistance;
                    previous(i) = currentNode;
                end
            end
        end
    end

    % Reconstruct the shortest path
    currentNode = endNode;
    shortestPath = [];
    while currentNode ~= startNode
        shortestPath = [currentNode, shortestPath];
        currentNode = previous(currentNode);
    end
    shortestPath = [startNode, shortestPath];
%end
