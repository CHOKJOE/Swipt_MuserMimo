function data=mybPskDemod(sig)
%%
% Demodulate base-band signal to data
%input:base-band signal 
%output:data
%%

    phase=abs(angle(sig));
    data=((pi/2)<=phase);
end
