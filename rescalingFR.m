%plotFRdistributions

close all

minFR = min(log(fr.mouse.all));
maxFR = max(log(fr.mouse.all));

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouse.all),edges.FR.IC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.fr.x,inflection.mouse.fr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.fr.x,inflection.mouse.fr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])

% split ex vivo into fast and non-fast
narrowInd = find(log(fr.mouse.all)<=inflection.mouse.fr.peakLocs);
narrow = log(fr.mouse.all(narrowInd));
broadInd = find(log(fr.mouse.all)>inflection.mouse.fr.peakLocs);
broad = log(fr.mouse.all(broadInd));
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(narrow,edges.FR.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultNarrowSW, ~] = createFRFastICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultNarrowSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    
    h = histogram(broad,edges.FR.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createFRNonFastICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'r','LineWidth',1);
    line([inflection.mouse.fr.peakLocs,...
        inflection.mouse.fr.peakLocs],[0,0.2], ...
            'color','k','linewidth',1,'linestyle','--');
    xlabel('firing rate (Hz)')
    ylabel('probability')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])
    box off

% get fit for in vivo firing rate data
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouseVivo.all),edges.FR.EC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouseVivo.fr.x,inflection.mouseVivo.fr.yfun1,'k','LineWidth',1);
    plot(inflection.mouseVivo.fr.x,inflection.mouseVivo.fr.yfun2,'k','LineWidth',1);
    line([inflection.mouseVivo.fr.peakLocs,inflection.mouseVivo.fr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.EC(1) edges.FR.EC(end)])

% distance between IC and EC inflection points
inflection.distances.mouse = ...
    inflection.mouse.fr.peakLocs-inflection.mouseVivo.fr.peakLocs;
edges.FR.ECinAligned = (edges.FR.EC)+inflection.distances.mouse;

fr.mouseVivo.allAdj = log(fr.mouseVivo.all)+inflection.distances.mouse;    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(fr.mouseVivo.allAdj,edges.FR.ECinAligned,...
        'FaceColor', [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs],...
        [0,0.1],'color','k','linewidth',1,'linestyle','--');
    xlabel('firing rate (Hz)')
    ylabel('probability')
    axis tight
    xlim([edges.FR.ECinAligned(1) edges.FR.ECinAligned(end)])
    box off    
    
% based on inflection of in vivo data split fast and non-fast groups
narrowVivoInd = find(fr.mouseVivo.allAdj<inflection.mouse.fr.peakLocs);
narrowVivo = fr.mouseVivo.allAdj(narrowVivoInd);
broadVivoInd = find(fr.mouseVivo.allAdj>inflection.mouse.fr.peakLocs);
broadVivo = fr.mouseVivo.allAdj(broadVivoInd);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(narrowVivo,edges.FR.ECinAligned,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createFRFastECFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    h = histogram(broadVivo,edges.FR.ECinAligned,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createFRNonfastECFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'r','LineWidth',1);
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs],...
        [0,0.25],'color','k','linewidth',1,'linestyle','--');
    xlabel('firing rate (Hz)')
    ylabel('probability')
    xlim([edges.FR.ECinAligned(1) edges.FR.ECinAligned(end)])
    box off
 
% resample fast and non-fast groups according to min, inflection, max of ex
% vivo data
narrowVivoRe = rescale(narrowVivo,minFR,inflection.mouse.fr.peakLocs);
broadVivoRe = rescale(broadVivo,inflection.mouse.fr.peakLocs,maxFR);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(narrowVivoRe,edges.FR.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createT2PNarrowICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    h = histogram(broadVivoRe,edges.FR.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, gof] = createT2PBroadICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'r','LineWidth',1);
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs],...
        [0,0.25],'color','k','linewidth',1,'linestyle','--');
    xlabel('firing rate (Hz)')
    ylabel('probability')
    box off
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])
    
wfHist(narrowVivoInd) = narrowVivoRe;
wfHist(broadVivoInd) = broadVivoRe;
fr.mouseVivo.allAdjRe = wfHist;
    
    
% rescaling
% fr.mouse.allRe = rescale(log(fr.mouse.all),0.01,1);
% fr.mouseVivo.allRe = rescale(fr.mouseVivo.allAdjRe,0.01,1);
fr.mouse.allRe = log(fr.mouse.all);
fr.mouseVivo.allRe = fr.mouseVivo.allAdjRe;

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouse.all),edges.FR.IC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(fr.mouseVivo.allAdjRe,edges.FR.IC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])

close all
