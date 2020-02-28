%{
 Лабораторная #2
 Анализ и моделирование систем с цифровым П-регулятором
%}

%% 1.1 Исследование цифрового регулятора
Kpa = 0.5;
Kp = 1;
T0 = 0.1;
Q1 = 10/(2^12);
Q2 = 10/(2^12);
sim prop
figure
plot(y(:,1),y(:,3))
hold on
grid on
plot(y(:,1),y(:,4))
figure
hold on
grid on
plot(y(:,1),y(:,4)-y(:,3))

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
%% 3. случай T1 == Tu
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;
sim p_isled
t       = y(:,1);
sig     = y(:,2);
dig     = y(:,3);
anlg    = y(:,4);
dig_er  = y(:,5);
figure
plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')
%% 4. западывание аналогого сигнала
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;
sim p_isled_zap
t       = y(:,1);
sig     = y(:,2);
dig     = y(:,3);
anlg    = y(:,4);
dig_er  = y(:,5);
figure
plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')

%% 5. запаздывание как апериодическое звено
t_final =20;
T0 = 1;
T1 = T0;
Tu = T1 + 0.5*T0;
Kpa = 1/(2*Tu*K1*K2);
Kp = 1/(2*Tu*K1*K2);
sim p_isled_zap
t       = y(:,1);
sig     = y(:,2);
dig     = y(:,3);
anlg    = y(:,4);
dig_er  = y(:,5);
figure
plot(t,sig)
hold on
grid on
plot(t,dig)
plot(t,anlg)
plot(t, dig_er)
plot(t, sig-anlg)
legend('сигнал','цифра','аналог','ошибка-цифра','ошибка-аналог')







