function snr_db=CalculateSNR(y,n)
%% calculate SNR
%input:y signal with noise, n noise
%output: snr[db]
%%

    PN_dbm=pow2dbm(abs(n).^2);
    Psig_dbm=pow2dbm(abs(y-n).^2);
    snr_db=(Psig_dbm-PN_dbm)';
end
