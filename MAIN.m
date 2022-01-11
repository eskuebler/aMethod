%{
MAIN
- methods: extracellular (utah array & neuropixels), intracellular (patch)
- species: mouse (IC & EC), macaque (IC & EC)
- labs: AIBS (IC & EC mouse), JMT lab (IC & EC macaque)
%}

% SETUP MATLAB WORKSPACE
clear; close all; clc;          % prepare Matlab
loadFreeParameters              % load free parameters

% GET WAVEFORMS & PARAMETERS
analyzeWFsPatchClamp            % ex vivo mouse & NHP APs (patch clamp - AIBS & JMT, resp.)
analyzeWFsMMneuropixels         % in vivo mouse APs (neuropixels - AIBS)
analyzeWFsNHPutah               % in vivo NHP APs (Utah array - JMT)
clearUpNoisyData                % clean outliers and NaNs

% SPIKE DURATIONS & FIRING RATES
plotAPsNtrough2peak             % plot waveforms and trough-to=peak distributions
plotFiringRates                 % plot firing patterns and rate distributions
plotTrough2PeakRatio            % plot example ratios and distributions

% GENERATE TRAINING/TESTING SETS & MODELS
rescaleEC                       % process EC mouse parameters for classification
% generateTrainingSetsIC          % generate 'numRands' different IC sets
classifyICmouse                 % generate 'numRands' different IC models
% generateTrainingSetsEC          % generate 'numRands' different EC sets
% classifyECmouse                 % generate 'numRands' different EC models

% CLASSIFY CELLS OF DATASETS WITH NO LABELS
% classifyICmouse2ECmouse         % mouse IC correspondence to mouse EC
% classifyICmouse2ECmouseALL      % mouse IC correspondence to mouse EC
classifyICmouse2ICnhp           % mouse IC correspondence to NHP IC
% classifyICmouse2ECNHP           % mouse IC correspondence to NHP EC