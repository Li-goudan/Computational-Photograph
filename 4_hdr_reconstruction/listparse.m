function [ filenames, times ] = listparse( listname )
%parses a list of imagenames and corresponding exposure times

fid = fopen(listname);

i=1;
while 1
    line = fgetl(fid);
    if(~ischar(line))
        break
    end
    
    [name, time] = strtok(line);
    filenames{i} = name;
    times(i) = str2double(time);
    i = i+1;
end

fclose(fid);
