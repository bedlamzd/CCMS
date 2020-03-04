%{
    ������������ �3
    ������������ �������� ��� � �-�����������
%}

clear
clc
close all

%% ����� ���������������
T0 = 0.1;
Kia = 1;
Ki = Kia*T0;

sim rectangle_method

figure
plot(out.time,[out.signals.values]);
grid on
legend('����� ���������������',...
       '����������',...
       '����� ��������',...
       'Location', 'best')

%% 2 ����� ����������������
K1 = 3 + .1*(2*rand()-1);
T1 = .1 + .01*(2*rand()-1);
% ����� ����������

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

%% 5 T0=Tu ������������
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim i_isled_zap

pltout(out)

%% 5 T0=Tu ������������
t_final = 2;
T0 = T1;
Tu = T1+T0/2;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim i_isled_zap

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
