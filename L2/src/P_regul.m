%{
 Лабораторная #2
 Анализ и моделирование систем с цифровым П-регулятором
%}

clear
clc
close all

%% 1.1 Исследование цифрового регулятора
Kpa = 0.5;
Kp = 1;
T0 = 0.1;
Q1 = 10/(2^12);
Q2 = 10/(2^12);

sim digital_example

figure
plot(out.time,[out.signals.values])
grid on
legend('Цифровой', 'Аналоговый', 'Location', 'best')

%% 1.2 Применение метода "Переоборудования"
% Настройка на ТО
K1 = 1 + .1*(2*rand()-1); 
K2 = 2 + .1*(2*rand()-1);
T1 = 1 + .1*(2*rand()-1);

%% 2. случай T0 <= 0.1Tu
t_final = 20;
Tu = T1;
T0 = 0.1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim p_isled

pltout(out)

%% 3. случай T1 == Tu
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim p_isled

pltout(out)

%% 4. западывание аналогого сигнала
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim p_isled_zap

pltout(out)

%% 5. запаздывание как апериодическое звено
t_final =20;
T0 = 1;
T1 = T0;
Tu = T1 + 0.5*T0;
Kpa = 1/(2*Tu*K1*K2);
Kp = 1/(2*Tu*K1*K2);

sim p_isled_zap

pltout(out)

%% Функции
function pltout(output)
    figure
    plot(output.time,[output.signals.values, output.signals.values(:,1) - output.signals.values(:,3)]);
    grid on
    legend('Входной сигнал',...
           'Цифровой сигнал',...
           'Аналоговый сигнал',...
           'Ошибка цифровая',...
           'Ошибка аналоговая',...
           'Location', 'best')
end




