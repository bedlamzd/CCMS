%{
    Лабораторная №4
    Анализ и моделирование систем с цифровым ПД-регулятором
    
    Борисов Максим
    R3425
%}

%% Подготовка
clear % очистить консоль, воркспейс и закрыть окна
clc
close all

img_path = '.\..\img\'; % путь куда сохранять картинки
data_file = '.\..\data.txt'; % файл дано

if ~exist(img_path, 'dir') % если нет папки с картинками то создать
    mkdir(img_path)
end

%% ПД-регулятор
%Дано
T0 = 0.1;

Kda = 0.01;
Kd = Kda/T0;

Kpa = 1;
Kp = Kpa;

Q1 = 10/2^5;
Q2 = 10/2^5;
st = 1;
v = 10;

% запустить модель и сохранить скриншот модели
model_name = 'd_analog';
sim(model_name) 
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

% отрисовать графики
fig = figure; 
plot(out.time, [out.signals.values])
ylim([0 1.5])
xlim([1 1.1])
grid on
legend('Цифровая система', 'Аналоговая система')

% сохранить график в папку
print(fig, [img_path 'pd_regul-1'], '-dpng', '-r300')

%% ПД регулятор компенсация
T1 = 0.1;
Kpa = 1;
Kp = Kpa;
k = T1/T0;
k2 = 1/(exp(T0/T1)-1);
Kda = T1;
Kd = k2;
st = 1;

model_name = 'd_analog_komp';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time, [out.signals.values])
ylim([0 max(out.signals.values(:))])
grid on
legend('цифра', "сигнал", "аналог")

print(fig, [img_path 'pd_regul-2'], '-dpng', '-r300')

%% ПД регулятор эквивалентость
T0 = 0.001;
T1 = 0.1;
Kpa = 1;
Kda = T1;
st = 1;
Tur = T0/2;

Kp = Kpa;
Kd = Kda/T0;

model_name = 'd_analog_eq';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time, [out.signals.values])
ylim([0 max(out.signals.values(:))])
xlim([1 1.005])
grid on
legend('цифра', "сигнал", "аналог")

print(fig, [img_path 'pd_regul-3'], '-dpng', '-r300')

%% ПД регулятор эквивалентность
T0 = 0.001;
T1 = 0.1;
Kpa = 1;
Kda = T1;
st = 1;
Tur = T0/2;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

sim(model_name)

fig = figure;
plot(out.time, [out.signals.values])
ylim([0 max(out.signals.values(:))])
xlim([1 1.005])
grid on
legend('цифра', "сигнал", "аналог")

print(fig, [img_path 'pd_regul-4'], '-dpng', '-r300')

%% Синтез системы с ПД регулятором
K1 = 1 + 0.1*(2*rand()-1);
K2 = 1 + 0.1*(2*rand()-1);
T1 = 1 + 0.1*(2*rand()-1);

% сохранить сгенерированные данные в файл и вывести в консоль
f = fopen(data_file, 'w+');
fprintf(f, '%4.3f %4.3f %4.3f\n', [K1;K2;T1]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\n', [K1;K2;T1]);
fclose(f);

T0 = 0.001;
Tur = T0/2;
Tu = Tur;
Kpa = 1/(2*Tu*K1*K2);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

model_name = 'd_analog_ss';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
hold on
grid on
plot(out.time, [out.signals.values])
plot(xlim, [0.95 0.95], 'k--') % пятипроцентная зона
plot(xlim, [1.05 1.05], 'k--')
ylim([0 max(out.signals.values(:))])
xlim([1 1.01])
legend('цифра', "сигнал", "аналог")

print(fig, [img_path 'pd_regul-5'], '-dpng', '-r300')

%% 
T0 = 0.001;
Tur = T0/2;
Tu = Tur + T0/2;
Kpa = 1/(2*Tu*K1*K2);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

model_name = 'd_analog_ss_zap';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
hold on
grid on
plot(out.time, [out.signals.values])
plot(xlim, [0.95 0.95], 'k--') % пятипроцентная зона
plot(xlim, [1.05 1.05], 'k--')
ylim([0 max(out.signals.values(:))])
xlim([1 1.01])
legend('цифра', "сигнал", "аналог")

print(fig, [img_path 'pd_regul-6'], '-dpng', '-r300')




















