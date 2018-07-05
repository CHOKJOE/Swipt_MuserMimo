function noise = ComAwgnNoise(Nsize,pn_dbm)
%%
% generator of complex Additive White Gausian Noise
% Nsize:size of noise
% pn: noise power [dbm]
%%

    noise=(randn(Nsize)+1j*(randn(Nsize)))*sqrt(dbm2pow(pn_dbm)/2);
    return
end
