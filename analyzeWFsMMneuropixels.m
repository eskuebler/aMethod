%{
analyzeWFsMMvivo
%}

disp('analyzing mouse extracellular waveforms...')

importMMvivoWaves
importMMvivo4QC

% list.mouseVivo.goodUnits = find(unit.presence_ratio > 0.95 &...
%     unit.isi_violations < 0.5 &...
%     unit.amplitude_cutoff < 0.1 &...
%     unit.quality == 'good' &...
%     unit.snr1 > 3 &...
%     unit.isolation_distance > 60);
% list.mouseVivo.goodIDs = unit.id(list.mouseVivo.goodUnits);

% load spike times (for visualization only, firing rate as a parameter is
% taken from the Allen Institute measurement
spTimesID = h5read('Spike_time.hdf5','/ids');
sp = h5read('Spike_time.hdf5','/spikes_time');

X.mouseVivo.all = [];
list.mouseVivo.PV = []; list.mouseVivo.SST = []; list.mouseVivo.VIP =[];
ctTag.MouseEC = [];
list.mouseVivo.bootedCells = [];

N.mouseVivo = 1;
for n = 1:length(id)
    
    fullAnalysis = 0;
    
    x = waveforms(n,:);             % peak channel waveform
    if n == 679
        continue
    end
    processEcWaveforms              % get parameters
    
    if fullAnalysis == 1
        X.mouseVivo.all = [X.mouseVivo.all; x30];
        specimenID.mouseVivo.all(N.mouseVivo,1) = id(n);
        fr.mouseVivo.all(1,N.mouseVivo) = unit.firing_rate(find(ismember(unit.id,id(n))==1));
        spTimes.mouseVivo.all{N.mouseVivo,1} = sp(2:138280,find(ismember(spTimesID,id(n))==1));
        T2P.mouseVivo.all(1,N.mouseVivo) = p2tTemp;
        p2tr.mouseVivo.all(1,N.mouseVivo) = p2trTemp;
        p2trPeak.mouseVivo.all(1,N.mouseVivo) = p2trP;
        p2trTrough.mouseVivo.all(1,N.mouseVivo) = p2trT;
        Pv.mouseVivo.all(1,N.mouseVivo) = pV;
        Tv.mouseVivo.all(1,N.mouseVivo) = tV;
        Ttime.mouseVivo.all(1,N.mouseVivo) = tTime;
        TimeVec.mouseVivo.all(1,N.mouseVivo) = length(timeVec);
%         X.mouseVivo.allRe = [X.mouseVivo.allRe; x];
        if p(n)<0.025 && t(n)>0
            if ct(n)==0
                list.mouseVivo.PV = [list.mouseVivo.PV, N.mouseVivo];
                ctTag.MouseEC = [ctTag.MouseEC, 1];
            elseif ct(n)==1
                list.mouseVivo.SST = [list.mouseVivo.SST, N.mouseVivo];
                ctTag.MouseEC = [ctTag.MouseEC, 2];
            elseif ct(n)==2
                list.mouseVivo.VIP = [list.mouseVivo.VIP, N.mouseVivo];
                ctTag.MouseEC = [ctTag.MouseEC, 3];
            else
                ctTag.MouseEC = [ctTag.MouseEC, 0];
            end
        else
            ctTag.MouseEC = [ctTag.MouseEC, 0];
        end
        N.mouseVivo = N.mouseVivo + 1;
        clear dVdt30 dVdt30Norm dVdtNormRe fullAnalysis halfHeight ...
            halfHeightTpost halfHeightTpre hwTemp hwTempRe maxTempVecT ...
            maxTempVecTRe maxTempVecV maxTempVecVRe maxVal minVal ...
            p2trTemp p2trTempRe p2trTemp p2trTempRe p2tTemp p2tTempRe ...
            peakTime peakV pTime pV t2pTemp t2pTempRe thresholdTime ...
            troughTime troughV tTime tV x x30 x30Norm xNormRe ...
            tempVec timeVec
    else
        list.mouseVivo.bootedCells = [list.mouseVivo.bootedCells,id(n)];
        clear dVdt30 dVdt30Norm dVdtNormRe fullAnalysis halfHeight ...
            halfHeightTpost halfHeightTpre hwTemp hwTempRe maxTempVecT ...
            maxTempVecTRe maxTempVecV maxTempVecVRe maxVal minVal ...
            p2trTemp p2trTempRe p2trTemp p2trTempRe p2tTemp p2tTempRe ...
            peakTime peakV pTime pV t2pTemp t2pTempRe thresholdTime ...
            troughTime troughV tTime tV x x30 x30Norm xNormRe ...
            tempVec timeVec
    end
end
N.mouseVivo = N.mouseVivo - 1;

% putative pyr cells of EC data
list.mouseVivo.broad = find(...
    T2P.mouseVivo.all>0.6 & ...
    fr.mouseVivo.all < 3 & ...
    p2tr.mouseVivo.all > 2.5);
intVec = [find(ismember(list.mouseVivo.broad,list.mouseVivo.PV)),...
    find(ismember(list.mouseVivo.broad,list.mouseVivo.SST)),...
    find(ismember(list.mouseVivo.broad,list.mouseVivo.VIP))];
intVec = unique(intVec);
list.mouseVivo.broad(intVec) = [];
ctTag.MouseEC(1,list.mouseVivo.broad) = 4;

clear ct id intVec n p t waveforms unit