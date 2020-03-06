clear
clc
close all

T0 = 0.1;

Kda = 0.01;
Kd = Kda/T0;

Kpa = 1;
Kp = 1;

Q1 = 10/2^5;
Q2 = 10/2^5;
st = 1;
v = 10;
out = sim('d_analog');

out = out.out;
figure
plot(out.time, [out.signals.values])
grid on
ylim([0 5])
xlim([1 1.5])
legend('Цифровая система', 'Аналоговая система')


%% ПД регулятор
Kpa = 0.1;
Kda = 1;
st = 1;
out = sim('d_analog');

out = out.out;

figure
plot(out.time, [out.signals.values])
grid on
ylim([0 5])
xlim([1 1.5])

%% ПД регулятор компенсация
T1 = 0.1;
Kpa = 1;
Kda = T1;
st = 1;
out = sim('d_analog_komp');

out = out.out;

figure
plot(out.time, [out.signals.values])
grid on
ylim([0 max(out.signals.values(:))])
legend('цифра', "сигнал", "аналог")

%% ПД регулятор эквивалентость
T0 = 0.001;
T1 = 0.1;
Kpa = 1;
Kda = T1;
st = 1;
Tur = T0/2;

Kp = Kpa;
Kd = Kda/T0;

out = sim('d_analog_eq');

out = out.out;

figure
plot(out.time, [out.signals.values])
grid on
ylim([0 max(out.signals.values(:))])
xlim([1 1.005])
legend('цифра', "сигнал", "аналог")

%% ПД регулятор эквивалентность
T0 = 0.001;
T1 = 0.1;
Kpa = 1;
Kda = T1;
st = 1;
Tur = T0/2;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

out = sim('d_analog_eq');

out = out.out;

figure
plot(out.time, [out.signals.values])
grid on
ylim([0 max(out.signals.values(:))])
xlim([1 1.005])
legend('цифра', "сигнал", "аналог")

%% Синтез системы с ПД регулятором
K1 = 1 + 0.1*(2*rand()-1);
K2 = 1 + 0.1*(2*rand()-1);
T1 = 1 + 0.1*(2*rand()-1);
T0 = 0.001;
Tur = T0/2;
Tu = Tur;
Kpa = 1/(2*Tu*K1*K2);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

out = sim('d_analog_ss');

out = out.out;

figure
hold on
grid on
plot(out.time, [out.signals.values])
plot(xlim, [0.95 0.95], 'k--')
plot(xlim, [1.05 1.05], 'k--')
ylim([0 max(out.signals.values(:))])
xlim([1 1.01])
legend('цифра', "сигнал", "аналог")

%% 
T0 = 0.001;
Tur = T0/2;
Tu = Tur + T0/2;
Kpa = 1/(2*Tu*K1*K2);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

out = sim('d_analog_ss_zap');

out = out.out;

figure
hold on
grid on
plot(out.time, [out.signals.values])
plot(xlim, [0.95 0.95], 'k--')
plot(xlim, [1.05 1.05], 'k--')
ylim([0 max(out.signals.values(:))])
xlim([1 1.01])
legend('цифра', "сигнал", "аналог")





















