%% communication betwenn Relay R and Destination D
% Relay R modulate demodulated data again and transmits with antennas for information LI, where Relay R's transmission power is all harvested energy.

%%demodulation and modulation
dataR=mybPskDemod(yR(LI));  %demodulation
bsigR=mybPskMod(dataR); %modulate data demodulated by Relay R

%%harvesting and Relay R's transmission power
E=eta*Tu*sum(abs(yR(LE)).^2);   %harvesting energy
PtR_dbm=pow2dbm(E/Tu*1/N);       % transmission power for one antenna
PrD_dbm=diag(PtR_dbm + gt_dbi + gr_dbi - pow2db(lossRD));   % reception power matrix

%% path and noise creation
H_RD=RayleighFadingCoeff([N N]);        % generate Rayleigh fading complex coefficient
nD=ComAwgnNoise([1 N],PN_dbm);          % generate noise at Relay R
yD=H_RD*sqrt(dbm2pow(PrD_dbm))*bsigR+nD;    % reception signal at R

%% demodulatiion
dataD=mybPskDemod(yD);      % modulation at Destination D
