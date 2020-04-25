%{
    ������������ �4
    ������ � ������������� ������ � �������� ��-�����������

    ������� �.
    R3425
%}

clear
clc
close all

img_path = '.\..\img\'; % ���� ���� ��������� ��������
data_file = '.\..\data.txt';

if ~exist(img_path, 'dir')
    mkdir(img_path)
end

%% 1. �� ��������� ��� ������������
T0 = 0.1;
st = 0;
t_final = 10;

K1 = 1 + 0.1*(2*rand()-1);
K2 = 1 + 0.1*(2*rand()-1);
T1 = 1 + 0.1*(2*rand()-1);
T2 = 0.5 + 0.1*(2*rand()-1);

f = fopen(data_file, 'w');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n\n', [K1;K2;T1;T2]);
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

fig = figure('name', '1. �� ��������� ��� ������������');
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
grid on
xlim([0 10*Tu]);
legend('������',...
       '�������� �������',...
       '���������� �������',...
       '�������� ������',...
       '���������� ������',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-1'], '-dpng', '-r300')

%% 2. ������ T2 ~~ T0
T0 = 0.1;
st = 0;
t_final = 10;

T2 = 0.1 + 0.05*(2*rand()-1);

f = fopen(data_file, 'a');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n\n', [K1;K2;T1;T2]);
fclose(f);

Kob = K1*K2;
Tzap = T0/2;
Tu = T2 + Tzap;
Kpa = T1/(2*Tu*Kob);
Kia = 1/(2*Tu*Kob);

Kp = Kpa;
Ki = Kia*T0;

model_name = 'OM1';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure('name', '2.1 �� ��������� ������������ �������');
hold on
grid on
xlim([0 10*Tu]);
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
plot(xlim, [0.95 1.05; 0.95 1.05], 'k--');
legend('������',...
       '�������� �������',...
       '���������� �������',...
       '�������� ������',...
       '���������� ������',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-2'], '-dpng', '-r300')

%% 3. ������ T2 >> T0 � �������� ��
T0 = 0.1;
st = 0;
t_final = 10;

T2 = 0.8 + 0.1*(2*rand()-1);

f = fopen(data_file, 'a');
fprintf(f, '%4.3f %4.3f %4.3f %4.3f\n', [K1;K2;T1;T2]);
fprintf('K1 = %4.3f\nK2 = %4.3f\nT1 = %4.3f\nT2 = %4.3f\n\n', [K1;K2;T1;T2]);
fclose(f);

Kob = K1*K2;
Tzap = T0/2;
Tur = T0/2;
Tu = T0;
Kpa = T1/(2*Tu*Kob);
Kia = 1/(2*Tu*Kob);

Kp = Kpa;
Ki = Kia*T0;
Kd = 1/(exp(T0/T2)-1);

model_name = 'OM2';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure('name', '3. ��*� ���������. ����������� ������������');
hold on
grid on
xlim([0 10*Tu]);
plot(out.time, [out.signals.values, out.signals.values(:,1)-out.signals.values(:,3)])
plot(xlim, [0.95 1.05; 0.95 1.05], 'k--');
legend('������',...
       '�������� �������',...
       '���������� �������',...
       '�������� ������',...
       '���������� ������',...
       'Location', 'best')
print(fig, [img_path 'pi_regul-4'], '-dpng', '-r300')










