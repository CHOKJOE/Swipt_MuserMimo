%% parameters sets up
N=2;    %the number of source S and Destination's antenna
Lmin=N+1;    %the minimum number of relay's antenna
Lmax=N+10;    %the maximum number of relay's antenna
fc=920e6;       %carrier frequency[Hz]
PtS_dbm=20;     %source's transmission power [dBm]
gt_dbi=2.85;    %transmitting antenna gain[dBi]
gr_dbi=2.85;    %receiving antenna gain[dBi]
dSR=[1 2];      %distance between S and R[m]
dRD=2;          %distance between R and D[m]
bitrate=1e6;    %bitrate[bps]
PN_dbm=-174+pow2db(bitrate);   % noise power of 300K for bitrate
Tu=1e-6;        %time unit[s]
eta=0.8;        %harvesting efficiency
VoL=3.0e8;      % velocity of light
snrTh_db=30;    % SNR threshold for Outage Probability
numcyc=1e2;     % the number of cycle

%% calculate
lossSR=FreeSpaceLoss(fc,dSR);   %free space loss between each S and R
lossRD=FreeSpaceLoss(fc,dRD);   %free space loss between R and D
PrR_dbm=diag(PtS_dbm+gt_dbi+gr_dbi-pow2db(lossSR)); %reception power matrix
PrR_dbm(PrR_dbm==0)=-Inf;