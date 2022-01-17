%{
loadFreeParametersCrossSpecies
- free parameters user can adjust
%}

% set current directory
datafolders.origDir = 'G:\My Drive\0 current projects\0 githubs\aMethod';
cd(datafolders.origDir) % dir

datafile.IC = 'G:\My Drive\0 current projects\0 githubs\aMethod\data\icDataStr.mat';
datafile.MMpyrIDs = 'G:\My Drive\0 current projects\0 githubs\aMethod\data\MMpyramidalIDs.mat';
datafile.ECmouse = 'C:\Users\erics\OneDrive - The University of Western Ontario\working memory (RL MR BC)\Spike_time.hdf5';
datafolders.NHPex = 'C:\Users\erics\OneDrive - The University of Western Ontario\working memory (RL MR BC)\single cells';
datafile.NHPdend = 'NHPdendriteNlayer.mat';

% sampling parameters used across datasets (to compute dV/dt)
sample.RateIn = 5e4;                            % intracellular # samples per ms
sample.dtIn = 1000/sample.RateIn;               % intracellular sampling rate
sample.RateEx = 3e4;                            % extracellular # samples per ms
sample.dtEx = 1000/sample.RateEx;               % extracellular sampling rate

% time sampled around waveform peak 
wfsP.tPreAPvivo = 10;                             % time-steps pre-peak for extracellular (sampled @ sample.RateEx kHz)
wfsP.tPostAPvivo = 30;                           % time-steps post-peak for extracellular (@ sample.RateEx kHz)

% distribution ranges
edges.T2P.IC = 0.10:0.062:1.65;
edges.T2P.EC = 0.04:0.037:.98;
edges.T2P.ECrescaleFig = 0.1:1.1/20:1.2;
edges.FR.IC = 1.2:0.19:6;
edges.FR.EC = -3.8:0.35:5;
edges.P2TR.IC = 0.6:.25:5.7;
edges.P2TR.EC = 0.9:0.2:5;
edges.standardized = 0:0.05:1;

% model parameters
fits.numRand = 1000;                            %  num models

% plotting parameters
plots.az = -30;
plots.el = 11;
plots.mrkszr = 5;
plots.cc = [1 0 0;0 1 0;0 0 1;0 0 0];