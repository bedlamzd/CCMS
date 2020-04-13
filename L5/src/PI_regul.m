%{
    Лабораторная №4
    Анализ и моделирование систем с цифровым ПД-регулятором

    Борисов М.
    R3425
%}

clear
clc
close all

img_path = '.\..\img\'; % путь куда сохранять картинки
data_file = '.\..\data.txt';

if ~exist(img_path, 'dir')
    mkdir(img_path)
end

%% 1.1 ЭМ преобразователь первого приближения
T0 = 0.1;
st = 0;
t_final = 10;

K1 = 1 + 0.1*(2*rand()-1);
K2 = 1 + 0.1*(2*rand()-1);
T1 = 1 + 0.1*(2*rand()-1);
T2 = 0.5 + 0.1*(2*rand()-1);

f = fopen(data_file, 'w');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n', [K1;K2;T1;T2]);
fclose(f);

Kob = K1*K2;
Tu = T2;
Kpa = T1/(2*Tu*Kob);
Kia = 1/(2*Tu*Kob);

Kp = Kpa;
Ki = Kia*T0;

model_name = 'pi_isled';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
grid on
legend('Сигнал',...
       'Цифровая система',...
       'Аналоговая система',...
       'Цифровая ошибка',...
       'Аналоговая ошибка',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-1'], '-dpng', '-r300')

%% 1.2
T0 = 0.1;
st = 0;
t_final = 10;

% K1 = 1 + 0.1*(2*rand()-1);
% K2 = 1 + 0.1*(2*rand()-1);
% T1 = 1 + 0.1*(2*rand()-1);
T2 = 0.2 + 0.1*(2*rand()-1);

f = fopen(data_file, 'a');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n', [K1;K2;T1;T2]);
fclose(f);

Tzap = T0/2;
Tu = T2 + Tzap;
Kpa = T1/(2*Tu*Kob);
Kia = 1/(2*Tu*Kob);

Kp = Kpa;
Ki = Kia*T0;

model_name = 'OM1';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
grid on
legend('Сигнал',...
       'Цифровая система',...
       'Аналоговая система',...
       'Цифровая ошибка',...
       'Аналоговая ошибка',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-2'], '-dpng', '-r300')

%% 1.3
T0 = 0.1;
st = 0;
t_final = 10;

% K1 = 1 + 0.1*(2*rand()-1);
% K2 = 1 + 0.1*(2*rand()-1);
% T1 = 1 + 0.1*(2*rand()-1);
T2 = 0.8 + 0.1*(2*rand()-1);

f = fopen(data_file, 'a');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n', [K1;K2;T1;T2]);
fclose(f);

Tzap = T0/2;
Tu = T2 + Tzap;
Kpa = T1/(2*Tu*Kob);
Kia = 1/(2*Tu*Kob);

Kp = Kpa;
Ki = Kia*T0;

model_name = 'OM1';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
grid on
legend('Сигнал',...
       'Цифровая система',...
       'Аналоговая система',...
       'Цифровая ошибка',...
       'Аналоговая ошибка',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-3'], '-dpng', '-r300')

%% 1.4
T0 = 0.1;
st = 0;
t_final = 10;

% K1 = 1 + 0.1*(2*rand()-1);
% K2 = 1 + 0.1*(2*rand()-1);
% T1 = 1 + 0.1*(2*rand()-1);
T2 = 0.2 + 0.1*(2*rand()-1);

f = fopen(data_file, 'a');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n', [K1;K2;T1;T2]);
fclose(f);

Tzap = T0/2;
Tur = T0/2;
Tu = T2 + Tzap;
Kpa = T1/(2*Tu*Kob);
Kia = 1/(2*Tu*Kob);

Kp = Kpa;
Ki = Kia*T0;
Kd = 1/(exp(T0/T2)-1);

model_name = 'OM2';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
grid on
legend('Сигнал',...
       'Цифровая система',...
       'Аналоговая система',...
       'Цифровая ошибка',...
       'Аналоговая ошибка',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-4'], '-dpng', '-r300')










