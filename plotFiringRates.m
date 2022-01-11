%{
plotFiringRates
%}

msWindowIC = 175;
sWindowEC = 20;

close all

figure('Position',[50 50 250 200]); set(gcf,'color','w');
hold on
for n = 1:N.nhpVivo
    temp = spTimes.mouseVivo.all{n,1}(spTimes.mouseVivo.all{n,1}<0.5);
    plot([temp temp]',[n*ones(length(temp),1) n+1*ones(length(temp),1)]',...
        'Color','k','LineWidth',0.1)
%     'yo'
end
axis tight
axis off
close

% mouse EC neuropixel (no dendrite type labels)
% figure('Position',[50 50 250 200]); set(gcf,'color','w');
%     hold on
%     histogram(log(fr.mouseVivo.all),edges.FR.EC,...
%         'FaceColor',[0.2 0.2 0.2],'Normalization','probability');
%     wfCounts = [0,h.Values];
%     wfCenters = h.BinEdges;
%     close
%     [wfFit.FR.mouseEC, gof] = createFRmouseECFit(wfCenters, wfCounts);
%     wfFitCurveS = wfFit.FR.mouseEC(wfCenters);
%     inflection.mouseEC.fr = findIntersection(wfFit.FR.mouseEC);
%     [~,in] = findpeaks(wfFitCurveS*-1);
%     in = wfCenters(in);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouseVivo.all),edges.FR.EC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouseVivo.fr.x,inflection.mouseVivo.fr.yfun1,'k','LineWidth',1);
    plot(inflection.mouseVivo.fr.x,inflection.mouseVivo.fr.yfun2,'k','LineWidth',1);
    line([inflection.mouseVivo.fr.peakLocs,...
        inflection.mouseVivo.fr.peakLocs],[0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.EC(1) edges.FR.EC(end)])
%     clear h wfCounts wfCenters wfFitCurveS

% because there is an inflection point
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    pie(sum([log(fr.mouseVivo.all)'<inflection.mouseVivo.fr.peakLocs,...
        log(fr.mouseVivo.all)'>inflection.mouseVivo.fr.peakLocs])/length(fr.mouseVivo.all))

figure('Position',[50 50 250 200]); set(gcf,'color','w');
hold on
for n = 1:N.nhpVivo
    temp = spTimes.nhpVivo.all{n,1}(spTimes.nhpVivo.all{n,1}<20);
    plot([temp temp]',[n*ones(length(temp),1) n+1*ones(length(temp),1)]',...
        'Color','k','LineWidth',0.1)
%     'yo'
end
axis tight
axis off
close
    
% NHP EC (no dendrite type labels)
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    h = histogram(log(fr.nhpVivo.all),edges.FR.EC,...
        'FaceColor',[0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    wfCounts = [0,h.Values];
    wfCenters = h.BinEdges;
    close
    [wfFit.FR.nhpEC, ~] = createFRnhpECFit(wfCenters, wfCounts);
    inflection.nhpVivo.fr = findIntersection(wfFit.FR.nhpEC,wfCenters);
    figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.nhpVivo.all),edges.FR.EC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    plot(inflection.nhpVivo.fr.x,inflection.nhpVivo.fr.yfun1,'k','LineWidth',1);
    plot(inflection.nhpVivo.fr.x,inflection.nhpVivo.fr.yfun2,'k','LineWidth',1);
    line([inflection.nhpVivo.fr.peakLocs,...
        inflection.nhpVivo.fr.peakLocs],[0,0.1],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.EC(1) edges.FR.EC(end)])

% because there is an inflection point
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    pie(sum([log(fr.nhpVivo.all)'<inflection.nhpVivo.fr.peakLocs,...
        log(fr.nhpVivo.all)'>inflection.nhpVivo.fr.peakLocs])/length(fr.nhpVivo.all))
    
% FR IC MOUSE
loc = 1:N.mouse;
vec = randperm(N.mouse,N.nhpVivo);
figure('Position',[50 50 250 200]); set(gcf,'color','w');
hold on
count = 1;
for n = vec
    k = loc(n);
    temp = spTimesClean.mouse.all{k,1};
    temp(isnan(temp)) = [];
    if ~isempty(temp)
        vecTemp = randperm(length(temp));
        sptemp(1) = temp(vecTemp(1));
        for i = 2:length(temp)
            if vecTemp(i)~=1
                sptemp(i) = sptemp(i-1)+temp(vecTemp(i));
            else
                sptemp(i) = sptemp(i-1);
            end
            if sptemp(i)>1000
                break
            end
        end
        plot([sptemp; sptemp],[count*ones(length(sptemp),1) count+1*ones(length(sptemp),1)]',...
            'Color','k','LineWidth',0.1)
        count = count + 1;
        clear sptemp
    end
end
axis tight
axis off
xlim([0 1000])
close
    
% mouse IC patch clamp (w dendrite type labels)
figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouse.all),edges.FR.IC,'FaceColor',...
        [0.2 0.2 0.2],'Normalization','probability','EdgeColor','none');
    plot(inflection.mouse.fr.x,inflection.mouse.fr.yfun1,'k','LineWidth',1);
    plot(inflection.mouse.fr.x,inflection.mouse.fr.yfun2,'k','LineWidth',1);
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs],...
        [0,0.12],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])

figure('Position',[50 50 250 200]); set(gcf,'color','w');
    hold on
    histogram(log(fr.mouse.all(list.mouse.spiny)),edges.FR.IC,'FaceColor',...
        'k','Normalization','probability','EdgeColor','none');
    histogram(log(fr.mouse.all(list.mouse.aspiny)),edges.FR.IC,'FaceColor',...
        'r','Normalization','probability','EdgeColor','none');
    line([inflection.mouse.fr.peakLocs,inflection.mouse.fr.peakLocs],[0,0.15],'color','k','linewidth',1,'linestyle','--');
    ylabel('probability')
    xlabel('firing rate (Hz)')
    axis tight
    xlim([edges.FR.IC(1) edges.FR.IC(end)])
    
aspinyNbelowBound = sum(log(fr.mouse.all(list.mouse.aspiny))<=inflection.mouse.fr.peakLocs);
aspinyNaboveBound = sum(log(fr.mouse.all(list.mouse.aspiny))>inflection.mouse.fr.peakLocs);
spinyNbelowBound = sum(log(fr.mouse.all(list.mouse.spiny))<=inflection.mouse.fr.peakLocs);
spinyNaboveBound = sum(log(fr.mouse.all(list.mouse.spiny))>inflection.mouse.fr.peakLocs);
mat = [aspinyNbelowBound/length(list.mouse.aspiny), ...
    aspinyNaboveBound/length(list.mouse.aspiny); ...
    spinyNbelowBound/length(list.mouse.spiny), ...
    spinyNaboveBound/length(list.mouse.spiny)];
figure('Position',[50 50 200 200]); set(gcf,'color','w');
    imagesc(mat)
    xlabel('spiking type')
    xticks([1,2])
    xticklabels({'non-fast','fast'})
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
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.3 .47 0 0];
    annotation('textbox',dim,'String',int2str(spinyNbelowBound),...
        'FitBoxToText','on','LineStyle','none','color','k');
    dim = [.5 .47 0 0];
    annotation('textbox',dim,'String',int2str(spinyNaboveBound),...
        'FitBoxToText','on','LineStyle','none','color','w');   
    
close all