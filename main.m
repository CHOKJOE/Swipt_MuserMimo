%% main part

%% initialization
clear
close all
clc

paraset;

%% changing the number of relay's antenna
Lset=Lmin:1:Lmax;
Pout=NaN(Lmax-Lmin,N);
BER=NaN(Lmax-Lmin,N);
PoutR=NaN(Lmax-Lmin,N);
PoutD=NaN(Lmax-Lmin,N);

%% change directory
mainPath=pwd;
mkdir('result');
cd('result');
StragePath=pwd;
WSfileName=string(datetime);
WSfileName=strrep(WSfileName,'/','_');
WSfileName=strrep(WSfileName,' ','_');
WSfileName=strrep(WSfileName,':','_');
WSfileName="N"+num2str(N)+"_"+WSfileName+".mat";
save(WSfileName);
cd(mainPath);

for L=Lset
    snrUpperR=zeros(1,N);        % the number of Relay R's SNR upper than SNR threshold
    snrUpperD=zeros(1,N);        % the number of Destination D's SNR upper than SNR threshold
    snrUpperRD=zeros(1,N);          %the number of general SNR upper than SNR threshold
    bitError=zeros(1,N);     %the number of bit error
%% cycle part
    for cycle=1:numcyc
        SRcomm;
        AssignmentAntenna;
        RDcomm;
        snrUpperR=snrUpperR+(CalculateSNR(yR(LI),nR(LI)) >= snrTh_db);     % 1 if actual SNR is upper than SNR threshold, otherwise 0
        snrUpperD=snrUpperD+(CalculateSNR(yD,nD) >= snrTh_db);     % 1 if actual SNR is upper than SNR threshold, otherwise 0
        snrUpperRD=snrUpperRD+(CalculateSNR(yR(LI),nR(LI))>=snrTh_db).*(CalculateSNR(yD,nD)>=snrTh_db);     % 
        bitError=bitError+~(data==dataR);        % bit error 
    end

%% Outage Probability and Bit Error Rate
    Pout(L-N,:)=1 - (snrUpperRD/numcyc);   % outage probability
    PoutR(L-N,:)=1- (snrUpperR/numcyc);     
    PoutD(L-N,:)= 1 - (snrUpperD/numcyc);
    BER(L-N,:)=bitError/numcyc;        % Bit Error Rate
end


%% make table
row_name=cell(1,N);
row_name{1,1}='L';
for i=1:N
    comstr="row_name{1,"+num2str(i)+"+1}='S"+num2str(i)+"';";
    eval(comstr);
end

PoutT=table(vertcat(Lset,Pout'));
PoutT.Properties.RowNames=row_name;

PoutR_T=table(vertcat(Lset,PoutR'));
PoutR_T.Properties.RowNames=row_name;

PoutD_T=table(vertcat(Lset,PoutD'));
PoutD_T.Properties.RowNames=row_name;

BER_T=table(vertcat(Lset,BER'));
BER_T.Properties.RowNames=row_name;

%% save
cd(StragePath);
save(WSfileName, 'PoutT', '-append'); 
save(WSfileName, 'PoutR_T', '-append');
save(WSfileName, 'PoutD_T', '-append');
save(WSfileName, 'BER_T', '-append');
