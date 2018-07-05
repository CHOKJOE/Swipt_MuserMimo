%% communication between S and R
% Generate data and modulate it at source S. Then, S transmit signal to Relay R.
% Relay R receives signals transmitted by S. At this time, Relay R uses L antennas for information and Energy, where Relay R ackknowledges CSI between S and R.
%%

%% a period action
data=GeneData(N);   % generate data
bsigS=mybPskMod(data); % modulate data 
H_SR=RayleighFadingCoeff([L N]);    % generate Rayleigh fading complex coefficient
nR=ComAwgnNoise([1 L],PN_dbm);      % generate noise at Relay R
yR=H_SR*sqrt(dbm2pow(PrR_dbm))*bsigS+nR;     % reception signal at R
