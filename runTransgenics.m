%{
runTransgenics
- this generates the plots for fig 5
%}

% waveforms
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(X.mouse.all(list.mouse.Pyr,:)','Color','k','LineWidth',0.1)
    plot(X.mouse.all(list.mouse.VIP,:)','Color','b','LineWidth',0.1)
    plot(X.mouse.all(list.mouse.SST,:)','Color','g','LineWidth',0.1)
    plot(X.mouse.all(list.mouse.PV,:)','Color','r','LineWidth',0.1)
    ylabel('voltage')
    xlabel('time-steps (dt=0.02)')
    axis tight
    box off
    dim = [.6 .75 0 0];
    annotation('textbox',dim,'String','PV+','FitBoxToText','on',...
        'LineStyle','none','color','r');
    dim = [.6 .65 0 0];
    annotation('textbox',dim,'String','VIP+','FitBoxToText','on',...
        'LineStyle','none','color','b');
    dim = [.6 .7 0 0];
    annotation('textbox',dim,'String','SST+','FitBoxToText','on',...
        'LineStyle','none','color','g');
    dim = [.6 .6 0 0];
    annotation('textbox',dim,'String','Pyr','FitBoxToText','on',...
        'LineStyle','none','color','k');
    clear dim

% dV/dt for each cell type (inset)
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(mean(dVdt.mouse.all(list.mouse.Pyr,:))*-1,...
        'Color','k','LineWidth',0.25)
    plot(mean(dVdt.mouse.all(list.mouse.VIP,:))*-1,...
        'Color','b','LineWidth',0.25)
    plot(mean(dVdt.mouse.all(list.mouse.SST,:))*-1,...
        'Color','g','LineWidth',0.25)
    plot(mean(dVdt.mouse.all(list.mouse.PV,:))*-1,...
        'Color','r','LineWidth',0.25)
    ylabel('voltage')
    xlabel('time-steps (dt=0.02)')
    axis tight
    xlim([20 100])
    box off
    clear dim
    
% show translines are aspiny cells **** THIS FIGURE IS NOT IN THE PAPER ***
spinyParvList = list.mouse.spiny(find(ismember(...
    list.mouse.spiny,list.mouse.PV')==1));
spinyVIPList = list.mouse.spiny(find(ismember(...
    list.mouse.spiny,list.mouse.VIP')==1));
spinySSTList = list.mouse.spiny(find(ismember(...
    list.mouse.spiny,list.mouse.SST')==1));
spinyPyrList = list.mouse.spiny(find(ismember(...
    list.mouse.spiny,list.mouse.Pyr')==1));
aspinyParvList = list.mouse.aspiny(find(...
    ismember(list.mouse.aspiny,list.mouse.PV')==1));
aspinyVIPList = list.mouse.aspiny(find(...
    ismember(list.mouse.aspiny,list.mouse.VIP')==1));
aspinySSTList = list.mouse.aspiny(find(...
    ismember(list.mouse.aspiny,list.mouse.SST')==1));
aspinyPyrList = list.mouse.aspiny(find(...
    ismember(list.mouse.aspiny,list.mouse.Pyr')==1));
mat = [length(spinyParvList)/length(list.mouse.PV), ...
    length(aspinyParvList)/length(list.mouse.PV); ...
    length(spinySSTList)/length(list.mouse.SST), ...
    length(aspinySSTList)/length(list.mouse.SST);
    length(spinyVIPList)/length(list.mouse.VIP), ...
    length(aspinyVIPList)/length(list.mouse.VIP);...
    length(spinyPyrList)/length(list.mouse.Pyr), ...
    length(aspinyPyrList)/length(list.mouse.Pyr)];
figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    colormap('gray')
    h = colorbar;
    ylabel(h, 'percentage')
    xlabel('dendrite type')
    xticks([1,2])
    xticklabels({'spiny','aspiny'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'Parv','SST','VIP','Pyr'})
    axis equal
    axis tight
    box off
    dim = [.26 .92 0 0];
    annotation('textbox',dim,'String',int2str(length(spinyParvList)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .92 0 0];
    annotation('textbox',dim,'String',int2str(length(aspinyParvList)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.26 .74 0 0];
    annotation('textbox',dim,'String',int2str(length(spinySSTList)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .74 0 0];
    annotation('textbox',dim,'String',int2str(length(aspinySSTList)),...
        'FitBoxToText','on','LineStyle','none','color','k'); 
    dim = [.26 .57 0 0];
    annotation('textbox',dim,'String',int2str(length(spinyVIPList)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.38 .57 0 0];
    annotation('textbox',dim,'String',int2str(length(aspinyVIPList)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.23 .39 0 0];
    annotation('textbox',dim,'String',int2str(length(spinyPyrList)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.4 .39 0 0];
    annotation('textbox',dim,'String',int2str(length(aspinyPyrList)),...
        'FitBoxToText','on','LineStyle','none','color','w');

close all
clear spinyParvList spinyVIPList spinySSTList aspinyParvList aspinyVIPList ...
    aspinySSTList aspinyPyrList spinyPyrList mat h dim
    
%
% TROUGH-TO-PEAK MOUSE IC
%
    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(T2P.mouse.all(list.mouse.Pyr),edges.T2P.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none')
    histogram(T2P.mouse.all(list.mouse.VIP),edges.T2P.IC,...
        'FaceColor','b','Normalization','probability','EdgeColor','none')
    histogram(T2P.mouse.all(list.mouse.SST),edges.T2P.IC,...
        'FaceColor','g','Normalization','probability','EdgeColor','none')
    histogram(T2P.mouse.all(list.mouse.PV),edges.T2P.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none')
    histogram(T2P.mouse.all,edges.T2P.IC,...
        'FaceColor',[0.85,0.85,0.85],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.T2P.x,inflection.mouse.T2P.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.T2P.x,inflection.mouse.T2P.yfun2,'k','LineWidth',1);
    line([inflection.mouse.T2P.peakLocs,...
        inflection.mouse.T2P.peakLocs],[0,0.125], ...
        'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    axis tight
    xlim([0.1 1.35])
    
list.mouse.PVbelow = find(T2P.mouse.all(list.mouse.PV)<...
    inflection.mouse.T2P.peakLocs);
ParvNbelowBound = length(list.mouse.PVbelow);
list.mouse.PVabove = find(T2P.mouse.all(list.mouse.PV)>=...
    inflection.mouse.T2P.peakLocs);
ParvNaboveBound = length(list.mouse.PVabove);
list.mouse.VIPbelow = find(T2P.mouse.all(list.mouse.VIP)<...
    inflection.mouse.T2P.peakLocs);
VIPNbelowBound = length(list.mouse.VIPbelow);
list.mouse.VIPabove = find(T2P.mouse.all(list.mouse.VIP)>=...
    inflection.mouse.T2P.peakLocs);
VIPNaboveBound = length(list.mouse.VIPabove);
list.mouse.SSTbelow = find(T2P.mouse.all(list.mouse.SST)<...
    inflection.mouse.T2P.peakLocs);
SSTNbelowBound = length(list.mouse.SSTbelow);
list.mouse.SSTabove = find(T2P.mouse.all(list.mouse.SST)>=...
    inflection.mouse.T2P.peakLocs);
SSTNaboveBound = length(list.mouse.SSTabove);
list.mouse.PYRbelow = find(T2P.mouse.all(list.mouse.Pyr)<...
    inflection.mouse.T2P.peakLocs);
PYRNbelowBound = length(list.mouse.PYRbelow);
list.mouse.PYRabove = find(T2P.mouse.all(list.mouse.Pyr)>=...
    inflection.mouse.T2P.peakLocs);
PYRNaboveBound = length(list.mouse.PYRabove);
mat = [ParvNbelowBound/length(list.mouse.PV), ...
    ParvNaboveBound/length(list.mouse.PV); ...
    SSTNbelowBound/length(list.mouse.SST), ...
    SSTNaboveBound/length(list.mouse.SST);...
    VIPNbelowBound/length(list.mouse.VIP), ...
    VIPNaboveBound/length(list.mouse.VIP);...
    PYRNbelowBound/length(list.mouse.Pyr), ...
    PYRNaboveBound/length(list.mouse.Pyr)];

figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('spiking type')
    xticks([1,2])
    xticklabels({'narrow','broad'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','Pyr'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.24 .92 0 0];
    annotation('textbox',dim,'String',int2str(ParvNbelowBound),...
        'FitBoxToText','on','LineStyle','none');
    dim = [.41 .92 0 0];
    annotation('textbox',dim,'String',int2str(ParvNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.26 .75 0 0];
    annotation('textbox',dim,'String',int2str(SSTNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.39 .75 0 0];
    annotation('textbox',dim,'String',int2str(SSTNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.26 .57 0 0];
    annotation('textbox',dim,'String',int2str(VIPNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.39 .57 0 0];
    annotation('textbox',dim,'String',int2str(VIPNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.27 .39 0 0];
    annotation('textbox',dim,'String',int2str(PYRNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .39 0 0];
    annotation('textbox',dim,'String',int2str(PYRNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');

close all
clear ParvNbelowBound ParvNaboveBound SSTNbelowBound SSTNaboveBound ...
    VIPNbelowBound VIPNaboveBound PYRNbelowBound PYRNaboveBound mat dim h

% 
% FIRING RATE MOUSE IC
%

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(log(fr.mouse.all),edges.FR.IC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    close
    [wfFit.FR.mouseIC, ~] = createFRmouseICFit(wfCenters, wfCounts);
    inflection.mouse.fr = findIntersection(wfFit.FR.mouseIC,wfCenters);
    figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouse.all(list.mouse.Pyr)),edges.FR.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouse.all(list.mouse.VIP)),edges.FR.IC,...
        'FaceColor','b','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouse.all(list.mouse.SST)),edges.FR.IC,...
        'FaceColor','g','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouse.all(list.mouse.PV)),edges.FR.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouse.all),edges.FR.IC,'FaceColor',...
        [0.85 0.85 0.85],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.fr.x,inflection.mouse.fr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.fr.x,inflection.mouse.fr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs],...
        [0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])

list.mouse.PVbelow = find(log(fr.mouse.all(list.mouse.PV))<...
    inflection.mouse.fr.peakLocs);
ParvNbelowBound = length(list.mouse.PVbelow);
list.mouse.PVabove = find(log(fr.mouse.all(list.mouse.PV))>=...
    inflection.mouse.fr.peakLocs);
ParvNaboveBound = length(list.mouse.PVabove);
list.mouse.VIPbelow = find(log(fr.mouse.all(list.mouse.VIP))<...
    inflection.mouse.fr.peakLocs);
VIPNbelowBound = length(list.mouse.VIPbelow);
list.mouse.VIPabove = find(log(fr.mouse.all(list.mouse.VIP))>=...
    inflection.mouse.fr.peakLocs);
VIPNaboveBound = length(list.mouse.VIPabove);
list.mouse.SSTbelow = find(log(fr.mouse.all(list.mouse.SST))<...
    inflection.mouse.fr.peakLocs);
SSTNbelowBound = length(list.mouse.SSTbelow);
list.mouse.SSTabove = find(log(fr.mouse.all(list.mouse.SST))>=...
    inflection.mouse.fr.peakLocs);
SSTNaboveBound = length(list.mouse.SSTabove);
list.mouse.PYRbelow = find(log(fr.mouse.all(list.mouse.Pyr))<...
    inflection.mouse.fr.peakLocs);
PYRNbelowBound = length(list.mouse.PYRbelow);
list.mouse.PYRabove = find(log(fr.mouse.all(list.mouse.Pyr))>=...
    inflection.mouse.fr.peakLocs);
PYRNaboveBound = length(list.mouse.PYRabove);
mat = [ParvNbelowBound/length(list.mouse.PV), ...
    ParvNaboveBound/length(list.mouse.PV); ...
    SSTNbelowBound/length(list.mouse.SST), ...
    SSTNaboveBound/length(list.mouse.SST);...
    VIPNbelowBound/length(list.mouse.VIP), ...
    VIPNaboveBound/length(list.mouse.VIP);...
    PYRNbelowBound/length(list.mouse.Pyr), ...
    PYRNaboveBound/length(list.mouse.Pyr)];

figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('spiking type')
    xticks([1,2])
    xticklabels({'non-fast','fast'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','Pyr'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.28 .93 0 0];
    annotation('textbox',dim,'String',int2str(ParvNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .93 0 0];
    annotation('textbox',dim,'String',int2str(ParvNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.26 .79 0 0];
    annotation('textbox',dim,'String',int2str(SSTNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.38 .79 0 0];
    annotation('textbox',dim,'String',int2str(SSTNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.26 .64 0 0];
    annotation('textbox',dim,'String',int2str(VIPNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.38 .64 0 0];
    annotation('textbox',dim,'String',int2str(VIPNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.25 .5 0 0];
    annotation('textbox',dim,'String',int2str(PYRNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.39 .5 0 0];
    annotation('textbox',dim,'String',int2str(PYRNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    
close all
    
%
% TROUGH-TO-PEAK RATIO MOUSE IC
%
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(p2tr.mouse.all,edges.P2TR.IC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    close
    [wfFit.P2TR.mouseIC, ~] = createT2PRmouseICFit(wfCenters, wfCounts);
    inflection.mouse.p2tr = findIntersection(wfFit.P2TR.mouseIC,wfCenters);
    figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouse.all(list.mouse.Pyr),edges.P2TR.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouse.all(list.mouse.VIP),edges.P2TR.IC,...
        'FaceColor','b','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouse.all(list.mouse.SST),edges.P2TR.IC,...
        'FaceColor','g','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouse.all(list.mouse.PV),edges.P2TR.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouse.all,edges.P2TR.IC,'FaceColor',...
        [0.85 0.85 0.85],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.p2tr.peakLocs,inflection.mouse.p2tr.peakLocs],...
        [0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.P2TR.IC(1) edges.P2TR.IC(end)])
    
    
list.mouse.PVbelow = find(p2tr.mouse.all(list.mouse.PV)<...
    inflection.mouse.p2tr.peakLocs);
ParvNbelowBound = length(list.mouse.PVbelow);
list.mouse.PVabove = find(p2tr.mouse.all(list.mouse.PV)>=...
    inflection.mouse.p2tr.peakLocs);
ParvNaboveBound = length(list.mouse.PVabove);
list.mouse.VIPbelow = find(p2tr.mouse.all(list.mouse.VIP)<...
    inflection.mouse.p2tr.peakLocs);
VIPNbelowBound = length(list.mouse.VIPbelow);
list.mouse.VIPabove = find(p2tr.mouse.all(list.mouse.VIP)>=...
    inflection.mouse.p2tr.peakLocs);
VIPNaboveBound = length(list.mouse.VIPabove);
list.mouse.SSTbelow = find(p2tr.mouse.all(list.mouse.SST)<...
    inflection.mouse.p2tr.peakLocs);
SSTNbelowBound = length(list.mouse.SSTbelow);
list.mouse.SSTabove = find(p2tr.mouse.all(list.mouse.SST)>=...
    inflection.mouse.p2tr.peakLocs);
SSTNaboveBound = length(list.mouse.SSTabove);
list.mouse.PYRbelow = find(p2tr.mouse.all(list.mouse.Pyr)<...
    inflection.mouse.p2tr.peakLocs);
PYRNbelowBound = length(list.mouse.PYRbelow);
list.mouse.PYRabove = find(p2tr.mouse.all(list.mouse.Pyr)>=...
    inflection.mouse.p2tr.peakLocs);
PYRNaboveBound = length(list.mouse.PYRabove);
mat = [ParvNbelowBound/length(list.mouse.PV), ...
    ParvNaboveBound/length(list.mouse.PV); ...
    SSTNbelowBound/length(list.mouse.SST), ...
    SSTNaboveBound/length(list.mouse.SST);...
    VIPNbelowBound/length(list.mouse.VIP), ...
    VIPNaboveBound/length(list.mouse.VIP);...
    PYRNbelowBound/length(list.mouse.Pyr), ...
    PYRNaboveBound/length(list.mouse.Pyr)];

figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('trough-to-peak ratio')
    xticks([1,2])
    xticklabels({'low','high'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','Pyr'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.24 .93 0 0];
    annotation('textbox',dim,'String',int2str(ParvNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.4 .93 0 0];
    annotation('textbox',dim,'String',int2str(ParvNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.26 .76 0 0];
    annotation('textbox',dim,'String',int2str(SSTNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.38 .76 0 0];
    annotation('textbox',dim,'String',int2str(SSTNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.27 .58 0 0];
    annotation('textbox',dim,'String',int2str(VIPNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.39 .58 0 0];
    annotation('textbox',dim,'String',int2str(VIPNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.27 .4 0 0];
    annotation('textbox',dim,'String',int2str(PYRNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .4 0 0];
    annotation('textbox',dim,'String',int2str(PYRNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    
close all

%{
EC cells
%}
removeCells = [1:61, 63:245, 247:263]; % to remove cells 62 and 246
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(X.mouseVivo.all(list.mouseVivo.broad(removeCells),:)','Color','k','LineWidth',0.1)
    plot(X.mouseVivo.all(list.mouseVivo.VIP,:)','Color','b','LineWidth',0.1)
    plot(X.mouseVivo.all(list.mouseVivo.SST,:)','Color','g','LineWidth',0.1)
    plot(X.mouseVivo.all(list.mouseVivo.PV,:)','Color','r','LineWidth',0.1)
    ylabel('voltage')
    xlabel('time-steps (dt=0.02)')
    axis tight
    box off
    axis off
    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(mean(X.mouseVivo.all(list.mouseVivo.broad(removeCells),:)),'Color','k','LineWidth',0.1)
    plot(mean(X.mouseVivo.all(list.mouseVivo.VIP,:)),'Color','b','LineWidth',0.1)
    plot(mean(X.mouseVivo.all(list.mouseVivo.SST,:)),'Color','g','LineWidth',0.1)
    plot(mean(X.mouseVivo.all(list.mouseVivo.PV,:)),'Color','r','LineWidth',0.1)
    ylabel('voltage')
    xlabel('time-steps (dt=0.02)')
    axis tight
    box off
    axis off
    
%
% TROUGH-TO-PEAK MOUSE EC
%
meanNarrowPVp2t = mean(T2P.mouseVivo.all(list.mouseVivo.PV));
meanNarrowSSTp2t = mean(T2P.mouseVivo.all(list.mouseVivo.SST));
meanNarrowVIPp2t = mean(T2P.mouseVivo.all(list.mouseVivo.VIP));
meanPyrp2t = mean(T2P.mouseVivo.all(list.mouseVivo.broad));
wfHist = T2P.mouseVivo.all;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    line([meanNarrowPVp2t,meanNarrowPVp2t],[0,0.4],...
        'color','r','linewidth',1,'linestyle','--');
    line([meanNarrowSSTp2t,meanNarrowSSTp2t],[0,0.4],...
        'color','g','linewidth',1,'linestyle','--');
    line([meanNarrowVIPp2t,meanNarrowVIPp2t],[0,0.4],...
        'color','b','linewidth',1,'linestyle','--');
    line([meanPyrp2t,meanPyrp2t],[0,0.4],...
        'color','k','linewidth',1,'linestyle','--');
    histogram(wfHist(list.mouseVivo.broad),edges.T2P.EC,'FaceColor','k',...
        'Normalization','probability','EdgeColor','none');
    histogram(wfHist(list.mouseVivo.VIP),edges.T2P.EC,'FaceColor','b',...
        'Normalization','probability','EdgeColor','none');
    histogram(wfHist(list.mouseVivo.SST),edges.T2P.EC,'FaceColor','g',...
        'Normalization','probability','EdgeColor','none');
    histogram(wfHist(list.mouseVivo.PV),edges.T2P.EC,'FaceColor','r',...
        'Normalization','probability','EdgeColor','none');
    histogram(wfHist,edges.T2P.EC,'FaceColor',[0.85,0.85,0.85],...
        'Normalization','probability','EdgeColor','none');
    plot(inflection.mouseEC.T2P.x,inflection.mouseEC.T2P.yfun1,'k','LineWidth',1);
    plot(inflection.mouseEC.T2P.x,inflection.mouseEC.T2P.yfun2,'k','LineWidth',1);
    line([inflection.mouseEC.T2P.peakLocs,...
        inflection.mouseEC.T2P.peakLocs],[0,0.12],...
        'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    axis tight
    xlim([edges.T2P.EC(1) edges.T2P.EC(end)])
    box off
    
% classify narrow and broad versus cell types
list.mouseVivo.PVbelow = find(T2P.mouseVivo.all(list.mouseVivo.PV)<...
    inflection.mouseEC.T2P.peakLocs);
ParvNbelowBound = length(list.mouseVivo.PVbelow);
list.mouseVivo.PVabove = find(T2P.mouseVivo.all(list.mouseVivo.PV)>=...
    inflection.mouseEC.T2P.peakLocs);
ParvNaboveBound = length(list.mouseVivo.PVabove);
list.mouseVivo.VIPbelow = find(T2P.mouseVivo.all(list.mouseVivo.VIP)<...
    inflection.mouseEC.T2P.peakLocs);
VIPNbelowBound = length(list.mouseVivo.VIPbelow);
list.mouseVivo.VIPabove = find(T2P.mouseVivo.all(list.mouseVivo.VIP)>=...
    inflection.mouseEC.T2P.peakLocs);
VIPNaboveBound = length(list.mouseVivo.VIPabove);
list.mouseVivo.SSTbelow = find(T2P.mouseVivo.all(list.mouseVivo.SST)<...
    inflection.mouseEC.T2P.peakLocs);
SSTNbelowBound = length(list.mouseVivo.SSTbelow);
list.mouseVivo.SSTabove = find(T2P.mouseVivo.all(list.mouseVivo.SST)>=...
    inflection.mouseEC.T2P.peakLocs);
SSTNaboveBound = length(list.mouseVivo.SSTabove);
list.mouseVivo.PYRbelow = find(T2P.mouseVivo.all(list.mouseVivo.broad)<...
    inflection.mouseEC.T2P.peakLocs);
PYRNbelowBound = length(list.mouseVivo.PYRbelow);
list.mouseVivo.PYRabove = find(T2P.mouseVivo.all(list.mouseVivo.broad)>=...
    inflection.mouseEC.T2P.peakLocs);
PYRNaboveBound = length(list.mouseVivo.PYRabove);
mat = [ParvNbelowBound/length(list.mouseVivo.PV), ...
    ParvNaboveBound/length(list.mouseVivo.PV); ...
    SSTNbelowBound/length(list.mouseVivo.SST), ...
    SSTNaboveBound/length(list.mouseVivo.SST);...
    VIPNbelowBound/length(list.mouseVivo.VIP), ...
    VIPNaboveBound/length(list.mouseVivo.VIP);...
    PYRNbelowBound/length(list.mouseVivo.broad), ...
    PYRNaboveBound/length(list.mouseVivo.broad)];

figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('spiking type')
    xticks([1,2])
    xticklabels({'narrow','broad'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','Pyr'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.24 .92 0 0];
    annotation('textbox',dim,'String',int2str(ParvNbelowBound),...
        'FitBoxToText','on','LineStyle','none');
    dim = [.41 .92 0 0];
    annotation('textbox',dim,'String',int2str(ParvNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.26 .75 0 0];
    annotation('textbox',dim,'String',int2str(SSTNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.39 .75 0 0];
    annotation('textbox',dim,'String',int2str(SSTNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.26 .57 0 0];
    annotation('textbox',dim,'String',int2str(VIPNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.39 .57 0 0];
    annotation('textbox',dim,'String',int2str(VIPNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.27 .39 0 0];
    annotation('textbox',dim,'String',int2str(PYRNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .39 0 0];
    annotation('textbox',dim,'String',int2str(PYRNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');

prop.lostInterneuronsEC.PV = ParvNaboveBound/length(list.mouseVivo.PV);
prop.lostInterneuronsEC.SST = SSTNaboveBound/length(list.mouseVivo.SST);
prop.lostInterneuronsEC.VIP = VIPNaboveBound/length(list.mouseVivo.VIP);
    
cellTypeClassificationT2P

close all
clear ParvNbelowBound ParvNaboveBound SSTNbelowBound SSTNaboveBound ...
    VIPNbelowBound VIPNaboveBound PYRNbelowBound PYRNaboveBound mat dim h

%
% TROUGH-TO-PEAK RATIO MOUSE EC
%
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(p2tr.mouseVivo.all,edges.P2TR.EC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    close
    [wfFit.P2TR.mouseEC, ~] = createT2PRmouseECFit(wfCenters, wfCounts);
    wfFitCurveS = wfFit.P2TR.mouseEC(wfCenters);
    [~,inflection.mouseVivo.p2tr] = findpeaks(wfFitCurveS);
    inflection.mouseVivo.p2tr = wfCenters(inflection.mouseVivo.p2tr);
    figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouseVivo.all(list.mouseVivo.broad),edges.P2TR.EC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouseVivo.all(list.mouseVivo.VIP),edges.P2TR.EC,...
        'FaceColor','b','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouseVivo.all(list.mouseVivo.SST),edges.P2TR.EC,...
        'FaceColor','g','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouseVivo.all(list.mouseVivo.PV),edges.P2TR.EC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouseVivo.all,edges.P2TR.EC,'FaceColor',...
        [0.85 0.85 0.85],'Normalization','probability','EdgeColor','none');
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    line([inflection.mouseVivo.p2tr,inflection.mouseVivo.p2tr],[0,0.2],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.P2TR.EC(1) edges.P2TR.EC(end)])
    
    
list.mouseVivo.PVbelow = find(p2tr.mouseVivo.all(list.mouseVivo.PV)<inflection.mouseVivo.p2tr);
ParvNbelowBound = length(list.mouseVivo.PVbelow);
list.mouseVivo.PVabove = find(p2tr.mouseVivo.all(list.mouseVivo.PV)>=inflection.mouseVivo.p2tr);
ParvNaboveBound = length(list.mouseVivo.PVabove);
list.mouseVivo.VIPbelow = find(p2tr.mouseVivo.all(list.mouseVivo.VIP)<inflection.mouseVivo.p2tr);
VIPNbelowBound = length(list.mouseVivo.VIPbelow);
list.mouseVivo.VIPabove = find(p2tr.mouseVivo.all(list.mouseVivo.VIP)>=inflection.mouseVivo.p2tr);
VIPNaboveBound = length(list.mouseVivo.VIPabove);
list.mouseVivo.SSTbelow = find(p2tr.mouseVivo.all(list.mouseVivo.SST)<inflection.mouseVivo.p2tr);
SSTNbelowBound = length(list.mouseVivo.SSTbelow);
list.mouseVivo.SSTabove = find(p2tr.mouseVivo.all(list.mouseVivo.SST)>=inflection.mouseVivo.p2tr);
SSTNaboveBound = length(list.mouseVivo.SSTabove);
list.mouseVivo.PYRbelow = find(p2tr.mouseVivo.all(list.mouseVivo.broad)<inflection.mouseVivo.p2tr);
PYRNbelowBound = length(list.mouseVivo.PYRbelow);
list.mouseVivo.PYRabove = find(p2tr.mouseVivo.all(list.mouseVivo.broad)>=inflection.mouseVivo.p2tr);
PYRNaboveBound = length(list.mouseVivo.PYRabove);
mat = [ParvNbelowBound/length(list.mouseVivo.PV), ...
    ParvNaboveBound/length(list.mouseVivo.PV); ...
    SSTNbelowBound/length(list.mouseVivo.SST), ...
    SSTNaboveBound/length(list.mouseVivo.SST);...
    VIPNbelowBound/length(list.mouseVivo.VIP), ...
    VIPNaboveBound/length(list.mouseVivo.VIP);...
    PYRNbelowBound/length(list.mouseVivo.broad), ...
    PYRNaboveBound/length(list.mouseVivo.broad)];

figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('trough-to-peak ratio')
    xticks([1,2])
    xticklabels({'low','high'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','broad'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.26 .93 0 0];
    annotation('textbox',dim,'String',int2str(ParvNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.39 .93 0 0];
    annotation('textbox',dim,'String',int2str(ParvNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.26 .76 0 0];
    annotation('textbox',dim,'String',int2str(SSTNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.39 .76 0 0];
    annotation('textbox',dim,'String',int2str(SSTNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.27 .58 0 0];
    annotation('textbox',dim,'String',int2str(VIPNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.39 .58 0 0];
    annotation('textbox',dim,'String',int2str(VIPNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.27 .4 0 0];
    annotation('textbox',dim,'String',int2str(PYRNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.37 .4 0 0];
    annotation('textbox',dim,'String',int2str(PYRNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    
cellTypeClassificationT2PR
    
close all

% EC firing rates
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(log(fr.mouseVivo.all),edges.FR.EC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    close
    [wfFit.FR.mouseEC, gof] = createFRmouseECFit(wfCenters, wfCounts);
    wfFit.FR.mouseEC.a1 = wfFit.FR.mouseEC.a1*2;
    inflection.mouseVivo.fr = findIntersection(wfFit.FR.mouseEC,wfCenters);
%     wfFitCurveS = fitresult(wfCenters);
%     [~,in] = findpeaks(wfFitCurveS*-1);
%     in = wfCenters(in);
    in = 1.74;
    figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouseVivo.all(list.mouseVivo.broad)),edges.FR.EC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouseVivo.all(list.mouseVivo.VIP)),edges.FR.EC,...
        'FaceColor','b','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouseVivo.all(list.mouseVivo.SST)),edges.FR.EC,...
        'FaceColor','g','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouseVivo.all(list.mouseVivo.PV)),edges.FR.EC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouseVivo.all),edges.FR.EC,'FaceColor',...
        [0.85 0.85 0.85],'Normalization','probability','EdgeColor','none');
%     plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    plot(inflection.mouseVivo.fr.x,inflection.mouseVivo.fr.yfun1,'k','LineWidth',1);
    plot(inflection.mouseVivo.fr.x,inflection.mouseVivo.fr.yfun2,'k','LineWidth',1);
    line([inflection.mouseVivo.fr.peakLocs,...
        inflection.mouseVivo.fr.peakLocs],[0,0.2],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.EC(1) edges.FR.EC(end)])
    
    
list.mouseVivo.PVbelow = find(log(fr.mouseVivo.all(list.mouseVivo.PV))<inflection.mouseVivo.fr.peakLocs);
ParvNbelowBound = length(list.mouseVivo.PVbelow);
list.mouseVivo.PVabove = find(log(fr.mouseVivo.all(list.mouseVivo.PV))>=inflection.mouseVivo.fr.peakLocs);
ParvNaboveBound = length(list.mouseVivo.PVabove);
list.mouseVivo.VIPbelow = find(log(fr.mouseVivo.all(list.mouseVivo.VIP))<inflection.mouseVivo.fr.peakLocs);
VIPNbelowBound = length(list.mouseVivo.VIPbelow);
list.mouseVivo.VIPabove = find(log(fr.mouseVivo.all(list.mouseVivo.VIP))>=inflection.mouseVivo.fr.peakLocs);
VIPNaboveBound = length(list.mouseVivo.VIPabove);
list.mouseVivo.SSTbelow = find(log(fr.mouseVivo.all(list.mouseVivo.SST))<inflection.mouseVivo.fr.peakLocs);
SSTNbelowBound = length(list.mouseVivo.SSTbelow);
list.mouseVivo.SSTabove = find(log(fr.mouseVivo.all(list.mouseVivo.SST))>=inflection.mouseVivo.fr.peakLocs);
SSTNaboveBound = length(list.mouseVivo.SSTabove);
list.mouseVivo.PYRbelow = find(log(fr.mouseVivo.all(list.mouseVivo.broad))<inflection.mouseVivo.fr.peakLocs);
PYRNbelowBound = length(list.mouseVivo.PYRbelow);
list.mouseVivo.PYRabove = find(log(fr.mouseVivo.all(list.mouseVivo.broad))>=inflection.mouseVivo.fr.peakLocs);
PYRNaboveBound = length(list.mouseVivo.PYRabove);
mat = [ParvNbelowBound/length(list.mouseVivo.PV), ...
    ParvNaboveBound/length(list.mouseVivo.PV); ...
    SSTNbelowBound/length(list.mouseVivo.SST), ...
    SSTNaboveBound/length(list.mouseVivo.SST);...
    VIPNbelowBound/length(list.mouseVivo.VIP), ...
    VIPNaboveBound/length(list.mouseVivo.VIP);...
    PYRNbelowBound/length(list.mouseVivo.broad), ...
    PYRNaboveBound/length(list.mouseVivo.broad)];

figure('Position',[50 50 200 150]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('spiking type')
    xticks([1,2])
    xticklabels({'non-fast','fast'})
    ylabel('cell type')
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','broad'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.26 .94 0 0];
    annotation('textbox',dim,'String',int2str(ParvNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.38 .94 0 0];
    annotation('textbox',dim,'String',int2str(ParvNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.26 .79 0 0];
    annotation('textbox',dim,'String',int2str(SSTNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.38 .79 0 0];
    annotation('textbox',dim,'String',int2str(SSTNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.27 .64 0 0];
    annotation('textbox',dim,'String',int2str(VIPNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.39 .64 0 0];
    annotation('textbox',dim,'String',int2str(VIPNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.26 .5 0 0];
    annotation('textbox',dim,'String',int2str(PYRNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.39 .5 0 0];
    annotation('textbox',dim,'String',int2str(PYRNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    
cellTypeClassificationFR
    
close all