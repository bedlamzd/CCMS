%{
Исследование цифровых САУ с И-регулятором
%}

%% метод прямоугольников
T0 = 0.1;
Kia = 1;
Ki = Kia*T0;
sim integrmodel

t = y(:, 1);
sig = y(:,2);
dig = y(:,3);
anlg = y(:,4);
dig_er = y(:,5);

figure

plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')

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

t = y(:, 1);
sig = y(:,2);
dig = y(:,3);
anlg = y(:,4);
dig_er = y(:,5);

figure

plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')

%% 4 T0 == T1
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;
sim i_isled

t = y(:, 1);
sig = y(:,2);
dig = y(:,3);
anlg = y(:,4);
dig_er = y(:,5);

figure

plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')

%% 5 T0=Tu запаздывание
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;
sim i_isled_zap

t = y(:, 1);
sig = y(:,2);
dig = y(:,3);
anlg = y(:,4);
dig_er = y(:,5);

figure

plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')

%% 5 T0=Tu запаздывание
t_final = 2;
T0 = T1;
Tu = T1+T0/2;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;
sim i_isled_zap

t = y(:, 1);
sig = y(:,2);
dig = y(:,3);
anlg = y(:,4);
dig_er = y(:,5);

figure

plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')




