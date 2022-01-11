%{
examining the waveforms and trough-to-peak
%}

disp('plotting waveforms and trough-to-peak distributions...')

%{
distributions of spike width EC
%}
% mouse ec
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(X.mouseVivo.all','k','LineWidth',0.25)
    scatter(zeros(1,length(Pv.mouseVivo.all))+11,Pv.mouseVivo.all,1,...
        [0,0.8,0.5],'LineWidth',0.25)
    scatter(Ttime.mouseVivo.all-TimeVec.mouseVivo.all+1,...
        Tv.mouseVivo.all,1,'y','LineWidth',0.25)
    box off
    axis tight
    xlim([1 39])
    
wfHist = T2P.mouseVivo.all;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(wfHist,edges.T2P.EC,'FaceColor',[0.2 0.2 0.2],...
        'Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [wfFit.T2P.mouseEC, gof.T2P.mouseEC] = ...
        createT2PmouseECFit(wfCenters, wfCounts);
    inflection.mouseEC.T2P = findIntersection(wfFit.T2P.mouseEC,wfCenters);
    plot(inflection.mouseEC.T2P.x,inflection.mouseEC.T2P.yfun1,'k','LineWidth',1);
    plot(inflection.mouseEC.T2P.x,inflection.mouseEC.T2P.yfun2,'k','LineWidth',1);
    line([inflection.mouseEC.T2P.peakLocs,...
        inflection.mouseEC.T2P.peakLocs],[0,0.12],...
        'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    legend({'data','model','inflection'},'Location','northeast')
    legend boxoff
    axis tight
    xlim([edges.T2P.EC(1) edges.T2P.EC(end)])
    box off

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    pie(sum([wfHist'<inflection.mouseEC.T2P.peakLocs,...
        wfHist'>inflection.mouseEC.T2P.peakLocs])/length(wfHist))
    
% NHP ec
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(X.nhpVivo.all','k','LineWidth',0.25)
    scatter(zeros(1,length(Pv.nhpVivo.all))+11,Pv.nhpVivo.all,1,...
        [0,0.8,0.5],'LineWidth',0.25)
    scatter(Ttime.nhpVivo.all-TimeVec.nhpVivo.all+1,Tv.nhpVivo.all,1,...
        'y','LineWidth',0.25)
    box off
    axis tight
    xlim([1 39])
    
wfHist = T2P.nhpVivo.all;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(wfHist,edges.T2P.EC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [wfFit.T2P.nhpEC, gof.T2P.nhpEC] = createT2PnhpECFit(wfCenters, wfCounts);
    inflection.nhpEC.T2P = findIntersection(wfFit.T2P.nhpEC,wfCenters);
    plot(inflection.nhpEC.T2P.x,inflection.nhpEC.T2P.yfun1,'k','LineWidth',1);
    plot(inflection.nhpEC.T2P.x,inflection.nhpEC.T2P.yfun2,'k','LineWidth',1);
    line([inflection.nhpEC.T2P.peakLocs,...
        inflection.nhpEC.T2P.peakLocs],[0,0.15],...
        'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    axis tight
    xlim([edges.T2P.EC(1) edges.T2P.EC(end)])
    box off
    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    pie(sum([wfHist'<inflection.nhpEC.T2P.peakLocs,...
        wfHist'>inflection.nhpEC.T2P.peakLocs])/length(wfHist))

close all

%{
in vitro mouse waveforms (Allen Institute)
%}
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(X.mouse.all(list.mouse.spiny,:)','Color','k','LineWidth',0.25)
    plot(X.mouse.all(list.mouse.aspiny,:)','Color','r','LineWidth',0.25)
    ylabel('voltage')
    xlabel('time-steps (dt=0.02)')
    axis tight
    box off
    dim = [.6 .76 0 0];
    annotation('textbox',dim,'String','spiny','FitBoxToText','on',...
        'LineStyle','none','color','k');
    dim = [.6 .7 0 0];
    annotation('textbox',dim,'String','aspiny','FitBoxToText','on',...
        'LineStyle','none','color','r');
    clear dim

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    plot(mean(dVdt.mouse.all(list.mouse.spiny,:))*-1,...
        'Color','k','LineWidth',0.25)
    plot(mean(dVdt.mouse.all(list.mouse.aspiny,:))*-1,...
        'Color','r','LineWidth',0.25)
    ylabel('voltage')
    xlabel('time-steps (dt=0.02)')
    axis tight
    xlim([10 100])
    box off
    clear dim
    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(T2P.mouse.all,edges.T2P.IC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    [wfFit.T2P.mouseIC,gof.T2P.mouseIC] = ...
        createT2PmouseICFit(wfCenters, wfCounts);
    yMax = 0.14;
    inflection.mouse.T2P = findIntersection(wfFit.T2P.mouseIC,wfCenters);
    plot(inflection.mouse.T2P.x,inflection.mouse.T2P.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.T2P.x,inflection.mouse.T2P.yfun2,'k','LineWidth',1);
    line([inflection.mouse.T2P.peakLocs,...
        inflection.mouse.T2P.peakLocs],[0,yMax], ...
            'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-peak (ms)')
    ylabel('probability')
    legend({'data','model','inflection'},'Location','northeast')
    legend boxoff 
    axis tight
    xlim([edges.T2P.IC(1) edges.T2P.IC(end)])
    
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(T2P.mouse.all(list.mouse.spiny),edges.T2P.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none')
    histogram(T2P.mouse.all(list.mouse.aspiny),edges.T2P.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none')
    line([inflection.mouse.T2P.peakLocs,inflection.mouse.T2P.peakLocs],[0,0.2], ...
        'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak (ms)')
    ylabel('probability')
    axis tight
    xlim([edges.T2P.IC(1) edges.T2P.IC(end)])
    
aspinyNbelowBound = sum(T2P.mouse.all(list.mouse.aspiny)<=...
    inflection.mouse.T2P.peakLocs);
aspinyNaboveBound = sum(T2P.mouse.all(list.mouse.aspiny)>...
    inflection.mouse.T2P.peakLocs);
spinyNbelowBound = sum(T2P.mouse.all(list.mouse.spiny)<=...
    inflection.mouse.T2P.peakLocs);
spinyNaboveBound = sum(T2P.mouse.all(list.mouse.spiny)>...
    inflection.mouse.T2P.peakLocs);
mat = [aspinyNbelowBound/length(list.mouse.aspiny), ...
    aspinyNaboveBound/length(list.mouse.aspiny); ...
    spinyNbelowBound/length(list.mouse.spiny), ...
    spinyNaboveBound/length(list.mouse.spiny)];
figure('Position',[50 50 200 200]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('spiking type')
    xticks([1,2])
    xticklabels({'narrow','broad'})
    ylabel('dendrite type')
    yticks([1,2])
    yticklabels({'aspiny','spiny'})
    colormap('gray')
    h = colorbar;
    ylabel(h, 'proportion')
    axis equal
    axis tight
    box off
    dim = [.28 .685 0 0];
    annotation('textbox',dim,'String',int2str(aspinyNbelowBound),...
        'FitBoxToText','on','LineStyle','none');
    dim = [.5 .685 0 0];
    annotation('textbox',dim,'String',int2str(aspinyNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.3 .47 0 0];
    annotation('textbox',dim,'String',int2str(spinyNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','w');
    dim = [.5 .47 0 0];
    annotation('textbox',dim,'String',int2str(spinyNaboveBound),...
        'FitBoxToText','on','LineStyle','none');
    
prop.AspinyBroad.Mouse = aspinyNaboveBound/length(list.mouse.aspiny);
prop.SpinyNarrow.Mouse = spinyNbelowBound/length(list.mouse.spiny);

close all
clear aspinyNbelowBound aspinyNaboveBound spinyNbelowBound spinyNaboveBound ...
    dim mat h wfCenters wfCounts wfFitCurveS wfHist yMax 

%{
the 'runTransgenics code runs the plots for figure 5
%}

runTransgenics