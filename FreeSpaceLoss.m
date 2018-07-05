function loss = FreeSpaceLoss(f,d)
%% 
% Free Space Loss 
%input: f central frequency[Hz], d distance[m], the form of d is matrix or arrangement
%output: Loss(Free Space Loss), the form of loss is matrix or arrangement.
%%

%% define
    VoL=3.0e8;      %velocity of light

%%

    loss=(4*pi*d*f/VoL);
end
