function [fitresult, gof] = createP2TRecNHPFit(wfCenters, wfCounts)
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

%  Auto-generated by MATLAB on 18-Nov-2020 13:45:57


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( wfCenters, wfCounts );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [0.145098039215686 1.41 0.125807841877551 0.094019988859382 1.75 0.153540305077809];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
