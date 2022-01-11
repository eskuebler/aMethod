% processEcWaveforms

clear tTime pV tV timeVec
 
[~,peakTime] = min(x);

if peakTime-wfsP.tPreAPvivo > 0 && wfsP.tPostAPvivo < length(x(peakTime:end)) % enough time before and after?
    
    % peak & trough
    [peakV,peakTime] = min(x);
    [troughV,troughTime] = max(x(1,peakTime:end));
    troughTime = troughTime+peakTime-1;
    
    if troughTime > peakTime
        
        pTime = peakTime;
        tTime = troughTime;
        pV = peakV;
        tV = troughV;
        timeVec = 1:peakTime-wfsP.tPreAPvivo;
        
        p2tTemp = (troughTime-peakTime)*sample.dtEx;                        % peak-to-trough
        p2trTemp = abs(peakV)/abs(troughV);                                      % peak V / trough V ratio
        p2trP = troughV;
        p2trT = peakV;
        
        tempVec = diff(x)/sample.dtEx;                                      % temp dV/dt
        [maxTempVecV,maxTempVecT] = min(tempVec(1:peakTime));               % maximum dV/dt
        thresholdTime = find(tempVec(1:maxTempVecT)>maxTempVecV*0.1,1,...
            'last');                                                        % find time where dV/dt > 10% of max
        thresholdTime = thresholdTime+1;                                    % adjust threshold time
        t2pTemp = (peakTime-thresholdTime)*sample.dtEx;                     % threshold to peak

        halfHeight = (peakV-troughV)/2;                                     % half height
        halfHeight = peakV-halfHeight;                                      % half height relative to peak
        halfHeightTpre = find(x(1,1:peakTime)>halfHeight,1,'last');         % half height pre peak
        halfHeightTpost = peakTime+find(x(1,peakTime:troughTime)...
            >halfHeight,1,'first');                                         % half height post peak
        hwTemp = (halfHeightTpost-halfHeightTpre)*sample.dtEx;              % half-width

        x30 = x(1,peakTime-wfsP.tPreAPvivo:peakTime+wfsP.tPostAPvivo-1);  % align at peak
        x30 = x30(1:end-1);
        
        if ~isempty(hwTemp) && ~isempty(t2pTemp) && ~isempty(p2tTemp)
            fullAnalysis = 1;
        end
    end
end