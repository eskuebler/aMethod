%{
analyzeWFsMMHSvitro
- waveforms for mouse, nhp, & human ex vivo recordings
%}

disp(['analyzing mouse & NHP intracellular waveforms...'])

% load data
load(datafile.IC); mainParams = IC; clear IC % main data source
IDai = mainParams.ID;

%{

!!!!!!!!!!!!!

here the NHP dendrite type should be the newer file

!!!!!!!!!!!!!

%}
load('NHPdend.mat','oldCellID','DendriteType')
indNew = find(ismember(oldCellID,IDai)); % find matching IDs
newDend = DendriteType(indNew); % pull new dendrite labels
mainParams.dendrite_type(1:length(indNew)) = newDend;
load(datafile.NHPdend); IDdend = ID; clear ID oldCellID DendriteType newDend

% load mouse pyramidal cell IDs
load(datafile.MMpyrIDs); % mouse pyramidal cells 
for n = 1:length(ID)
    IDpyr(n,1) = string([num2str(ID(n,1)),'__AI']);
end

% initialize parameter storage
X.mouse.all = []; X.nhp.all = [];
dVdt.mouse.all = []; dVdt.nhp.all = [];
list.mouse.spiny = []; list.mouse.aspiny = [];
list.mouse.PV = []; list.mouse.VIP = []; list.mouse.SST = []; list.mouse.Pyr = [];
list.nhp.spiny = []; list.nhp0.spiny = [];
list.nhp.aspiny = []; list.nhp0.aspiny = [];

N.mouse = 1; N.nhp = 1;
for n = 1:length(mainParams.specimen)
            
    x = mainParams.wf(n,:);
    x = x(1:210);
    if ~isnan(x(1,1))
        if sum(abs(x))==0
            continue
        end

        % trough-to-peak of dV/dt
        dVdtTemp = smooth(diff(x/sample.dtIn));
        [val1,maxdVdtTime] = max(dVdtTemp);                     % peak of dV/dt
        [val2,mindVdtTime] = min(dVdtTemp);                     % trough of dV/dt
        tempT2PdVdt = (mindVdtTime-maxdVdtTime)*sample.dtIn;    % trough-to-peak
        temp2 = abs(val1)/abs(val2);                            % trough-to-peak ratio

        if mainParams.specimen(n,1) == 'Mus musculus'
            X.mouse.all = [X.mouse.all; x(1:end-1)];
            dVdt.mouse.all = [dVdt.mouse.all; dVdtTemp'];
            specimenID.mouse.all(N.mouse,1) = string(IDai(n,:));

            fr.mouse.all(N.mouse,1) = mainParams.mdn_insta_freq(n);
            spTimes.mouse.all{N.mouse,1} = mainParams.mdn_insta_freq_times{n,1};
            p2trPeak.mouse.all(N.mouse,1) = abs(val1);
            p2trTrough.mouse.all(N.mouse,1) = val2;
            p2tr.mouse.all(N.mouse,1) = temp2;
            T2P.mouse.all(N.mouse,1) = tempT2PdVdt;
            
            if mainParams.dendrite_type(n,1)=='spiny'
                list.mouse.spiny = [list.mouse.spiny, N.mouse];
            elseif mainParams.dendrite_type(n,1)=='aspiny' | ...
                    mainParams.dendrite_type(n,:) == 'sparsely spiny'
                list.mouse.aspiny = [list.mouse.aspiny, N.mouse];
            end
            if mainParams.transline(n,1)=='Pvalb-IRES-Cre' && ...
                    mainParams.reporterStatus(n,1)=='positive'
                list.mouse.PV = [list.mouse.PV, N.mouse];
                ctTag.MouseIC(1,N.mouse) = 1;
            elseif mainParams.transline(n,1)=='Vip-IRES-Cre' && ...
                    mainParams.reporterStatus(n,1)=='positive'                
                list.mouse.VIP = [list.mouse.VIP, N.mouse];
                ctTag.MouseIC(1,N.mouse) = 3;
            elseif mainParams.transline(n,1)=='Sst-IRES-Cre' && ...
                    mainParams.reporterStatus(n,1)=='positive'
                list.mouse.SST = [list.mouse.SST, N.mouse];
                ctTag.MouseIC(1,N.mouse) = 2;
            end
            if ismember(IDai(n,:),IDpyr)
                list.mouse.Pyr = [list.mouse.Pyr, N.mouse];
                ctTag.MouseIC(1,N.mouse) = 4;
            end
            N.mouse = N.mouse + 1;
        elseif mainParams.specimen(n,1) == 'NHP'
            X.nhp.all = [X.nhp.all; x(1:end-1)];
            dVdt.nhp.all = [dVdt.nhp.all; dVdtTemp'];
            specimenID.nhp.all(N.nhp,1) = string(IDai(n,:));

            fr.nhp.all(N.nhp,1) = mainParams.mdn_insta_freq(n);
            spTimes.nhp.all{N.nhp,1} = mainParams.mdn_insta_freq_times{n,1};
            T2P.nhp.all(N.nhp,1) = tempT2PdVdt;
            p2trPeak.nhp.all(N.nhp,1) = abs(val1);
            p2trTrough.nhp.all(N.nhp,1) = val2;
            p2tr.nhp.all(N.nhp,1) = temp2;
           
            loc = find(ismember(IDdend,IDai(n,:))==1);
            if mainParams.dendrite_type(n,1)=='S'
                ctTag.NhpIC(1,N.nhp) = 2;
                list.nhp.spiny = [list.nhp.spiny,N.nhp];
                list.nhp0.spiny = [list.nhp0.spiny,n];
            elseif mainParams.dendrite_type(n,1)=='A'
                ctTag.NhpIC(1,N.nhp) = 1;
                list.nhp.aspiny = [list.nhp.aspiny,N.nhp];
                list.nhp0.aspiny = [list.nhp0.aspiny,n];
            else
                ctTag.NhpIC(1,N.nhp) = 0;
            end
            N.nhp = N.nhp + 1;
        end
        clear dVdtTemp halfHeight halfHeightTpost halfHeightTpre loc ...
            maxdVdtTime mindVdtTime peakTime peakV temp2 tempHW ...
            tempHWdVdt troughTime troughV val1 val2 x
    end
end
N.mouse = N.mouse-1; N.nhp = N.nhp-1;
% wfsP.nbTs = size(X.mouse.all,2);             % number of time-steps in wfs
ctTag.MouseIC(1,1873:1895) = 0;
clear AccesResistance dendrite_type ID IDai IDdend IDpyr Layer n ...
    Resting_membrane specimen Temperature mainParams