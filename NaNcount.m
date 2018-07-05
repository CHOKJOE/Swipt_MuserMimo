function y = NaNcount(data)
%%
%count NaN in data.
%%

%% previous
%    y=0;
%    for i=1:length(data)
%        if isnan(data(i))
%            y=y+1;
%        end
%    end

%% improvement
    y=sum(isnan(data));
end
