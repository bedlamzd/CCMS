%{
 Лабораторная #2
 Анализ и моделирование систем с цифровым П-регулятором
%}

clear
clc
close all

img_path = 'img\'; % путь куда сохранять картинки
data_file = 'data.txt';

if ~exist(img_path, 'dir')
    mkdir(img_path)
end

%% 1.1 Исследование цифрового регулятора
Kpa = 0.5;
Kp = 1;
T0 = 0.1;
Q1 = 10/(2^12);
Q2 = 10/(2^12);

model_name = 'digital_example';
sim(model_name)
print(['-s', model_name], [img_path model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time,[out.signals.values])
grid on
legend('Цифровой', 'Аналоговый', 'Location', 'best')
print(fig, [img_path 'p_regul-1'], '-dpng', '-r300')

%% 1.2 Применение метода "Переоборудования"
% Настройка на ТО
K1 = 1 + .1*(2*rand()-1); 
K2 = 2 + .1*(2*rand()-1);
T1 = 1 + .1*(2*rand()-1);
f = fopen(data_file, 'w+');
fprintf(f, '%4.3f %4.3f %4.3f\n', [K1;K2;T1]);
fprintf('K1 = %4.3f\nK2 = %4.3f\ngit T1 = %4.3f\n', [K1;K2;T1]);
fclose(f);

%% 2. случай T0 <= 0.1Tu
t_final = 20;
Tu = T1;
T0 = 0.1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

model_name = 'p_isled';
sim(model_name)
print(['-s', model_name], '-dpng', [img_path, model_name,'.png'], '-r300')

fig = pltout(out);
print(fig, [img_path 'p_regul-2'], '-dpng', '-r300')

%% 3. случай T1 == Tu
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim(model_name)

fig = pltout(out);
print(fig, [img_path 'p_regul-3'], '-dpng', '-r300')

%% 4. западывание аналогого сигнала
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

model_name = 'p_isled_zap';
sim(model_name)
print(['-s', model_name], '-dpng', [img_path, model_name,'.png'], '-r300')

fig = pltout(out);
print(fig, [img_path 'p_regul-4'], '-dpng', '-r300')

%% 5. запаздывание как апериодическое звено
t_final =20;
T0 = 1;
T1 = T0;
Tu = T1 + 0.5*T0;
Kpa = 1/(2*Tu*K1*K2);
Kp = 1/(2*Tu*K1*K2);

sim(model_name)

fig = pltout(out);
print(fig, [img_path 'p_regul-5'], '-dpng', '-r300')

%% Функции
function h = pltout(output)
    h = figure;
    plot(output.time,[output.signals.values, output.signals.values(:,1) - output.signals.values(:,3)]);
    grid on
    legend('Входной сигнал',...
           'Цифровой сигнал',...
           'Аналоговый сигнал',...
           'Ошибка цифровая',...
           'Ошибка аналоговая',...
           'Location', 'best')
    
end




