clear
clc
close all

files = [".\L1\src\sim_model.slx"...
         ".\L2\src\p_isled.slx"...
         ".\L2\src\p_isled_zap.slx"...
         ".\L2\src\digital_example.slx"...
         ".\L3\src\i_isled.slx"...
         ".\L3\src\i_isled_zap.slx"...
         ".\L3\src\rectangle_trapez.slx"];
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

