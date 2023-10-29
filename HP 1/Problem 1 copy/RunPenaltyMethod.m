%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Penalty method for minimizing
%
% (x1-1)^2 + 2(x2-2)^2, s.t.
%
% x1^2 + x2^2 - 1 <= 0.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The values below are suggestions - you may experiment with
% other values of eta and other (increasing) sequences of the
% µ parameter (muValues).

% Functions defined for extra information when printing to the command
% window.
g = @(x1, x2) ((x1^2) + (x2^2) -1);
f = @(x1, x2) (x1-1)^2 + 2*(x2-2)^2;
fp = @(x1, x2, mu) ((x1-1)^2 + 2*(x2-2)^2 + mu*(x1^2 + x2^2 - 1)^2);

muValues = [1 10 100 1000];
eta = 0.0001;
xStart =  [1, 2]; % [Specify as a vector with two components, see Step 3 of the problem formulation];
gradientTolerance = 1E-6;

for i = 1:length(muValues)
 mu = muValues(i);
 x = RunGradientDescent(xStart,mu,eta,gradientTolerance);
 fprintf('x(1) = %3f, x(2) = %3f, mu = %d, f(x) = %2.4f, g(x) = %2.4f, fp(x, mu) = %2.4f \n \n',x(1),x(2),mu, f(x(1), x(2)), g(x(1), x(2)), fp(x(1), x(2), mu))
end


%% Section for plotting X as a function of mu

% muValues = linspace(1, 1000);
% x = zeros(100, 2);
% 
% for i = 1:length(muValues)
%     mu = muValues(i);
%     x(i, :) = RunGradientDescent(xStart, mu, eta, gradientTolerance);
% end
% 
% figure(1)
% subplot(1, 2, 1)
% plot(muValues, x(:, 1), 'Color', 'r', Linewidth=2)
% title('X(1)')
% ylabel('X(1)')
% xlabel('Mu')
% subplot(1, 2, 2)
% plot(muValues, x(:, 2), LineWidth=2)
% title('X(2)')
% ylabel('X(2)')
% xlabel('Mu')

