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






