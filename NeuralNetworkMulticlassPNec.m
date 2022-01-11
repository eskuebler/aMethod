function [net,valAccuracy,yTest] = NeuralNetworkMulticlassPNec(X,t,net,plots,Xtest)

x = X';
t = t';
net.trainParam.showWindow = false;
[net,tr] = train(net,x,t); % Train the Network
y = net(x); % Test the Network
valTargets = t .* tr.valMask{1};
valAccuracy = 1 - perform(net,valTargets,y);
% [~,yP]=max(y); 
% for n = 1:length(yP)
%     if yP(n) == 1; C(n,:) = plots.cc(1,:);
%     elseif yP(n) == 2; C(n,:) = plots.cc(2,:);
%     elseif yP(n) == 3; C(n,:) = plots.cc(4,:);
% %     elseif yP(n) == 4; C(n,:) = plots.cc(4,:);
%     end
% end
% figure('Position',[50 50 270 200]); set(gcf,'color','w');
%     scatter3(X(:,1),X(:,2),X(:,3),plots.mrkszr,C(:,:));
%     grid on;     
%     xlabel('trough-to-peak')
%     ylabel('firing rate')
%     zlabel('trough-to-peak ratio')
%     view(-30,11)
%     axis tight
% close
Ptest = net(Xtest');
[~,yTest]=max(Ptest);