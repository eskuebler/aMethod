%{
rescaleEC

here EC data is rescaled, specifically the range of E
%}

disp('rescaling EC distributions...')

rescalingT2P
rescalingT2PR
rescalingFR

X_IC = [T2P.mouse.allRe,fr.mouse.allRe,p2tr.mouse.allRe];
X_EC = [T2P.mouseVivo.allRe',fr.mouseVivo.allRe',p2tr.mouseVivo.allRe'];

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

clear Y