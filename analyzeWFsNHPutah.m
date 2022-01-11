%{
analyzeWFsNHPvivo
%}

disp('analyzing NHP extracellular waveforms...')

folders = dir(datafolders.NHPex);
folders = folders(3:5);

X.nhpVivo.all = [];

N.nhpVivo = 1;
for i = 1:length(folders)
    cd([folders(i).folder,'\',folders(i).name])
    cellList =  dir('*.mat');
    for k = 1:length(cellList)
        fullAnalysis = 0;
        load([cellList(k).folder,'\',cellList(k).name])
        a = who;
        for m = 1:length(a)
            if length(a{m})>6 && sum(a{m}(1:4) == 'Chan')==4
                break
            end
        end
        varname = genvarname(a{m},'Global');
        mat = eval(varname);                   % data matrix
        x = mean(mat(:,7:end));                % average aligned waveforms
        sp = mat(:,3);                         % spike times in seconds
        sp(sp<10) = [];                        % there are sometimes resets in the first 10 seconds for synchronization
        temp = length(sp)/7200;
        
        processEcWaveforms
        
        if fullAnalysis == 1
            X.nhpVivo.all = [X.nhpVivo.all; x30];
            specimenID.nhpVivo.all(N.nhpVivo,1) = string([cellList(k).name(1),...
                cellList(k).name(5:end-4)]);
            fr.nhpVivo.all(1,N.nhpVivo) = temp;
            spTimes.nhpVivo.all{N.nhpVivo,1} = sp;
            T2P.nhpVivo.all(1,N.nhpVivo) = p2tTemp;
            p2tr.nhpVivo.all(1,N.nhpVivo) = p2trTemp;
            p2trPeak.nhpVivo.all(1,N.nhpVivo) = p2trP;
            p2trTrough.nhpVivo.all(1,N.nhpVivo) = p2trT;            
            Pv.nhpVivo.all(1,N.nhpVivo) = pV;
            Tv.nhpVivo.all(1,N.nhpVivo) = tV;
            Ttime.nhpVivo.all(1,N.nhpVivo) = tTime;
            TimeVec.nhpVivo.all(1,N.nhpVivo) = length(timeVec);
            N.nhpVivo = N.nhpVivo + 1;
        end

        clear a Chan* dVdt30 dVdt30Norm dVdtNormRe fullAnalysis halfHeight ...
            halfHeightTpost halfHeightTpre hwTemp hwTempRe m mat maxTempVecT ...
            maxTempVecTRe maxTempVecV maxTempVecVRe maxVal minVal p2trTemp ...
            p2trTempRe p2tTemp p2tTempRe peakTime peakV pTime pV sp t2pTemp ...
            t2pTempRe temp tempVec thresholdTime timeVec troughTime ...
            troughV tTime tV varname x x30 x30Norm xNormRe
    end 
end
N.nhpVivo = N.nhpVivo - 1;

cd(datafolders.origDir) % dir

clear cellList folders i k