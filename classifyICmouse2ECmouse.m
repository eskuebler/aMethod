%{
classifyIC2EC
- here we see how well the models of the IC cell types correspond to the EC
dataset
- only cells with ground truth labels have been included
- in this scenario we had inequalities in group sizes.
%}

disp('classifying EC cell types with IC models...')

% define a vector for ground truth
ind = find(ctTag.MouseEC==1 | ctTag.MouseEC==2 | ...
    ctTag.MouseEC==3 | ctTag.MouseEC==4);
specimenID.mouseVivo.wCellTypeLabels = specimenID.mouseVivo.all(ind,1);
yGT = ctTag.MouseEC(ind); % EC mouse ground truth labels
targetVec = [sum(yGT==1),sum(yGT==2),sum(yGT==3),sum(yGT==4)];

% yGTdend
yGTdend = yGT;
yGTdend(yGTdend==2) = 1;
yGTdend(yGTdend==3) = 1;
yGTdend(yGTdend==4) = 2;
    
% show some data that we will classify
Y = X_EC;
figure('Position',[50 50 270 200]); set(gcf,'color','w');
hold on
scatter3(Y(:,1),Y(:,2),zeros(size(Y,1),1),5,[0.9,0.9,0.9])
scatter3(Y(:,1),zeros(size(Y,1),1)+max(Y(:,2)),Y(:,3),5,[0.9,0.9,0.9])
scatter3(zeros(size(Y,1),1)+max(Y(:,1)),Y(:,2),Y(:,3),5,[0.9,0.9,0.9])
scatter3(Y(list.mouseVivo.PV,1),Y(list.mouseVivo.PV,2),Y(list.mouseVivo.PV,3),5,'r')
scatter3(Y(list.mouseVivo.SST,1),Y(list.mouseVivo.SST,2),Y(list.mouseVivo.SST,3),5,'g')
scatter3(Y(list.mouseVivo.VIP,1),Y(list.mouseVivo.VIP,2),Y(list.mouseVivo.VIP,3),5,'b')
scatter3(Y(list.mouseVivo.broad,1),Y(list.mouseVivo.broad,2),Y(list.mouseVivo.broad,3),5,'k')
xlabel('trough-to-peak')
ylabel('firing rate')
zlabel('trough-to-peak ratio')
grid on
box off
view(plots.az,plots.el)
axis tight

% show simple bar graph of counts for cell types
figure('Position',[50 50 150 130]); set(gcf,'color','w');
    bar([sum(yGT==1),sum(yGT==2),sum(yGT==3),sum(yGT==4)],'k')
    xlabel('cell type')
    ylabel('# of cells')
    box off
    axis tight
    xlim([0.5 4.5])

% show ground truth labels
figure('Position',[50 50 360 50]); set(gcf,'color','w');
imagesc(yGT)
xlabel('cell #')
colormap([[1 0 0];[0 1 0];[0 0 1];[0.5 0.5 0.5]])
box off

close all

% load('neuralNetworkIC')
count = 0;
for numRands = goodModelsIndex.NN % generate numRands models
    count = count + 1;
    net = multiNNMdl{numRands,1};
    Ptest = net(X_EC');
    [~,yTest] = max(Ptest);
%     yTest = str2double(yTest);
    YTest.NN(:,count) = yTest;
    yTest2 = yTest(ind);
    YTest.NNlabels(count,:) = yTest2;
    yVec.NN(count,:) = [sum(yTest2==1),sum(yTest2==2),sum(yTest2==3),sum(yTest2==4)];
    distanceY.IC2EC.NN(count,:) = (targetVec-yVec.NN(count,:));
    corrYY.IC2EC.NN(count,:) = corr(yGT',yTest2','type','Spearman');
    cp = classperf(yGT,yTest2);
    groupAccuracies.IC2EC.NN(:,count) = 1-(cp.ErrorDistributionByClass ...
        ./ cp.SampleDistributionByClass);
    correctRates.IC2EC.NN(1,count) = cp.CorrectRate;
    putativeIntVec = find(yTest==1 | yTest==2 | yTest==3);
    prop.mouseVivo.nn.putativePV(1,count) = length(find(ismember(list.mouseVivo.PV,putativeIntVec)))/length(list.mouseVivo.PV);
    prop.mouseVivo.nn.putativeSST(1,count) = length(find(ismember(list.mouseVivo.SST,putativeIntVec)))/length(list.mouseVivo.SST);
    prop.mouseVivo.nn.putativeVIP(1,count) = length(find(ismember(list.mouseVivo.VIP,putativeIntVec)))/length(list.mouseVivo.VIP);
    
    % reduce cell type labels to dendrite type labels
%     yTest2dend = yTest2;
%     yTest2dend(yTest2dend==2) = 1;
%     yTest2dend(yTest2dend==3) = 1;
%     yTest2dend(yTest2dend==4) = 2;
%     cp = classperf(yGTdend,yTest2dend);
%     correctRates.IC2EC.NNdend(1,count) = cp.CorrectRate;
%     groupAccuracies.IC2EC.NNdend(:,count) = 1-(cp.ErrorDistributionByClass ...
%         ./ cp.SampleDistributionByClass);

    % plot results of classification
%     for n = 1:length(yTest)
%         if yTest(n) == 1; C(n,:) = plots.cc(1,:);
%         elseif yTest(n) == 2; C(n,:) = plots.cc(2,:);
%         elseif yTest(n) == 3; C(n,:) = plots.cc(3,:);
%         elseif yTest(n) == 4; C(n,:) = plots.cc(4,:);
%         end
%     end
%     figure('Position',[50 50 270 200]); set(gcf,'color','w');
%         scatter3(X_EC(ind,1),X_EC(ind,2),X_EC(ind,3),...
%             plots.mrkszr,C(ind,:));
%         grid on;     
%         xlabel('trough-to-peak')
%         ylabel('firing rate')
%         zlabel('trough-to-peak ratio')
%         view(-30,11)
%         axis tight
% 
%     x = cp.CountingMatrix(1:4,1:4);
%     x(:,1) = x(:,1)/sum(yGT==1);
%     x(:,2) = x(:,2)/sum(yGT==2);
%     x(:,3) = x(:,3)/sum(yGT==3);
%     x(:,4) = x(:,4)/sum(yGT==4);
%     figure('Position',[50 50 160 125]); set(gcf,'color','w');
%     heatmap(x)
%     colormap('gray')
%     xlabel('cell type')
%     ylabel('cluster #')

%     close all
    clear yTest yTest2 x
end
clear numRands n x count

% show the matrix of predictions
figure('Position',[50 50 360 100]); set(gcf,'color','w');
    imagesc(YTest.NN(ind,:)')
    xlabel('cell #')
    ylabel('model #')
    colormap([[1 0 0];[0 1 0];[0 0 1];[0.5 0.5 0.5]])
    box off

% now measure the proportion of times a given cell was predicted to be each 
% cell type, note: all proportions are reported, one (i.e., max) is chosen 
for n = 1:size(YTest.NN,1)
    for ct = 1:4
        ctConf.IC2EC.nn(n,ct) = sum(YTest.NN(n,:)==ct)/size(YTest.NN,2);
    end
end
figure('Position',[50 50 360 100]); set(gcf,'color','w');
    imagesc(ctConf.IC2EC.nn(ind,:)')
    xlabel('cell #')
    ylabel('cell type')
    colormap('gray')
    box off

% group accuracies
[B,I] = sort(correctRates.IC2EC.NN,'ascend');
indPlot = 1:round(length(goodModelsIndex.NN)/5):length(goodModelsIndex.NN);
figure('Position',[50 50 220 200]); set(gcf,'color','w');
    hold on
    scatter(1:length(I),groupAccuracies.IC2EC.NN(4,I)'*100,plots.mrkszr,'k')
    scatter(1:length(I),groupAccuracies.IC2EC.NN(3,I)'*100,plots.mrkszr,'b')
    scatter(1:length(I),groupAccuracies.IC2EC.NN(2,I)'*100,plots.mrkszr,'g')
    scatter(1:length(I),groupAccuracies.IC2EC.NN(1,I)'*100,plots.mrkszr,'r')
    xticks(indPlot)
    xticklabels(round(B(indPlot)*100))
    xlabel('overall accuracy (%)')
    ylabel('cell type accuracy (%)')
    ylim([10 100])

% relation between the accuracy of models for IC and EC
figure('Position',[50 50 220 200]); set(gcf,'color','w');
    hold on
    scatter(correctRates.NN(goodModelsIndex.NN)*100,correctRates.IC2EC.NN*100,plots.mrkszr,[0.5 0.5 0.5])
    scatter(groupAccuracies.NN(4,goodModelsIndex.NN)'*100, ...
        groupAccuracies.IC2EC.NN(4,:)'*100,plots.mrkszr,'k')
    scatter(groupAccuracies.NN(3,goodModelsIndex.NN)'*100, ...
        groupAccuracies.IC2EC.NN(3,:)'*100,plots.mrkszr,'b')
    scatter(groupAccuracies.NN(2,goodModelsIndex.NN)'*100, ...
        groupAccuracies.IC2EC.NN(2,:)'*100,plots.mrkszr,'g')
    scatter(groupAccuracies.NN(1,goodModelsIndex.NN)'*100, ...
        groupAccuracies.IC2EC.NN(1,:)'*100,plots.mrkszr,'r')
    plot([0 100],[0 100],'k-.','linewidth',0.5)
    xlabel('IC accuracy (%)')
    ylabel('EC accuracy (%)')   
    xlim([70 100])
    ylim([10 100])
    grid on
    
close all

predStruct.mouseVivo.IDs = specimenID.mouseVivo.wCellTypeLabels;
predStruct.mouseVivo.putLabel = YTest.NNlabels;
predStruct.mouseVivo.gtLabel = yGT;

clear numRands