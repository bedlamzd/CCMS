%{
    Лабораторная №3
    Исследование цифровых САУ с И-регулятором
%}

clear
clc
close all

%% метод прямоугольников
T0 = 0.1;
Kia = 1;
Ki = Kia*T0;

sim rectangle_method

figure
plot(out.time,[out.signals.values]);
grid on
legend('Метод прямоугольников',...
       'Интегратор',...
       'Метод трапеций',...
       'Location', 'best')

%% 2 Метод переоборудования
K1 = 3 + .1*(2*rand()-1);
T1 = .1 + .01*(2*rand()-1);
% вывод регулятора

%% 3 T0 <= 0.1*Tu
t_final = 2;
Tu = T1;
T0 = 0.01;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim i_isled

pltout(out)

%% 4 T0 == T1
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim i_isled

pltout(out)

%% 5 T0=Tu запаздывание
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim i_isled_zap

pltout(out)

%% 5 T0=Tu запаздывание
t_final = 2;
T0 = T1;
Tu = T1+T0/2;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim i_isled_zap

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
