%{
T2Prescaling
%}

close all



minHWdVdt = min(T2P.mouse.all);
maxHWdVdt = max(T2P.mouse.all);

% mouse IC trough to peak w inflection
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(T2P.mouse.all,edges.T2P.ECrescaleFig,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [wfFit.T2P.mouseICrescaleFig,~] = createT2PmouseICFit(wfCenters, wfCounts);
    inflection.mouse.T2PrescaleFig = findIntersection(wfFit.T2P.mouseICrescaleFig,wfCenters);
    plot(inflection.mouse.T2PrescaleFig.x,inflection.mouse.T2PrescaleFig.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.T2PrescaleFig.x,inflection.mouse.T2PrescaleFig.yfun2,'k','LineWidth',1);
    line([inflection.mouse.T2PrescaleFig.peakLocs,...
        inflection.mouse.T2PrescaleFig.peakLocs],[0,0.08], ...
            'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-peak (ms)')
    ylabel('probability')
    legend({'data','model','inflection'},'Location','northeast')
    legend boxoff 
    axis tight
    xlim([edges.T2P.ECrescaleFig(1) edges.T2P.ECrescaleFig(end)])
    
% split ex vivo into narrow and broad and establish fit w unimodal Gaussian
narrowInd = find(T2P.mouse.all<=inflection.mouse.T2PrescaleFig.peakLocs);
narrow = T2P.mouse.all(narrowInd);
broadInd = find(T2P.mouse.all>inflection.mouse.T2PrescaleFig.peakLocs);
broad = T2P.mouse.all(broadInd);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(narrow,edges.T2P.ECrescaleFig,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultNarrowSW, ~] = createT2PNarrowICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultNarrowSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'r','LineWidth',1);
    
    h = histogram(broad,edges.T2P.ECrescaleFig,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createT2PBroadICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    line([inflection.mouse.T2PrescaleFig.peakLocs,...
        inflection.mouse.T2PrescaleFig.peakLocs],[0,0.2], ...
            'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    axis tight
    xlim([edges.T2P.ECrescaleFig(1) edges.T2P.ECrescaleFig(end)])
    box off

% get fit for in vivo spike width data
wfHist = T2P.mouseVivo.all;
minHWdVdtEC = min(wfHist);
maxHWdVdtEC = max(wfHist);
edges.T2P.ECmouse = minHWdVdtEC-0.05:(maxHWdVdtEC-minHWdVdtEC)/21:maxHWdVdtEC;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(wfHist,edges.T2P.EC,'FaceColor',[0.2 0.2 0.2],...
        'Normalization','probability','EdgeColor','none');
    plot(inflection.mouseEC.T2P.x,inflection.mouseEC.T2P.yfun1,'k','LineWidth',1);
    plot(inflection.mouseEC.T2P.x,inflection.mouseEC.T2P.yfun2,'k','LineWidth',1);
    line([inflection.mouseEC.T2P.peakLocs,...
        inflection.mouseEC.T2P.peakLocs],[0,0.12],...
        'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
%     legend({'data','model','inflection'},'Location','northeast')
%     legend boxoff
    axis tight
    xlim([edges.T2P.ECmouse(1) edges.T2P.ECmouse(end)])
    box off
    
% distance between high and low res estimates
inflection.mouseEC.t2pDelta = ...
    inflection.mouse.T2P.peakLocs-inflection.mouseEC.T2P.peakLocs; 
% distance between IC and EC inflection points
inflection.distances.mouse = ...
    inflection.mouse.T2P.peakLocs-inflection.mouseEC.T2P.peakLocs;
edges.T2P.ECinAligned = (edges.T2P.ECmouse)+inflection.distances.mouse;

T2P.mouseVivo.allAdj = T2P.mouseVivo.all+inflection.distances.mouse;    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(T2P.mouseVivo.allAdj,edges.T2P.ECinAligned,...
        'FaceColor', [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    line([inflection.mouse.T2PrescaleFig.peakLocs,inflection.mouse.T2PrescaleFig.peakLocs],...
        [0,0.1],'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    axis tight
    xlim([edges.T2P.ECinAligned(1) edges.T2P.ECinAligned(end)])
    box off
    
% based on inflection of in vivo data split narrow and broad groups
narrowVivoInd = find(T2P.mouseVivo.allAdj<inflection.mouse.T2PrescaleFig.peakLocs);
narrowVivo = T2P.mouseVivo.allAdj(narrowVivoInd);
broadVivoInd = find(T2P.mouseVivo.allAdj>inflection.mouse.T2PrescaleFig.peakLocs);
broadVivo = T2P.mouseVivo.allAdj(broadVivoInd);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(narrowVivo,edges.T2P.ECinAligned,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createT2PNarrowECFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'r','LineWidth',1);
    h = histogram(broadVivo,edges.T2P.ECinAligned,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createT2PBroadECFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    line([inflection.mouse.T2PrescaleFig.peakLocs,inflection.mouse.T2PrescaleFig.peakLocs],...
        [0,0.25],'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    xlim([edges.T2P.ECinAligned(1) edges.T2P.ECinAligned(end)])
    box off

% resample narrow and broad groups according to min, inflection, max of ex
% vivo data
narrowVivoRe = rescale(narrowVivo,minHWdVdt,inflection.mouse.T2PrescaleFig.peakLocs);
broadVivoRe = rescale(broadVivo,inflection.mouse.T2PrescaleFig.peakLocs,maxHWdVdt);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(narrowVivoRe,edges.T2P.ECrescaleFig,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createT2PNarrowICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'r','LineWidth',1);
    h = histogram(broadVivoRe,edges.T2P.ECrescaleFig,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [fitresultBroadSW, ~] = createT2PBroadICFit(wfCenters, wfCounts);
    wfFitCurveS = fitresultBroadSW(wfCenters);
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    line([inflection.mouse.T2PrescaleFig.peakLocs,inflection.mouse.T2PrescaleFig.peakLocs],...
        [0,0.25],'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (arb.)')
    ylabel('probability')
    box off
    axis tight
    xlim([edges.T2P.ECrescaleFig(1) edges.T2P.ECrescaleFig(end)])

% put narrow and broad back together
wfHist(narrowVivoInd) = narrowVivoRe;
wfHist(broadVivoInd) = broadVivoRe;
T2P.mouseVivo.allAdjRe = wfHist;

% FINALLY rescale to min max zero and 1
% this step was performed for trough-to-peak ratio and firing rate; but for
% trough-to-peak the min and max were within the range of 0 and 1 which
% matched other standardized distributions, and after rescaling is done the
% inflection points are misaligned even more than when we started the
% analysis!!
% hwdVdt.mouse.allRe = rescale(hwdVdt.mouse.all,0,1);
% lt.mouseVivo.allRe = rescale(lt.mouseVivo.allAdjRe,0,1);
T2P.mouse.allRe = T2P.mouse.all;
T2P.mouseVivo.allRe = T2P.mouseVivo.allAdjRe;

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(T2P.mouse.all,edges.T2P.ECrescaleFig,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    line([inflection.mouse.T2PrescaleFig.peakLocs,inflection.mouse.T2PrescaleFig.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak')
    axis tight
    xlim([edges.T2P.ECrescaleFig(1) edges.T2P.ECrescaleFig(end)])

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(T2P.mouseVivo.allAdjRe,edges.T2P.ECrescaleFig,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    line([inflection.mouse.T2PrescaleFig.peakLocs,inflection.mouse.T2PrescaleFig.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak')
    axis tight
    xlim([edges.T2P.ECrescaleFig(1) edges.T2P.ECrescaleFig(end)])
close all

clear broad broadInd broadVivo broadVivoInd broadVivoRe fitresult ...
    fitresultBroadSW fitresultNarrowSW i loc mat maxHWdVdt ...
    maxHWdVdtEC meanBroadvivop2t meanNarrowPVp2t meanNarrowSSTp2t ...
    meanNarrowVIPp2t meanPVvivop2t meanPyrp2t meanSSTvivop2t ...
    minHWdVdt minHWdVdtEC n narrow narrowInd narrowVivo narrowVivoInd...
    narrowVivoRe vec wfCenters wfCounts wfFitCurveS wfHist