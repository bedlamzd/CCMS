%{
Лабораторная #1 по КУМС.
Борисов М.

Главная исполняющая функция.
Генерирует все неоходимые для отчета графики (31 файл).

Для выполнения необходимы файлы с данными оптимумов (имена указаны в
optimums) и файл симулинк с моделью (имя указано в ModelName).
%}

clear
clc
close all

img_path = '.\..\img\'; % путь куда сохранять картинки

if ~exist(img_path, 'dir')
    mkdir(img_path)
end

%% Файлы с данными
optimums = ["linear_opt", "technical", "symmetrical", "binomial", "astatism"];
ModelName = 'sim_model';

%% Формирование входных сигналов
t_end = 10;
t_sample = 0.001;
numb_samples = t_end/t_sample + 1;
in_time = t_sample*(0:numb_samples)'; % вектор времени входного сигнала

% Константы сигналов
A = 7.0; % постоянное воздействие
v = 5.0; % линейное воздействие
a = 10.0; % квадратичное воздействие

const = timeseries(A * (in_time>=0), in_time, 'Name', 'const');
const.UserData = 'Постоянное';
lin = timeseries(v * in_time, in_time, 'Name', 'lin');
lin.UserData = 'Линейное';
quad = timeseries(a / 2 * in_time.^2, in_time, 'Name', 'quad');
quad.UserData = 'Квадратичное';

signals = [const, lin, quad];

%% Заготовка для сводного графика ошибок
errfig = figure(1);
sgtitle('Сигнал ошибки')

i = 1; % номер ячейки графика

% Положение на экране и размер графика
x = 100;
y = -150;
w = 1000;
h = 800;

set(errfig, 'Position', [x,y,w,h])

%% Получение графиков
for optimum = optimums % перебор оптимумов
    run(optimum)
    % Сформировать передаточные функции
    tf_raz = tf(A_raz, B_raz); % передаточная разомкнутой системы
    tf_et = tf(A_et, B_et); % передаточная замкнутой системы
    
    % Получение времени переходного процесса и перерегулирования
    stinfo = stepinfo(tf_et, 1, 'SettlingTimeThreshold', 0.05);
    
    % График переходного процесса
    step_response = figure;
    h = stepplot(tf_et);
    xmax = max(xlim);
    ymax = max(ylim);
    setoptions(h, 'SettleTimeThreshold', 0.05)
    h.showCharacteristic('SettlingTime')
    h.showCharacteristic('PeakResponse')
    if stinfo.Overshoot > 1e-6 % если есть перерегулирование - отметить
        text(xmax, 1, '1')
        set(gca, 'YTick', sort([0 stinfo.Peak ymax]))
        set(gca, 'XTick', sort([0 stinfo.PeakTime stinfo.SettlingTime max(xlim)]))
    else
        set(gca, 'XTick', [0 stinfo.SettlingTime max(xlim)])
    end
    title({'Переходная функция', opt_name})
    
    print(step_response, img_path + optimum + '-step_response', '-dpng', '-r300')
    
    disp(opt_name)
    fprintf('Время переходного процесса t_пп = %4.3f = %4.2fTu\n',...
        stinfo.SettlingTime, stinfo.SettlingTime/Tu)
    fprintf('Перерегулирование delta h = %4.2f%% \n\n', stinfo.Overshoot)
    
    % Отобразить диаграмму Боде разомкнутой системы
    bode_plot_raz = figure;
    bodeplot(tf_raz);
    grid on
    title({"Диаграмма Боде разомкнутой системы", opt_name})
    
    print(bode_plot_raz, img_path + optimum + '-bode-raz', '-dpng', '-r300')
    
    % Отобразить диаграмму Боде замкнутой системы
    bode_plot_zam = figure;
    bodeplot(tf_et);
    grid on
    title({"Диаграмма Боде замкнутой системы", opt_name})
    
    print(bode_plot_zam, img_path + optimum + '-bode-zam', '-dpng', '-r300')
    
    for signal=signals % Перебор входных сигналов
        out = sim(ModelName); % Проводим симуляцию
        time = out.output.time; % Получаем данные симуляции
        error = out.output.signals.values(:,1);
        model = out.output.signals.values(:,2);
        etalon = out.output.signals.values(:,3);
        
        fig = figure; % Рисуем графики
        grid on
        hold on
        title({"Реакция системы на " + lower(signal.UserData) + " воздействие", opt_name})
        plot(in_time, signal.Data, 'k', 'LineWidth', 0.25);
        plot(time, model, 'k:')
        plot(time, etalon, 'k--')
        legend('Сигнал', 'Расчёт', 'Эталон')
        xlim([0, 3*tpp]);
        xlabel('t, c')
        
        errfig = figure(1);
        subplot(5,3,i)
        plot(time, error, 'k')
        grid on
        grid minor
        if i<=3
            title(signal.UserData)
        end
        if mod(i-1, 3) == 0
            ylabel(opt_name)
        end
        xlim([0 3*tpp])
        i = i + 1;

        print(fig, img_path + optimum + '-' + signal.Name, '-dpng', '-r300')
    end
end

print(errfig, img_path + "Compare-errors", '-dpng', '-r300')
print(['-s', ModelName], '-dpng', [img_path, ModelName,'.png'], '-r300')
