function h=RayleighFadingCoeff(Size)
%% generate Rayleigh fading (complex) coefficient vector or matrix
% input: output size list
% output: coefficient vector or matrix
%%

    pd_Env=makedist('Rayleigh','b',1);  % make distribution of Rayleigh 
    Env=random(pd_Env,Size);  % generate random value following distribution of Rayleigh for envelope
    pd_Pha=makedist('Uniform','lower',0,'upper',2*pi);  %make distribution of Uniform
    Pha=random(pd_Pha,Size);    % generate random value follwing distribution of Uniform for Phase
    h=Env.*exp(1j.*Pha);
end
