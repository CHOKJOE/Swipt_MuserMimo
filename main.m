%% main part

%% initialization
clear
close all
clc

paraset;

%% changing the number of relay's antenna
Lset=[Lmin:1:Lmax];
Pout=NaN(Lmax-Lmin,N);
BER=NaN(Lmax-Lmin,N);
PoutR=NaN(Lmax-Lmin,N);
PoutD=NaN(Lmax-Lmin,N);

%% change directory
abspath=pwd;
mkdir('result');
cd('result');
abspath=pwd;
WSfileName=string(datetime);
strrep(WSfileName,'/','_');
strrep(WSfileName,' ','_');
strrep(WSfileName,':','_');
WSfileName='N'+num2str(N)+'_'+WSfileName+'.mat';
save(WSfileName);

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
        snrUpperR=snrUpperR+(CalculateSNR(yR,nR) >= snrTh_db);     % 1 if actual SNR is upper than SNR threshold, otherwise 0
        snrUpperD=snrUpperD+(CalculateSNR(yD,nD) >= snrTh_db);     % 1 if actual SNR is upper than SNR threshold, otherwise 0
        snrUpperRD=(CalculateSNR(yR,nR)>=snrTh_db)*(CalculateSNR(yD,nD)>=snrTh_db);     % 
        bitError=bitError+~(data==dataR);        % bit error 
    end

%% Outage Probability and Bit Error Rate
    Pout(L-N,:)=1 - (snrUpperRD/numcyc);   % outage probability
    PoutR(L-N,:)=1- (snrUpperR/numcyc);     
    PoutD(L-N,:)= 1 - (snrUpperD/numcyc);
    BER(L-N,:)=bitError/numcyc;        % Bit Error Rate
end


%% make table
row_name=cell(1,Lmax-Lmin+2);
row_name{1,1}='S';
for i=Lset
    comstr='row_name{1,"+num2str(i)+"+1}='I_"+num2str(i)+"'";
    eval(comstr);
end

PoutT=table(vertcat([1:N],Pout'));
PoutT.Properties.RowNames=row_name;

PoutR_T=table(vertcat([1:N],PoutR'));
PoutR_T.Properties.RowNames=row_name;

PoutD_T=table(vertcat([1:N],PoutD'));
PoutD_T.Properties.RowNames=row_name;

BER_T=table(vertcat([1:N],BER'));
BER_T.Properties.RowNames=row_name;

%% save 
save WSfileName PoutT PoutR_T PoutD_T BER_T '-append';
