function pow=dbm2pow(dbm)
%%
% transform dBm to power
% dbm: power for dbm [dbm] , power [W]
%%
    dbm(~(abs(dbm)>=0)) = Inf;
    pow=db2pow(dbm-30);
    pow(pow==Inf)=NaN;
end
