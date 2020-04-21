clear
clc
close all

file_pattern = 'L*/**/src/*.slx'; 

files = string([]);
for file = dir(file_pattern)' % choose all files that match pattern
    files(end+1) = [file.folder '\' file.name];
end

versions = ["R2018b"... % Versions to convert to
            "R2017b"...
            "R2015b"];

for file = files % for each found file
    [file_path, name, ext] = fileparts(file);
    disp(file_path);
    open(file); % open it
    for v = versions
        new_path = convertStringsToChars(join([file_path '\old\' v '\'], '')); % path to where file will be stored
        if ~exist(new_path, 'dir')
            mkdir(new_path)
        end
        tmp_name = convertStringsToChars(join([new_path name '_old'], '')); % temporary name of converted file
        Simulink.exportToVersion(name, tmp_name, v)
        movefile([tmp_name '.slx'], [tmp_name(1:end-4) '.slx']); % get rid of '_old' suffix
    end
    close_system % close file
end

