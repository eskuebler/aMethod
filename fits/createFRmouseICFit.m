function [fitresult, gof] = createFRmouseICFit(wfCenters, wfCounts)
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

%  Auto-generated by MATLAB on 22-Jul-2021 08:22:19


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( wfCenters, wfCounts );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [0.150670241286863 3.1 0.22173764672356 0.084235133174083 3.48 0.332975525674431];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );