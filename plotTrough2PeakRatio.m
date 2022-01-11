%{
trough to peak ratio image
%}

close all

% mouse EC w no dendrite type
[~,loc] = sort(p2tr.mouseVivo.all,'ascend');
figure('Position',[50 50 250 200]); set(gcf,'color','w');
hold on

k = loc(4);
plot(X.mouseVivo.all(k,:),'k','LineWidth',0.25)
scatter(17,p2trPeak.mouseVivo.all(1,k),10,'c','filled')
scatter(11,p2trTrough.mouseVivo.all(1,k),10,'m','filled')
plot([17 17],[p2trTrough.mouseVivo.all(1,k) p2trPeak.mouseVivo.all(1,k)],'k-.','LineWidth',0.25)

k = loc(2000);
plot(X.mouseVivo.all(k,:),'k','LineWidth',0.25)
scatter(32,p2trPeak.mouseVivo.all(1,k),10,'c','filled')
scatter(11,p2trTrough.mouseVivo.all(1,k),10,'m','filled')
plot([32 32],[p2trTrough.mouseVivo.all(1,k) p2trPeak.mouseVivo.all(1,k)],'k-.','LineWidth',0.25)
ylabel('abs(dV/dt)')
xlabel('cell #')
axis tight
close

wfHist = p2tr.mouseVivo.all;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
h = histogram(wfHist,edges.P2TR.EC,...
    'FaceColor','k','Normalization','probability');
wfCounts = [0,h.Values];
wfCenters = h.BinEdges;
close
[fitresult, gof] = createT2PRmouseECFit(wfCenters, wfCounts);
wfFitCurveS = fitresult(wfCenters);
inflection.mouseEC.t2pr.peakLocs = fitresult.b1;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(wfHist,edges.P2TR.EC,...
        'FaceColor',[0.85 0.85 0.85],'Normalization','probability','EdgeColor','none')
    plot(wfCenters,wfFitCurveS,'k','LineWidth',1);
    line([inflection.mouseEC.t2pr.peakLocs,...
        inflection.mouseEC.t2pr.peakLocs],[0,0.2], ...
            'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak ratio')
    ylabel('probability')    
    axis tight
    xlim([edges.P2TR.EC(1) edges.P2TR.EC(end)]) 
    box off
    
% because there is an inflection point (mean)
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    pie(sum([wfHist'<inflection.mouseEC.t2pr.peakLocs,...
        wfHist'>inflection.mouseEC.t2pr.peakLocs])/length(wfHist))
    
% and nhp EC
[~,loc] = sort(p2tr.nhpVivo.all,'ascend');
figure('Position',[50 50 250 200]); set(gcf,'color','w');
hold on

k = loc(5);
plot(X.nhpVivo.all(k,:),'k','LineWidth',0.25)
scatter(22,p2trPeak.nhpVivo.all(1,k),10,'c','filled')
scatter(11,p2trTrough.nhpVivo.all(1,k),10,'m','filled')
plot([22 22],[p2trTrough.nhpVivo.all(1,k) p2trPeak.nhpVivo.all(1,k)],'k-.','LineWidth',0.25)

k = loc(end);
plot(X.nhpVivo.all(k,:),'k','LineWidth',0.25)
scatter(25,p2trPeak.nhpVivo.all(1,k),10,'c','filled')
scatter(11,p2trTrough.nhpVivo.all(1,k),10,'m','filled')
plot([25 25],[p2trTrough.nhpVivo.all(1,k) p2trPeak.nhpVivo.all(1,k)],'k-.','LineWidth',0.25)
ylabel('mV')
xlabel('cell #')
axis tight
close

wfHist = p2tr.nhpVivo.all;
figure('Position',[50 50 250 200]); set(gcf,'color','w');
h = histogram(wfHist,edges.P2TR.EC,...
    'FaceColor','k','Normalization','probability');
wfCounts = [0,h.Values];
wfCenters = h.BinEdges;
close
[wfFit.T2PR.nhpEC, ~] = createP2TRecNHPFit(wfCenters, wfCounts);
inflection.nhpEC.t2pr = findIntersection(wfFit.T2PR.nhpEC,wfCenters);

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(wfHist,edges.P2TR.EC,...
        'FaceColor',[0.85 0.85 0.85],'Normalization','probability','EdgeColor','none')
    plot(inflection.nhpEC.t2pr.x,inflection.nhpEC.t2pr.yfun1,'k','LineWidth',1);
    plot(inflection.nhpEC.t2pr.x,inflection.nhpEC.t2pr.yfun2,'k','LineWidth',1);
    line([inflection.nhpEC.t2pr.peakLocs,...
        inflection.nhpEC.t2pr.peakLocs],[0,0.29], ...
            'color','k','linewidth',1,'linestyle','--');
    xlabel('trough-to-peak ratio')
    ylabel('probability')    
    axis tight
    xlim([edges.P2TR.EC(1) edges.P2TR.EC(end)]) 
    box off

% because there is an inflection point
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    pie(sum([wfHist'<inflection.nhpEC.t2pr.peakLocs,...
        wfHist'>inflection.nhpEC.t2pr.peakLocs])/length(wfHist))

% mouse IC, with bimodal and inflection point (from transgenic script)
[~,loc] = sort(p2tr.mouse.all,'ascend');
figure('Position',[50 50 250 200]); set(gcf,'color','w');
hold on

k = loc(5);
plot(dVdt.mouse.all(k,:)*-1,'k','LineWidth',0.25)
scatter(44,p2trPeak.mouse.all(k,1)*-1,10,'m','filled')
scatter(59,p2trTrough.mouse.all(k,1)*-1,10,'c','filled')
plot([59 59],[p2trTrough.mouse.all(k,1)*-1 p2trPeak.mouse.all(k,1)*-1],'k-.','LineWidth',0.25)

k = loc(1800);
plot(dVdt.mouse.all(k,:)*-1,'k','LineWidth',0.25)
scatter(42,p2trPeak.mouse.all(k,1)*-1,10,'m','filled')
scatter(63,p2trTrough.mouse.all(k,1)*-1,10,'c','filled')
plot([63 63],[p2trTrough.mouse.all(k,1)*-1 p2trPeak.mouse.all(k,1)*-1],'k-.','LineWidth',0.25)
ylabel('mV')
xlabel('cell #')
axis tight
xlim([20 100])
close

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouse.all,edges.P2TR.IC,'FaceColor',...
        [0.85 0.85 0.85],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.p2tr.x,inflection.mouse.p2tr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.p2tr.peakLocs,inflection.mouse.p2tr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.P2TR.IC(1) edges.P2TR.IC(end)])
    
% mouse IC spiny and aspiny versus inflection point
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(p2tr.mouse.all(list.mouse.spiny),edges.P2TR.IC,...
        'FaceColor','k','Normalization','probability','EdgeColor','none');
    histogram(p2tr.mouse.all(list.mouse.aspiny),edges.P2TR.IC,...
        'FaceColor','r','Normalization','probability','EdgeColor','none');
    line([inflection.mouse.p2tr.peakLocs,inflection.mouse.p2tr.peakLocs]...
        ,[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('trough-to-peak ratio')
    axis tight
    xlim([edges.P2TR.IC(1) edges.P2TR.IC(end)])

% classify spiny and aspiny cells according to mouse inflection point
aspinyNbelowBound = sum(p2tr.mouse.all(list.mouse.aspiny)<=...
    inflection.mouse.p2tr.peakLocs);
aspinyNaboveBound = sum(p2tr.mouse.all(list.mouse.aspiny)>...
    inflection.mouse.p2tr.peakLocs);
spinyNbelowBound = sum(p2tr.mouse.all(list.mouse.spiny)<=...
    inflection.mouse.p2tr.peakLocs);
spinyNaboveBound = sum(p2tr.mouse.all(list.mouse.spiny)>...
    inflection.mouse.p2tr.peakLocs);
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

close all