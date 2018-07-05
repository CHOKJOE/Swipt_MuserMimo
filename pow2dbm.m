function dbm=pow2dbm(pow)
%%
% transform power to dbm
% input:power[W]
% output:dBm[dbm]
%%

    pow(~(pow>=0))=Inf;
    dbm=pow2db(pow*1000);
    dbm(dbm==Inf) = NaN;
end
