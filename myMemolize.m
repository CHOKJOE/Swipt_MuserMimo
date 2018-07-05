function CurrentPath=myMemolize(data,filename,path)
%%
%store data to file of the name filename in path
% make directory that the name is at that time.
% store data .
%%

    cd(path);
    store_folder=string(datatime);
    strrep(store_folder,'/','_');
    strrep(store_folder,' ','_');
    strrep(store_folder,':','_');
    mkdir(store_folder);
    cd(store_folder);
    writetable(data,filename,'WriteRowNames',true);
    CurrentPath=cd;
end
