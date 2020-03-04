%{
 ������������ #2
 ������ � ������������� ������ � �������� �-�����������
%}

clear
clc
close all

%% 1.1 ������������ ��������� ����������
Kpa = 0.5;
Kp = 1;
T0 = 0.1;
Q1 = 10/(2^12);
Q2 = 10/(2^12);

sim digital_example

figure
plot(out.time,[out.signals.values])
grid on
legend('��������', '����������', 'Location', 'best')

%% 1.2 ���������� ������ "����������������"
% ��������� �� ��
K1 = 1 + .1*(2*rand()-1); 
K2 = 2 + .1*(2*rand()-1);
T1 = 1 + .1*(2*rand()-1);

%% 2. ������ T0 <= 0.1Tu
t_final = 20;
Tu = T1;
T0 = 0.1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim p_isled

pltout(out)

%% 3. ������ T1 == Tu
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim p_isled

pltout(out)

%% 4. ����������� ��������� �������
t_final = 20;
T0 = 1;
T1 = T0;
Tu = T1;
Kpa = 1/(2*Tu*K1*K2);
Kp = Kpa;

sim p_isled_zap

pltout(out)

%% 5. ������������ ��� �������������� �����
t_final =20;
T0 = 1;
T1 = T0;
Tu = T1 + 0.5*T0;
Kpa = 1/(2*Tu*K1*K2);
Kp = 1/(2*Tu*K1*K2);

sim p_isled_zap

pltout(out)

%% �������
function pltout(output)
    figure
    plot(output.time,[output.signals.values, output.signals.values(:,1) - output.signals.values(:,3)]);
    grid on
    legend('������� ������',...
           '�������� ������',...
           '���������� ������',...
           '������ ��������',...
           '������ ����������',...
           'Location', 'best')
end




