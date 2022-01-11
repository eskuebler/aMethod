function [fitresult, gof] = createT2PmouseECFit(wfCenters, wfCounts)
%CREATEFIT(WFCENTERS,WFCOUNTS)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : wfCenters
%      Y Output: wfCounts
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 03-Aug-2021 10:50:19


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( wfCenters, wfCounts );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [0.241738343141693 0.1 0.0370129131468607 0.109638803710103 0.595 0.0552020338973313];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% 
% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
% legend( h, 'wfCounts vs. wfCenters', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'wfCenters', 'Interpreter', 'none' );
% ylabel( 'wfCounts', 'Interpreter', 'none' );
% grid on
% 
% 
