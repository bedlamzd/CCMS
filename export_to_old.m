files = ["C:\Users\bedla\Studying\CCMS\L2\src\p_isled.slx"...
         "C:\Users\bedla\Studying\CCMS\L2\src\p_isled_zap.slx"...
         "C:\Users\bedla\Studying\CCMS\L2\src\digital_example.slx"...
         "C:\Users\bedla\Studying\CCMS\L3\src\i_isled.slx"...
         "C:\Users\bedla\Studying\CCMS\L3\src\i_isled_zap.slx"...
         "C:\Users\bedla\Studying\CCMS\L3\src\rectangle_method.slx"];
versions = ["R2018b"...
            "R2017b"];
for file = files
    [filepath,name,ext] = fileparts(file);
    open(file);
    if ~exist(filepath + '\old\', 'dir')
        mkdir(filepath + '\old\')
    end
    for v = versions
        Simulink.exportToVersion(name, filepath + '\old\' + name + '_' + v, v)
    end
    close_system
end

