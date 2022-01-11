function [fitresult, gof] = createT2PnhpECFit(wfCenters, wfCounts)
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

%  Auto-generated by MATLAB on 09-Jul-2020 12:35:40


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( wfCenters, wfCounts );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0.1 0 -Inf -Inf 0];
opts.MaxFunEvals = 1000;
opts.MaxIter = 1000;
opts.StartPoint = [0.292 0.15 0.027 0.1298 0.48 0.0526];
opts.Upper = [Inf 0.3 Inf Inf Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );