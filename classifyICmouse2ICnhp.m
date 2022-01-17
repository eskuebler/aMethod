%{
classifyICmouse2ICnhp
%}

close all

% data we used as a model to classify NHP cells
Y = X_IC;
figure('Position',[50 50 270 200]); set(gcf,'color','w');
hold on
scatter3(Y(:,1),Y(:,2),zeros(size(Y,1),1),5,[0.9,0.9,0.9])
scatter3(Y(:,1),zeros(size(Y,1),1)+max(Y(:,2)),Y(:,3),5,[0.9,0.9,0.9])
scatter3(zeros(size(Y,1),1)+max(Y(:,1)),Y(:,2),Y(:,3),5,[0.9,0.9,0.9])
scatter3(Y(list.mouse.PV,1),Y(list.mouse.PV,2),Y(list.mouse.PV,3),5,'r')
scatter3(Y(list.mouse.SST,1),Y(list.mouse.SST,2),Y(list.mouse.SST,3),5,'g')
scatter3(Y(list.mouse.VIP,1),Y(list.mouse.VIP,2),Y(list.mouse.VIP,3),5,'b')
scatter3(Y(list.mouse.Pyr,1),Y(list.mouse.Pyr,2),Y(list.mouse.Pyr,3),5,'k')
xlabel('trough-to-peak')
ylabel('firing rate')
zlabel('trough-to-peak ratio')
grid on
box off
view(plots.az,plots.el)
axis tight

% NHP ground truth labels
yGT = ctTag.NhpIC;

% generate a dataset
Xnhp = [T2P.nhp.all,log(fr.nhp.all),p2tr.nhp.all];
Xnhp(:,3) = rescale(Xnhp(:,3),0,1); % rescale P2TR like w/ mouse data

% show the input matrix to classify
Y = Xnhp;
figure('Position',[50 50 270 200]); set(gcf,'color','w');
    hold on
    scatter3(Y(:,1),Y(:,2),zeros(size(Y,1),1)+min(Y(:,3)),5,[0.9,0.9,0.9])
    scatter3(Y(:,1),zeros(size(Y,1),1)+max(Y(:,2)),Y(:,3),5,[0.9,0.9,0.9])
    scatter3(zeros(size(Y,1),1)+max(Y(:,1)),Y(:,2),Y(:,3),5,[0.9,0.9,0.9])
    scatter3(Y(yGT==1,1),Y(yGT==1,2),Y(yGT==1,3),5,'r')
    scatter3(Y(yGT==2,1),Y(yGT==2,2),Y(yGT==2,3),5,'k')
    xlabel('trough-to-peak')
    ylabel('firing rate')
    zlabel('trough-to-peak ratio')
    grid on
    box off
    view(plots.az,plots.el)
    axis tight
    
% show ground truth labels
ind = find(yGT==1 | yGT==2); 
figure('Position',[50 50 360 50]); set(gcf,'color','w');
imagesc(yGT(ind))
xlabel('cell #')
colormap([[1 0 0];[0.5 0.5 0.5]])
box off

close all

disp('IC mouse -> IC NHP correspondence w neural network...')
% load('neuralNetworkIC')
count = 0;
for numRands = goodModelsIndex.NN % generate numRands models
    count = count + 1;
    net = multiNNMdl{numRands,1};
    Ptest = net(Xnhp');
    [~,yTest] = max(Ptest);
%     yTest = str2double(yTest);
    YTest.ICnhp.NN(:,count) = yTest;
    yTest2 = yTest;
    yTest2(yTest2==2) = 1;
    yTest2(yTest2==3) = 1;
    yTest2(yTest2==4) = 2;
    YTest2.ICnhp.NN(:,count) = yTest2;
    cp = classperf(yGT(ind),yTest2(ind));
    groupAccuracies.IC2ICnhp.NN(:,count) = 1-(cp.ErrorDistributionByClass ...
        ./ cp.SampleDistributionByClass);
    correctRates.IC2ICnhp.NN(1,count) = cp.CorrectRate;
    
%     for n = 1:length(yTest)
%         if yTest(n) == 1; C(n,:) = plots.cc(1,:);
%         elseif yTest(n) == 2; C(n,:) = plots.cc(2,:);
%         elseif yTest(n) == 3; C(n,:) = plots.cc(3,:);
%         elseif yTest(n) == 4; C(n,:) = plots.cc(4,:);
%         end
%     end
%     figure('Position',[50 50 270 200]); set(gcf,'color','w');
%         scatter3(Xnhp(:,1),Xnhp(:,2),Xnhp(:,3),...
%             plots.mrkszr,C(:,:));
%         grid on;     
%         xlabel('trough-to-peak')
%         ylabel('firing rate')
%         zlabel('trough-to-peak ratio')
%         view(-30,11)
%         axis tight
%     
%     for n = 1:length(yTest2)
%         if yTest2(n) == 1; C(n,:) = plots.cc(1,:);
%         elseif yTest2(n) == 2; C(n,:) = plots.cc(4,:);
%         end
%     end    
%     figure('Position',[50 50 270 200]); set(gcf,'color','w');
%         scatter3(Xnhp(:,1),Xnhp(:,2),Xnhp(:,3),...
%             plots.mrkszr,C(:,:));
%         grid on;     
%         xlabel('trough-to-peak')
%         ylabel('firing rate')
%         zlabel('trough-to-peak ratio')
%         view(-30,11)
%         axis tight
%     close all

    clear yTest yTest2 x
end
clear numRands n x

% show the matrix of predictions
figure('Position',[50 50 360 100]); set(gcf,'color','w');
    imagesc(YTest.ICnhp.NN(ind,:)')
    xlabel('cell #')
    ylabel('model #')
    colormap([[1 0 0];[0 1 0];[0 0 1];[0.5 0.5 0.5]])
    box off

figure('Position',[50 50 360 100]); set(gcf,'color','w');
    imagesc(YTest2.ICnhp.NN(ind,:)')
    xlabel('cell #')
    ylabel('model #')
	colormap([[1 0 0];[0.5 0.5 0.5]])
    box off

% now measure the proportion of times a given cell was predicted to be each 
% cell type, note: all proportions are reported, one (i.e., max) is chosen 
count = 1;
for n = 1:size(YTest.ICnhp.NN,1)
    for ct = 1:4
        ctConf.ICnhp.nn(count,ct) = sum(YTest.ICnhp.NN(n,:)==ct)/size(YTest.ICnhp.NN,2);
    end
    [predCT(count,2),predCT(count,1)] = max(ctConf.ICnhp.nn(count,:));
    count = count + 1;
end
figure('Position',[50 50 360 60]); set(gcf,'color','w');
imagesc(ctConf.ICnhp.nn')
xlabel('cell #')
ylabel('cell type')
colormap('gray')
box off
   
% group accuracies
[B,I] = sort(correctRates.IC2ICnhp.NN,'ascend');
indPlot = 1:round(length(goodModelsIndex.NN)/5):length(goodModelsIndex.NN);
figure('Position',[50 50 220 200]); set(gcf,'color','w');
    hold on
    scatter(1:length(I),groupAccuracies.IC2ICnhp.NN(2,I)'*100,plots.mrkszr,'k')
    scatter(1:length(I),groupAccuracies.IC2ICnhp.NN(1,I)'*100,plots.mrkszr,'r')
    xticks(indPlot)
    xticklabels(round(B(indPlot)*100))
    xlabel('overall accuracy (%)')
    ylabel('cell type accuracy (%)')
    axis tight
    ylim([10 100])

clear temp C
for n = 1:length(predCT(:,1))
    if predCT(n,1) == 1; temp(n,1) = 1; C(n,:) = plots.cc(1,:);
    elseif predCT(n,1) == 2; temp(n,1) = 1; C(n,:) = plots.cc(2,:);
    elseif predCT(n,1) == 3; temp(n,1) = 1; C(n,:) = plots.cc(3,:);
    elseif predCT(n,1) == 4; temp(n,1) = 2; C(n,:) = plots.cc(4,:);
    end
end
figure('Position',[50 50 270 200]); set(gcf,'color','w');
    scatter3(Xnhp(:,1),Xnhp(:,2),Xnhp(:,3),...
        plots.mrkszr,C(:,:));
    grid on;     
    xlabel('trough-to-peak')
    ylabel('firing rate')
    zlabel('trough-to-peak ratio')
    view(-30,11)
    axis tight
% cp = classperf(yGT(ind),temp(ind));

clear C
for n = 1:length(temp(:,1))
    if temp(n,1) == 1; C(n,:) = plots.cc(1,:);
    elseif temp(n,1) == 2; C(n,:) = plots.cc(4,:);
    end
end    
figure('Position',[50 50 270 200]); set(gcf,'color','w');
    scatter3(Xnhp(:,1),Xnhp(:,2),Xnhp(:,3),...
        plots.mrkszr,C(:,:));
    grid on;     
    xlabel('trough-to-peak')
    ylabel('firing rate')
    zlabel('trough-to-peak ratio')
    view(-30,11)
    axis tight

close all

predStruct.nhpIC.IDs = specimenID.nhp.all;
predStruct.nhpIC.putLabel = YTest2.ICnhp.NN;
predStruct.nhpIC.gtLabel = yGT;

clear i