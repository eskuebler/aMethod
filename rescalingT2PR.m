%{
T2PRrescaling
%}

close all

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouse.all,edges.P2TR.IC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.p2tr.peakLocs,inflection.mouse.p2tr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.P2TR.IC(1) edges.P2TR.IC(end)])
    
wfHist = p2tr.mouseVivo.all;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
h = histogram(wfHist,edges.P2TR.EC,...
    'FaceColor','k','Normalization','probability');
wfCounts = [0,h.Values];
wfCenters = h.BinEdges;
close
[fitresult, ~] = createT2PRmouseECFit(wfCenters, wfCounts);
wfFitCurveS = fitresult(wfCenters);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(wfHist,edges.P2TR.EC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability','EdgeColor','none')
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    xlabel('trough-to-peak ratio')
    ylabel('probability')    
    axis tight
    xlim([edges.P2TR.EC(1) edges.P2TR.EC(end)]) 
    box off

% rescale
p2tr.mouse.allRe = rescale(p2tr.mouse.all,0.01,1);
p2tr.mouseVivo.allRe = rescale(p2tr.mouseVivo.all,0.01,1);

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouse.allRe,edges.standardized,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.standardized(1) edges.standardized(end)])

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouseVivo.allRe,edges.standardized,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.standardized(1) edges.standardized(end)])
    
close all