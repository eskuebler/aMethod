function [fitresult, gof] = createT2PmouseICFit(wfCenters, wfCounts)
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

%  Auto-generated by MATLAB on 06-Jan-2021 10:12:41


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( wfCenters, wfCounts );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [0.159006867406233 0.6456 0.0648000711927176 0.105124130135968 0.3828 0.12168631966749];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );