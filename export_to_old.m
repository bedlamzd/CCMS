clear
clc
close all

file_pattern = 'L*/**/src/*.slx';

files = string([]);
for file = dir(file_pattern)'
    files(end+1) = strcat(file.folder, "\", file.name);
end

versions = ["R2018b"...
            "R2017b"...
            "R2015b"];
for file = files
    [filepath,name,ext] = fileparts(file);
    disp(filepath);
    open(file);
    if ~exist(filepath + '\old\', 'dir')
        mkdir(filepath + '\old\')
    end
    for v = versions
        Simulink.exportToVersion(name, filepath + '\old\' + name + '_' + v, v)
    end
    close_system
end

