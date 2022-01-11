
% generate models, first Gaussian, then logistic regression, then neural
% network (thus increasing in accurcy along this axis)

disp('classifying IC cell types...')

load('ICsets')

numCells = 12;
minPV = min(find(yNum==1));
maxPV = max(find(yNum==1));
minSST = min(find(yNum==2));
maxSST = max(find(yNum==2));
minVIP = min(find(yNum==3));
maxVIP = max(find(yNum==3));
minPyr = min(find(yNum==4));
maxPyr = max(find(yNum==4));
numNNtrain = round(sum(yNum==1)*.85);
numNNval = round(sum(yNum==1)*.15);

multiNNMdl = cell(fits.numRand,1);

for numRands = 1:fits.numRand % generate numRands models
      
    Xinput = Xtrain{numRands,1};
    Xtesting = Xtest{numRands,1};
    yT = ytest{numRands,1};
    yTrain = [ones(63,1);ones(63,1)+1;ones(63,1)+2;ones(63,1)+3];
    for n = 1:length(yTrain)
        if yTrain(n) == 1; C(n,:) = plots.cc(1,:);
        elseif yTrain(n) == 2; C(n,:) = plots.cc(2,:);
        elseif yTrain(n) == 3; C(n,:) = plots.cc(3,:);
        elseif yTrain(n) == 4; C(n,:) = plots.cc(4,:);
        end
    end
%     figure('Position',[50 50 270 200]); set(gcf,'color','w');
%         scatter3(Xinput(:,1),Xinput(:,2),Xinput(:,3),...
%             plots.mrkszr,C(:,:));
%         grid on;     
%         xlabel('trough-to-peak')
%         ylabel('firing rate')
%         zlabel('trough-to-peak ratio')
%         view(-30,11)
%         axis tight
%         close
        
    % supervised neural network (single hidden layer with numCells cells)
    trainIndex = [randperm(sum(yNum==1),numNNtrain),...
        randperm(sum(yNum==2),numNNtrain)+find(yNum==1,1,'last'),...
        randperm(sum(yNum==3),numNNtrain)+find(yNum==2,1,'last'),...
        randperm(sum(yNum==4),numNNtrain)+find(yNum==3,1,'last')];
    validationIndex = find(~ismember(1:length(yNum),trainIndex));
    % configure net
    net = patternnet(numCells, 'trainscg'); % Scaled conjugate gradient backpropagation.
    net.divideFcn = 'divideind';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainInd = trainIndex;
    net.divideParam.valInd = validationIndex;
    net.divideParam.testInd = [];
    net.performFcn = 'mse';  % % Choose mse Performance Function
    [multiNNMdl{numRands,1},IC.nn.performance(numRands),yTest] = ...
        NeuralNetworkMulticlassPN(Xinput,y,net,plots,Xtesting); % NN-PR function;
    cp = classperf(yT,yTest); %clear yTest
    groupAccuracies.NN(:,numRands) = 1-(cp.ErrorDistributionByClass ...
        ./ cp.SampleDistributionByClass);
    correctRates.NN(1,numRands) = cp.CorrectRate;
%     x = cp.CountingMatrix(1:4,1:4);
%     x(:,1) = x(:,1)/sum(yT==1);
%     x(:,2) = x(:,2)/sum(yT==2);
%     x(:,3) = x(:,3)/sum(yT==3);
%     x(:,4) = x(:,4)/sum(yT==4);
%     figure('Position',[50 50 160 125]); set(gcf,'color','w');
%     heatmap(x)
%     colormap('gray')
%     xlabel('cell type')
%     ylabel('cluster #')
%     close
%     clear x
end

% save('neuralNetworkIC','multiNNMdl'); clear multiNNMdl

edges.grpAcc.IC = 50:2.5:100;

ind = 1:fits.numRand/5:fits.numRand;

% group accuracies for NN    
[B,I] = sort(correctRates.NN,'ascend');
ind = 1:fits.numRand/5:1000;
figure('Position',[50 50 150 200]); set(gcf,'color','w');
    hold on
    scatter(1:length(groupAccuracies.NN(4,I)),(groupAccuracies.NN(4,I)')*100,1,'k')
    scatter(1:length(groupAccuracies.NN(3,I)),(groupAccuracies.NN(3,I)')*100,1,'b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.7)
    scatter(1:length(groupAccuracies.NN(2,I)),(groupAccuracies.NN(2,I)')*100,1,'g','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.7)
    scatter(1:length(groupAccuracies.NN(1,I)),(groupAccuracies.NN(1,I)')*100,1,'r','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.7)
    xticks(ind)
    xticklabels(round(B(ind)*100))
    xlabel('overall accuracy (%)')
    ylabel('cell type accuracy (%)')
    ylim([0 100])
close all

overallMin = 0.8;
cellTypeMin = 0.7;
goodModelsIndex.NN = find(correctRates.NN(1,:)>overallMin & ...
    groupAccuracies.NN(1,:)>cellTypeMin & ...
    groupAccuracies.NN(2,:)>cellTypeMin & ...
    groupAccuracies.NN(3,:)>cellTypeMin & ...
    groupAccuracies.NN(4,:)>cellTypeMin);

clear numRands numCells numLayers y yNum yT yTest Xinput Xtest Xtesting ...
    Xtrain ytest C