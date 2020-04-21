%{
    ������������ �4
    ������ � ������������� ������ � �������� ��-�����������
    
    ������� ������
    R3425
%}

%% ����������
clear % �������� �������, ��������� � ������� ����
clc
close all

img_path = '.\..\img\'; % ���� ���� ��������� ��������
data_file = '.\..\data.txt'; % ���� ����

if ~exist(img_path, 'dir') % ���� ��� ����� � ���������� �� �������
    mkdir(img_path)
end

%% 1. ������������ �������� ������ ��-����������
%����
T0 = 0.1;

Kda = 0.01;
Kd = Kda/T0;

Kpa = 1;
Kp = Kpa;

Q1 = 10/2^5;
Q2 = 10/2^5;
st = 1;
v = 10;

% ��������� ������ � ��������� �������� ������
model_name = 'd_analog';
sim(model_name) 
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

% ���������� �������
fig = figure('Name', '1. ������������ �������� ������ ��-����������'); 
plot(out.time, [out.signals.values])
ylim([0 1.5])
xlim([.98 1.1])
grid on
legend('�������� ���������', '���������� ���������', "Location", "best")

% ��������� ������ � �����
print(fig, [img_path 'pd_regul-1'], '-dpng', '-r300')

%% 2. ����������� ���������� ������� ��������������� �����
T1 = 0.1;
Kpa = 1;
Kp = Kpa;
Kda = T1;
Kd = Kda;
st = 1;

model_name = 'd_analog_komp';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure('Name', '2. ����������� ���������� ������� ��');
plot(out.time, [out.signals.values])
xlim([0 3])
% ylim([0 max(out.signals.values(:))])
grid on
legend('�������� �������', "�������", "���������� �������", "Location", "best")

print(fig, [img_path 'pd_regul-2'], '-dpng', '-r300')

%% 3. �� ��������� ��������������. ��������� ������ �������� ������� Kd.
%% 3.1 ������������ ������ ����� Kd.
T0 = 0.1;
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

fig = figure('Name', '3.1 ������������ ������ ����� Kd');
plot(out.time, [out.signals.values])
ylim([0 max(out.signals.values(:))])
xlim([0 2])
grid on
legend('�������� �������', "�������", "���������� �������", "Location", "best")

print(fig, [img_path 'pd_regul-3'], '-dpng', '-r300')

%% 3.2 ���������� ���� Kd.
T0 = 0.1;
T1 = 0.1;
Kpa = 1;
Kda = T1;
st = 1;
Tur = T0/2;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

sim(model_name)

fig = figure('Name', '3.2 ���������� ������ ����� Kd');
plot(out.time, [out.signals.values])
ylim([0 max(out.signals.values(:))])
xlim([0 2])
grid on
legend('�������� �������', "�������", "���������� �������", "Location", "best")

print(fig, [img_path 'pd_regul-4'], '-dpng', '-r300')

%% 4. ������ ������� � �� �����������
K1 = 1 + 0.1*(2*rand()-1);
K2 = 1 + 0.1*(2*rand()-1);
T1 = 1 + 0.1*(2*rand()-1);

% ��������� ��������������� ������ � ���� � ������� � �������
f = fopen(data_file, 'w+');
fprintf(f, '%4.3f %4.3f %4.3f\n', [K1;K2;T1]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\n', [K1;K2;T1]);
fclose(f);

%% 4.1 ��� ������������ � ����������� ������������
T0 = 0.1;
Tur = T0/2;
Tu = Tur;
Kpa = 1/(2*Tu*K1*K2);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

model_name = 'd_analog_ss';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure('Name', '4.1 ������ ��� ������������');
hold on
grid on
plot(out.time, [out.signals.values])
plot(xlim, [0.95 0.95], 'k--') % �������������� ����
plot(xlim, [1.05 1.05], 'k--')
ylim([0 max(out.signals.values(:))])
xlim([.5 2.5])
legend('�������� �������', "�������", "���������� �������", "Location", "best")

print(fig, [img_path 'pd_regul-5'], '-dpng', '-r300')

%% 4.2 � ������������� � ��� ������������
T0 = 0.1;
Tur = T0/2;
Tu = Tur + T0/2;
Kpa = 1/(2*Tu*K1*K2);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

model_name = 'd_analog_ss_zap';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure('Name', '4.2 ������ � �������������');
hold on
grid on
plot(out.time, [out.signals.values])
plot(xlim, [0.95 0.95], 'k--') % �������������� ����
plot(xlim, [1.05 1.05], 'k--')
ylim([0 max(out.signals.values(:))])
xlim([0.5 2.5])
legend('�������� �������', "�������", "���������� �������", "Location", "best")

print(fig, [img_path 'pd_regul-6'], '-dpng', '-r300')




















