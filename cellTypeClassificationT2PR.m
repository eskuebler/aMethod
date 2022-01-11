% cellTypeClassificationT2PR

close all

% means for IC of standardized distribution
meanPVic = mean(p2tr.mouse.all(list.mouse.PV));
meanSSTic = mean(p2tr.mouse.all(list.mouse.SST));
meanVIPic = mean(p2tr.mouse.all(list.mouse.VIP));
meanPyric = mean(p2tr.mouse.all(list.mouse.Pyr));

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouse.all(list.mouse.Pyr),edges.P2TR.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none')
    histogram(p2tr.mouse.all(list.mouse.PV),edges.P2TR.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none')
    histogram(p2tr.mouse.all(list.mouse.SST),edges.P2TR.IC,...
        'FaceColor','g','Normalization','probability','EdgeColor','none')
    histogram(p2tr.mouse.all(list.mouse.VIP),edges.P2TR.IC,...
        'FaceColor','b','Normalization','probability','EdgeColor','none')
    line([meanPVic,meanPVic],[0,0.62], ...
        'color','r','linewidth',1,'linestyle','--');
    line([meanSSTic,meanSSTic],[0,0.62], ...
        'color','g','linewidth',1,'linestyle','--');
    line([meanVIPic,meanVIPic],[0,0.62], ...
        'color','b','linewidth',1,'linestyle','--');
    line([meanPyric,meanPyric],[0,0.62], ...
        'color','k','linewidth',1,'linestyle','--');
    histogram(p2tr.mouse.all,edges.P2TR.IC,...
        'FaceColor',[0.85 0.85 0.85],'Normalization','probability','EdgeColor','none')
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.p2tr.peakLocs,inflection.mouse.p2tr.peakLocs]...
        ,[0,0.62],'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak ratio')
    ylabel('probability')
    axis tight
    xlim([edges.P2TR.EC(1) edges.P2TR.EC(end)]) 
    box off

% means for IC of standardized distribution
meanPVec = mean(p2tr.mouseVivo.all(list.mouseVivo.PV));
meanSSTec = mean(p2tr.mouseVivo.all(list.mouseVivo.SST));
meanVIPec = mean(p2tr.mouseVivo.all(list.mouseVivo.VIP));
meanBROADec = mean(p2tr.mouseVivo.all(list.mouseVivo.broad));

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(p2tr.mouseVivo.all,edges.P2TR.EC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    close
    [wfFit.P2TR.mouseEC, gof] = createT2PRmouseECFit(wfCenters, wfCounts);
    wfFitCurveS = wfFit.P2TR.mouseEC(wfCenters);
    [~,inflection.mouseVivo.p2tr] = findpeaks(wfFitCurveS);
    inflection.mouseVivo.p2tr = wfCenters(inflection.mouseVivo.p2tr);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouseVivo.all(list.mouseVivo.broad),...
        edges.P2TR.EC,'FaceColor','k','Normalization','probability','EdgeColor','none')
    histogram(p2tr.mouseVivo.all(list.mouseVivo.PV),...
        edges.P2TR.EC,'FaceColor','r','Normalization','probability','EdgeColor','none')
    histogram(p2tr.mouseVivo.all(list.mouseVivo.SST),...
        edges.P2TR.EC,'FaceColor','g','Normalization','probability','EdgeColor','none') 
    histogram(p2tr.mouseVivo.all(list.mouseVivo.VIP),...
        edges.P2TR.EC,'FaceColor','b','Normalization','probability','EdgeColor','none') 
    line([meanPVec,meanPVec],[0,0.39], ...
        'color','r','linewidth',1,'linestyle','--');
    line([meanSSTec,meanSSTec],[0,0.39], ...
        'color','g','linewidth',1,'linestyle','--');
    line([meanVIPec,meanVIPec],[0,0.39], ...
        'color','b','linewidth',1,'linestyle','--');
    line([meanBROADec,meanBROADec],[0,0.39], ...
        'color','k','linewidth',1,'linestyle','--');
    histogram(p2tr.mouseVivo.all,edges.P2TR.EC,...
        'FaceColor',[0.85 0.85 0.85],'Normalization','probability','EdgeColor','none')
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    line([inflection.mouseVivo.p2tr,inflection.mouseVivo.p2tr],...
        [0,0.16],'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak ratio')
    ylabel('probability')
    axis tight
    xlim([edges.P2TR.EC(1) edges.P2TR.EC(end)]) 
    box off 

close all
clear fitresult h wfCenters wfCounts wfFitCurveS wfHist

% 
dist.p2tr.PV2PV = abs(meanPVic-p2tr.mouse.all(list.mouse.PV));
dist.p2tr.PV2SST = abs(meanPVic-p2tr.mouse.all(list.mouse.SST));
dist.p2tr.PV2VIP = abs(meanPVic-p2tr.mouse.all(list.mouse.VIP));
dist.p2tr.PV2Pyr = abs(meanPVic-p2tr.mouse.all(list.mouse.Pyr));
dist.p2tr.SST2PV = abs(meanSSTic-p2tr.mouse.all(list.mouse.PV));
dist.p2tr.SST2SST = abs(meanSSTic-p2tr.mouse.all(list.mouse.SST));
dist.p2tr.SST2VIP = abs(meanSSTic-p2tr.mouse.all(list.mouse.VIP));
dist.p2tr.SST2Pyr = abs(meanSSTic-p2tr.mouse.all(list.mouse.Pyr));
dist.p2tr.VIP2PV = abs(meanVIPic-p2tr.mouse.all(list.mouse.PV));
dist.p2tr.VIP2SST = abs(meanVIPic-p2tr.mouse.all(list.mouse.SST));
dist.p2tr.VIP2VIP = abs(meanVIPic-p2tr.mouse.all(list.mouse.VIP));
dist.p2tr.VIP2Pyr = abs(meanVIPic-p2tr.mouse.all(list.mouse.Pyr));
dist.p2tr.Pyr2PV = abs(meanPyric-p2tr.mouse.all(list.mouse.PV));
dist.p2tr.Pyr2SST = abs(meanPyric-p2tr.mouse.all(list.mouse.SST));
dist.p2tr.Pyr2VIP = abs(meanPyric-p2tr.mouse.all(list.mouse.VIP));
dist.p2tr.Pyr2Pyr = abs(meanPyric-p2tr.mouse.all(list.mouse.Pyr));



% distance classification
for i = 1:length(list.mouse.PV)
    vec = [dist.p2tr.PV2PV(i),dist.p2tr.SST2PV(i),dist.p2tr.VIP2PV(i),...
        dist.p2tr.Pyr2PV(i)];
    [~,loc] = min(vec);
    pred.p2tr.PV(i) = loc;
end
for i = 1:length(list.mouse.SST)
    vec = [dist.p2tr.PV2SST(i),dist.p2tr.SST2SST(i),dist.p2tr.VIP2SST(i),...
        dist.p2tr.Pyr2SST(i)];
    [~,loc] = min(vec);
    pred.p2tr.SST(i) = loc;
end
for i = 1:length(list.mouse.VIP)
    vec = [dist.p2tr.PV2VIP(i),dist.p2tr.SST2VIP(i),dist.p2tr.VIP2VIP(i),...
        dist.p2tr.Pyr2VIP(i)];
    [~,loc] = min(vec);
    pred.p2tr.VIP(i) = loc;
end
for i = 1:length(list.mouse.Pyr)
    vec = [dist.p2tr.PV2Pyr(i),dist.p2tr.SST2Pyr(i),dist.p2tr.VIP2Pyr(i),...
        dist.p2tr.Pyr2Pyr(i)];
    [~,loc] = min(vec);
    pred.p2tr.Pyr(i) = loc;
end

figure('Position',[50 50 200 200]); set(gcf,'color','w');
    mat = [sum(pred.p2tr.PV==1)/length(pred.p2tr.PV),...
        sum(pred.p2tr.SST==1)/length(pred.p2tr.SST),...
        sum(pred.p2tr.VIP==1)/length(pred.p2tr.VIP),...
        sum(pred.p2tr.Pyr==1)/length(pred.p2tr.Pyr);...
        sum(pred.p2tr.PV==2)/length(pred.p2tr.PV),...
        sum(pred.p2tr.SST==2)/length(pred.p2tr.SST),...
        sum(pred.p2tr.VIP==2)/length(pred.p2tr.VIP),...
        sum(pred.p2tr.Pyr==2)/length(pred.p2tr.Pyr);...
        sum(pred.p2tr.PV==3)/length(pred.p2tr.PV),...
        sum(pred.p2tr.SST==3)/length(pred.p2tr.SST),...
        sum(pred.p2tr.VIP==3)/length(pred.p2tr.VIP),...
        sum(pred.p2tr.Pyr==3)/length(pred.p2tr.Pyr);...
        sum(pred.p2tr.PV==4)/length(pred.p2tr.PV),...
        sum(pred.p2tr.SST==4)/length(pred.p2tr.SST),...
        sum(pred.p2tr.VIP==4)/length(pred.p2tr.VIP),...
        sum(pred.p2tr.Pyr==4)/length(pred.p2tr.Pyr)];
    imagesc(mat);
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    clear h
    xlabel('ground truth')
    ylabel('prediction')
    xticks(1:4)
    xticklabels({'PV+','SST+','VIP+','Pyr'})
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','Pyr'})
    axis equal
    axis tight
    box off
    dim = [.21 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.PV==1)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.35 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.SST==1)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.48 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.VIP==1)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.58 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.Pyr==1)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.23 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.PV==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.35 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.SST==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.46 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.VIP==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.57 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.Pyr==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.23 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.PV==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.35 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.SST==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.46 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.VIP==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.57 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.Pyr==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.23 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.PV==4)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.35 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.SST==4)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.46 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.VIP==4)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.57 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2tr.Pyr==4)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    clear h dim

% compute distance for EC
dist.p2trVivo.PV2PV = abs(meanPVec-p2tr.mouseVivo.all(...
    list.mouseVivo.PV));
dist.p2trVivo.PV2SST = abs(meanPVec-p2tr.mouseVivo.all(...
    list.mouseVivo.SST));
dist.p2trVivo.PV2VIP = abs(meanPVec-p2tr.mouseVivo.all(...
    list.mouseVivo.VIP));
dist.p2trVivo.PV2broad = abs(meanPVec-p2tr.mouseVivo.all(...
    list.mouseVivo.broad));
dist.p2trVivo.SST2PV = abs(meanSSTec-p2tr.mouseVivo.all(...
    list.mouseVivo.PV));
dist.p2trVivo.SST2SST = abs(meanSSTec-p2tr.mouseVivo.all(...
    list.mouseVivo.SST));
dist.p2trVivo.SST2VIP = abs(meanSSTec-p2tr.mouseVivo.all(...
    list.mouseVivo.VIP));
dist.p2trVivo.SST2broad = abs(meanSSTec-p2tr.mouseVivo.all(...
    list.mouseVivo.broad));
dist.p2trVivo.VIP2PV = abs(meanVIPec-p2tr.mouseVivo.all(...
    list.mouseVivo.PV));
dist.p2trVivo.VIP2SST = abs(meanVIPec-p2tr.mouseVivo.all(...
    list.mouseVivo.SST));
dist.p2trVivo.VIP2VIP = abs(meanVIPec-p2tr.mouseVivo.all(...
    list.mouseVivo.VIP));
dist.p2trVivo.VIP2broad = abs(meanVIPec-p2tr.mouseVivo.all(...
    list.mouseVivo.broad));
dist.p2trVivo.broad2PV = abs(meanBROADec-p2tr.mouseVivo.all(...
    list.mouseVivo.PV));
dist.p2trVivo.broad2SST = abs(meanBROADec-p2tr.mouseVivo.all(...
    list.mouseVivo.SST));
dist.p2trVivo.broad2VIP = abs(meanBROADec-p2tr.mouseVivo.all(...
    list.mouseVivo.VIP));
dist.p2trVivo.broad2broad = abs(meanBROADec-p2tr.mouseVivo.all(...
    list.mouseVivo.broad));

% distance classification
for i = 1:length(list.mouseVivo.PV)
    vec = [dist.p2trVivo.PV2PV(i),dist.p2trVivo.SST2PV(i),dist.p2trVivo.VIP2PV(i),dist.p2trVivo.broad2PV(i)];
    [~,loc] = min(vec);
    pred.p2trVivo.PV(i) = loc;
end
for i = 1:length(list.mouseVivo.SST)
    vec = [dist.p2trVivo.PV2SST(i),dist.p2trVivo.SST2SST(i),dist.p2trVivo.VIP2SST(i),dist.p2trVivo.broad2SST(i)];
    [~,loc] = min(vec);
    pred.p2trVivo.SST(i) = loc;
end
for i = 1:length(list.mouseVivo.VIP)
    vec = [dist.p2trVivo.PV2VIP(i),dist.p2trVivo.SST2VIP(i),dist.p2trVivo.VIP2VIP(i),dist.p2trVivo.broad2VIP(i)];
    [~,loc] = min(vec);
    pred.p2trVivo.VIP(i) = loc;
end
for i = 1:length(list.mouseVivo.broad)
    vec = [dist.p2trVivo.PV2broad(i),dist.p2trVivo.SST2broad(i),dist.p2trVivo.VIP2broad(i),dist.p2trVivo.broad2broad(i)];
    [~,loc] = min(vec);
    pred.p2trVivo.broad(i) = loc;
end   

figure('Position',[50 50 200 200]); set(gcf,'color','w');
    mat = [sum(pred.p2trVivo.PV==1)/length(pred.p2trVivo.PV),...
        sum(pred.p2trVivo.SST==1)/length(pred.p2trVivo.SST),...
        sum(pred.p2trVivo.VIP==1)/length(pred.p2trVivo.VIP),...
        sum(pred.p2trVivo.broad==1)/length(pred.p2trVivo.broad);...
        sum(pred.p2trVivo.PV==2)/length(pred.p2trVivo.PV),...
        sum(pred.p2trVivo.SST==2)/length(pred.p2trVivo.SST),...
        sum(pred.p2trVivo.VIP==2)/length(pred.p2trVivo.VIP),...
        sum(pred.p2trVivo.broad==2)/length(pred.p2trVivo.broad);...
        sum(pred.p2trVivo.PV==3)/length(pred.p2trVivo.PV),...
        sum(pred.p2trVivo.SST==3)/length(pred.p2trVivo.SST),...
        sum(pred.p2trVivo.VIP==3)/length(pred.p2trVivo.VIP),...
        sum(pred.p2trVivo.broad==3)/length(pred.p2trVivo.broad);...
        sum(pred.p2trVivo.PV==4)/length(pred.p2trVivo.PV),...
        sum(pred.p2trVivo.SST==4)/length(pred.p2trVivo.SST),...
        sum(pred.p2trVivo.VIP==4)/length(pred.p2trVivo.VIP),...
        sum(pred.p2trVivo.broad==4)/length(pred.p2trVivo.broad)];
    imagesc(mat);
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    clear h
    xlabel('ground truth')
    ylabel('prediction')
    xticks(1:4)
    xticklabels({'PV+','SST+','VIP+','broad'})
    yticks(1:4)
    yticklabels({'PV+','SST+','VIP+','broad'})
    axis equal
    axis tight
    box off
    dim = [.21 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.PV==1)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.35 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.SST==1)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.48 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.VIP==1)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.58 .75 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.broad==1)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.23 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.PV==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.35 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.SST==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.46 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.VIP==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.57 .64 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.broad==2)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.23 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.PV==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.35 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.SST==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.46 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.VIP==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.57 .53 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.broad==3)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.23 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.PV==4)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.35 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.SST==4)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.46 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.VIP==4)),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.57 .42 0 0];
    annotation('textbox',dim,'String',int2str(sum(pred.p2trVivo.broad==4)),...
        'FitBoxToText','on','LineStyle','none','color','k');
    clear h dim
     
close all
clear i loc mat meanPVec meanPVic meanPyric meanSSTec meanSSTic ...
    meanVIPec meanVIPic n vec