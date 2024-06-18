% x = linspace(0, 2*pi);
% 
% fValues = sin(x);
% 
% figure(1)
% 
% plot(x, fValues)

% Create a new figure
% figure;
% 
% % Create the first subplot (top-left)
% subplot(2, 2, 1);
% plot([1, 2, 3, 4], [10, 15, 5, 12]); % Example data
% 
% % Create the second subplot (top-right)
% subplot(2, 2, 2);
% scatter([1, 2, 3, 4], [20, 10, 25, 30]); % Example data
% 
% % Create the third subplot (bottom-left)
% subplot(2, 2, 3);
% bar([1, 2, 3, 4], [5, 8, 15, 10]); % Example data
% 
% % Create the fourth subplot (bottom-right)
% subplot(2, 2, 4);
% pie([30, 20, 10, 40]); % Example data
% 
% % Add titles and labels as needed
% title('Four Separate Plots');
% xlabel('X-axis');
% ylabel('Y-axis');

% Adjust subplot spacing (optional)
% You can fine-tune the spacing between subplots if needed.
% subplot('Position', [left, bottom, width, height]);

% Display the plots

fprintf('| PMut   | Median         | Average         | STD           | Max fitness  |\n')
fprintf('---------------------------------------------------------------------------- \n')
for i = 1:5:50
    fprintf('| %1.4f |  %1.10f  |   %1.10f  | %1.10f  | %1.10f |\n', mutationProbability(i), medianList(i), averageList(i), stdList(i), highestFitnessList(i))
end