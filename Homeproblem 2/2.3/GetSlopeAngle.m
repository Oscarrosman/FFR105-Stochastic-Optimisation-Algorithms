%% This file provides the FORMAT you should use for the
%% slopes in HP2.3. x denotes the horizontal distance
%% travelled (by the truck) on a given slope, and
%% alpha measures the slope angle at distance x
%%
%% iSlope denotes the slope index (i.e. 1,2,..10 for the
%% training set etc.)
%% iDataSet determines whether the slope under consideration
%% belongs to the training set (iDataSet = 1), validation
%% set (iDataSet = 2) or the test set (iDataSet = 3).
%%
%% Note that the slopes given below are just EXAMPLES.
%% Please feel free to implement your own slopes below,
%% as long as they fulfil the criteria given in HP2.3.
%%
%% You may remove the comments above and below, as they
%% (or at least some of them) violate the coding standard 
%%  a bit. :)
%% The comments have been added as a clarification of the 
%% problem that should be solved!).


function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1)                                % Training
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);    % You may modify this!
 elseif (iSlope == 2)
     alpha = 5 + 1.2*sin(x/100) + 2*cos(sqrt(2)*x/50);
 elseif (iSlope == 3)
     alpha = 2 + 2*sin(x/50) + 1.2*cos(sqrt(2)*x/100);
 elseif (iSlope == 4)
     alpha = 5 + 2*sin(x/50) - 2*cos(x/75);
 elseif (iSlope == 5)
     alpha = 6 + 2*sin(x/100) - 2*cos(x/75);
 elseif (iSlope == 6)
     alpha = 2 + sin(x/100) - cos(sqrt(2)*x/50);
 elseif (iSlope == 7)
     alpha = 5 + sin(x/75) - cos(sqrt(7)*x/100);
 elseif (iSlope == 8)
     alpha = 8 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope == 9)
     alpha = 3 + sin(x/25) - cos(sqrt(2)*x/50);
 elseif (iSlope== 10)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);  % You may modify this!
 end 
elseif (iDataSet == 2)                            % Validation
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);    % You may modify this!
 elseif (iSlope == 2)
     alpha = 3 + sin(sqrt(2)*x/50) - cos(x/100);
 elseif (iSlope == 3)
     alpha = 7 + sin(sqrt(7)*x/75) + cos(x/50);
 elseif (iSlope == 4)
     alpha = 5 + 2*sin(x/100) + cos(x/25);
 elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);    % You may modify this!
 end 
elseif (iDataSet == 3)                           % Test
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);   % You may modify this!
 elseif (iSlope == 2)
     alpha = 5 + 2*sin(sqrt(7)*x/100) + cos(x/100);
 elseif (iSlope == 3)
     alpha = 2 + sin(x/50) + sin(x/75) - cos(x/150);
 elseif (iSlope == 4)
     alpha = 7 - sin(x/75) - cos(sqrt(5)*x/75);
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); % You may modify this!
 end
end
