%{

the idea here is to measure the outliers using the percentile to remove
extreme values from the dataset - only parameters that needed cleaning were
cleaned

%}

%{
IC mouse outliers
%}
% remove outliers 
outliersP2T = find(~isoutlier(T2P.mouse.all,'percentiles',[0 99.5]));
outliersP2Tr = find(~isoutlier(p2tr.mouse.all,'percentiles',[0 99.5]));
intVec = 1:length(T2P.mouse.all);
list.mouse.outliersT2PdVdt = intVec(ismember(intVec,outliersP2T)==0);
list.mouse.outliersP2Tr = intVec(ismember(intVec,outliersP2Tr)==0);
completeOutListIC = unique([list.mouse.outliersT2PdVdt,list.mouse.outliersP2Tr]);
completeListIC = intVec(ismember(intVec,completeOutListIC)==0);
intVec = 1:length(completeListIC);

list.mouse.spiny = intVec(ismember(completeListIC,list.mouse.spiny));
list.mouse.aspiny = intVec(ismember(completeListIC,list.mouse.aspiny));
list.mouse.PV = intVec(ismember(completeListIC,list.mouse.PV));
list.mouse.SST = intVec(ismember(completeListIC,list.mouse.SST));
list.mouse.VIP = intVec(ismember(completeListIC,list.mouse.VIP));
list.mouse.Pyr = intVec(ismember(completeListIC,list.mouse.Pyr));
X.mouse.all = X.mouse.all(completeListIC,:);
dVdt.mouse.all = dVdt.mouse.all(completeListIC,:);
specimenID.mouse.all = specimenID.mouse.all(completeListIC,:);
fr.mouse.all = fr.mouse.all(completeListIC);
for i = 1:length(completeListIC)
    spTimesClean.mouse.all{i,1} = spTimes.mouse.all{completeListIC(i),1};
end
T2P.mouse.all = T2P.mouse.all(completeListIC);
p2tr.mouse.all = p2tr.mouse.all(completeListIC);
p2trPeak.mouse.all = p2trPeak.mouse.all(completeListIC);
p2trTrough.mouse.all = p2trTrough.mouse.all(completeListIC);
ctTag.MouseIC = ctTag.MouseIC(completeListIC);

clear completeListIC completeOutListIC intVec outliersP2T outliersP2Tr

% remove NaN values from firing rate (from QC)
intVec = 1:length(fr.mouse.all);
list.mouse.removalsFR = find(isnan(fr.mouse.all));
completeListIC = intVec(ismember(intVec,list.mouse.removalsFR)==0);
intVec = 1:length(completeListIC);

list.mouse.spiny = intVec(ismember(completeListIC,list.mouse.spiny));
list.mouse.aspiny = intVec(ismember(completeListIC,list.mouse.aspiny));
list.mouse.PV = intVec(ismember(completeListIC,list.mouse.PV));
list.mouse.SST = intVec(ismember(completeListIC,list.mouse.SST));
list.mouse.VIP = intVec(ismember(completeListIC,list.mouse.VIP));
list.mouse.Pyr = intVec(ismember(completeListIC,list.mouse.Pyr));
X.mouse.all = X.mouse.all(completeListIC,:);
dVdt.mouse.all = dVdt.mouse.all(completeListIC,:);
specimenID.mouse.all = specimenID.mouse.all(completeListIC,:);
fr.mouse.all = fr.mouse.all(completeListIC);
for i = 1:length(completeListIC)
    spTimesClean.mouse.all{i,1} = spTimes.mouse.all{completeListIC(i),1};
end
T2P.mouse.all = T2P.mouse.all(completeListIC);
p2tr.mouse.all = p2tr.mouse.all(completeListIC);
p2trPeak.mouse.all = p2trPeak.mouse.all(completeListIC);
p2trTrough.mouse.all = p2trTrough.mouse.all(completeListIC);
ctTag.MouseIC = ctTag.MouseIC(completeListIC);

N.mouse = length(T2P.mouse.all);

clear completeListIC intVec

%{
IC NHP outliers
%}
outliersT2PDVDT = find(~isoutlier(T2P.nhp.all,'percentiles',[0 99.5]));
outliersP2Tr = find(~isoutlier(p2tr.nhp.all,'percentiles',[0 99.5]));
intVec = 1:length(T2P.nhp.all);
list.nhp.outliersT2PdVdt = intVec(ismember(intVec,outliersT2PDVDT)==0);
list.nhp.outliersP2Tr = intVec(ismember(intVec,outliersP2Tr)==0);
completeOutListIC = unique([list.nhp.outliersT2PdVdt,list.nhp.outliersP2Tr]);
completeListIC = intVec(ismember(intVec,completeOutListIC)==0);
intVec = 1:length(completeListIC);

list.nhp.spiny = intVec(ismember(completeListIC,list.nhp.spiny));
list.nhp.aspiny = intVec(ismember(completeListIC,list.nhp.aspiny));
list.nhp0.spiny = intVec(ismember(completeListIC,list.nhp0.spiny));
list.nhp0.aspiny = intVec(ismember(completeListIC,list.nhp0.aspiny));
p2tr.nhp.all = p2tr.nhp.all(completeListIC);
p2trPeak.nhp.all = p2trPeak.nhp.all(completeListIC);
p2trTrough.nhp.all = p2trTrough.nhp.all(completeListIC);
fr.nhp.all = fr.nhp.all(completeListIC);
for i = 1:length(completeListIC)
    spTimesClean.nhp.all{i,1} = spTimes.nhp.all{completeListIC(i),1};
end
T2P.nhp.all = T2P.nhp.all(completeListIC);
X.nhp.all = X.nhp.all(completeListIC,:);
dVdt.nhp.all = dVdt.nhp.all(completeListIC,:);
specimenID.nhp.all = specimenID.nhp.all(completeListIC,:);
ctTag.NhpIC = ctTag.NhpIC(completeListIC);

clear completeOutListIC completeListIC outliersHWDVDT outliersP2Tr intVec

intVec = 1:length(fr.nhp.all);
list.nhp.removals = find(isnan(fr.nhp.all));
completeListIC = intVec(ismember(intVec,list.nhp.removals)==0);
intVec = 1:length(completeListIC);

list.nhp.aspiny = intVec(ismember(completeListIC,list.nhp.aspiny));
list.nhp.spiny = intVec(ismember(completeListIC,list.nhp.spiny));
list.nhp0.aspiny = intVec(ismember(completeListIC,list.nhp0.aspiny));
list.nhp0.spiny = intVec(ismember(completeListIC,list.nhp0.spiny));
fr.nhp.all = fr.nhp.all(completeListIC);
for i = 1:length(completeListIC)
    spTimesClean.nhp.all{i,1} = spTimes.nhp.all{completeListIC(i),1};
end
T2P.nhp.all = T2P.nhp.all(completeListIC);
p2tr.nhp.all = p2tr.nhp.all(completeListIC);
p2trPeak.nhp.all = p2trPeak.nhp.all(completeListIC);
p2trTrough.nhp.all = p2trTrough.nhp.all(completeListIC);
X.nhp.all = X.nhp.all(completeListIC,:);
dVdt.nhp.all = dVdt.nhp.all(completeListIC,:);
specimenID.nhp.all = specimenID.nhp.all(completeListIC,:);
ctTag.NhpIC = ctTag.NhpIC(completeListIC);

N.nhp = length(T2P.nhp.all);

clear completeListIC intVec

%{
EC mouse outliers
%}
outliersP2tr = find(~isoutlier(p2tr.mouseVivo.all,'percentiles',[0 99.5]));
outliersT2P = find(~isoutlier(T2P.mouseVivo.all,'percentiles',[0 99.5]));
intVec = 1:length(p2tr.mouseVivo.all);
list.mouseVivo.outp2trP2Tr = intVec(ismember(intVec,outliersP2tr)==0);
list.mouseVivo.outp2troutliersT2P = intVec(ismember(intVec,outliersT2P)==0);
completeOutListEC = unique([list.mouseVivo.outp2trP2Tr,list.mouseVivo.outp2troutliersT2P]);
completeListEC = intVec(ismember(intVec,completeOutListEC)==0);
intVec = 1:length(completeListEC);

list.mouseVivo.PV = intVec(ismember(completeListEC,list.mouseVivo.PV));
list.mouseVivo.SST = intVec(ismember(completeListEC,list.mouseVivo.SST));
list.mouseVivo.VIP = intVec(ismember(completeListEC,list.mouseVivo.VIP));
list.mouseVivo.broad = intVec(ismember(completeListEC,list.mouseVivo.broad));
specimenID.mouseVivo.all = specimenID.mouseVivo.all(completeListEC,:);
p2tr.mouseVivo.all = p2tr.mouseVivo.all(completeListEC);
p2trPeak.mouseVivo.all = p2trPeak.mouseVivo.all(completeListEC);
p2trTrough.mouseVivo.all = p2trTrough.mouseVivo.all(completeListEC);
T2P.mouseVivo.all = T2P.mouseVivo.all(completeListEC);
fr.mouseVivo.all = fr.mouseVivo.all(completeListEC);
X.mouseVivo.all = X.mouseVivo.all(completeListEC,:);
ctTag.MouseEC = ctTag.MouseEC(completeListEC);

N.mouseVivo = length(T2P.mouseVivo.all);

clear completeListEC completeOutListEC intVec outliersLt outliersP2tr  

%{
NHP VIVO outliers
%}
outliersP2tr = find(~isoutlier(p2tr.nhpVivo.all,'percentiles',[0 99.5]));
outliersT2P = find(~isoutlier(T2P.nhpVivo.all,'percentiles',[0 99.5]));
intVec = 1:length(fr.nhpVivo.all);
list.nhpVivo.outliersP2tr = intVec(ismember(intVec,outliersP2tr)==0);
list.nhpVivo.outliersT2P = intVec(ismember(intVec,outliersT2P)==0);
completeOutListECnhp = unique([list.nhpVivo.outliersP2tr,list.nhpVivo.outliersT2P]);
completeListEC = intVec(ismember(intVec,completeOutListECnhp)==0);

fr.nhpVivo.all = fr.nhpVivo.all(completeListEC);
p2tr.nhpVivo.all = p2tr.nhpVivo.all(completeListEC);
p2trPeak.nhpVivo.all = p2trPeak.nhpVivo.all(completeListEC);
p2trTrough.nhpVivo.all = p2trTrough.nhpVivo.all(completeListEC);
T2P.nhpVivo.all = T2P.nhpVivo.all(completeListEC);
X.nhpVivo.all = X.nhpVivo.all(completeListEC,:);
specimenID.nhpVivo.all = specimenID.nhpVivo.all(completeListEC,:);

N.nhpVivo = length(T2P.nhpVivo.all);

clear completeListEC completeOutListECnhp intVec outliersLT outliersP2tr

clear outliersP2tr outliersLT outliersFR intVec completeOutListECnhp completeListEC