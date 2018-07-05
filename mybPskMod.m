function sig=mybPskMod(data)
%% 
% modulate data to bpsk
%input:data
%output:signal(base band)
%%
    phase=data*pi;
    sig=(exp(1j*phase))';
end
