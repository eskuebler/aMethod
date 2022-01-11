
% generate models, first Gaussian, then logistic regression, then neural
% network (thus increasing in accurcy along this axis)

disp('classifying EC cell types...')

load('ECsets')

plots.ccEC = [1 0 0;...
    0 1 0;...
    0 0 0];

for numRands = 1:fits.numRand % generate numRands models
      
    Xinput = Xtrain{numRands,1};
    Xtesting = Xtest{numRands,1};
    yT = ytest{numRands,1};
    yTrain = [ones(46,1);ones(46,1)+1;ones(46,1)+2];
    for n = 1:length(yTrain)
        if yTrain(n) == 1; C(n,:) = plots.cc(1,:);
        elseif yTrain(n) == 2; C(n,:) = plots.cc(2,:);
        elseif yTrain(n) == 3; C(n,:) = plots.cc(4,:);
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
    
    % supervised neural network (for loop is for testing layers and cell numbers)
    % configure net
    net = patternnet(12, 'trainscg'); % Scaled conjugate gradient backpropagation.
    net.divideFcn = 'dividerand';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 30/100;
    net.divideParam.testRatio = 0/100;
    net.performFcn = 'mse';  % % Choose mse Performance Function
    [EC.multiNNMdl{numRands},EC.nn.performance(numRands),yTest] = ...
        NeuralNetworkMulticlassPNec(Xinput,y,net,plots,Xtesting); % NN-PR function;
    cp = classperf(yT,yTest); clear yTest
    groupAccuracies.NNec(:,numRands) = 1-(cp.ErrorDistributionByClass ...
        ./ cp.SampleDistributionByClass);
    correctRates.NNec(numRands,1) = cp.CorrectRate;
%     x = cp.CountingMatrix(1:3,1:3);
%     x(:,1) = x(:,1)/sum(yT==1);
%     x(:,2) = x(:,2)/sum(yT==2);
%     x(:,3) = x(:,3)/sum(yT==3);
%     figure('Position',[50 50 140 120]); set(gcf,'color','w');
%     heatmap(x)
%     colormap('gray')
%     xlabel('cell type')
%     ylabel('cluster #')
%     close
%     clear x
end
edges.grpAcc.EC = 50:2.5:100;

% group accuracies for NN    
[B,I] = sort(correctRates.NNec,'ascend');
ind = 1:fits.numRand/5:1000;
figure('Position',[50 50 150 200]); set(gcf,'color','w');
    hold on
    scatter(1:length(groupAccuracies.NNec(3,I)),(groupAccuracies.NNec(3,I)')*100,1,'k')
    scatter(1:length(groupAccuracies.NNec(2,I)),(groupAccuracies.NNec(2,I)')*100,1,'g','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.7)
    scatter(1:length(groupAccuracies.NNec(1,I)),(groupAccuracies.NNec(1,I)')*100,1,'r','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.7)    
    
    xticks(ind)
    xticklabels(round(B(ind)*100))
    xlabel('overall accuracy (%)')
    ylabel('cell type accuracy (%)')
    ylim([0 100])
close all    

overallMin = 0.8;
cellTypeMin = 0.7;
goodModelsIndex.NNec = find(correctRates.NNec(1,:)>overallMin & ...
    groupAccuracies.NNec(1,:)>cellTypeMin & ...
    groupAccuracies.NNec(2,:)>cellTypeMin & ...
    groupAccuracies.NNec(3,:)>cellTypeMin);

clear numRands e numCells numLayers y yNum yT yTest Xinput Xtest Xtesting ...
    Xtrain ytest
