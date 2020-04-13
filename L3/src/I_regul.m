%{
    ������������ �3
    ������������ �������� ��� � �-�����������
%}

clear
clc
close all

img_path = '.\..\img\'; % ���� ���� ��������� ��������
data_file = '.\..\data.txt';

if ~exist(img_path, 'dir')
    mkdir(img_path)
end

%% ����� ��������������� � ��������
T0 = 0.1;
Kia = 1;
Ki = Kia*T0;

model_name = 'rectangle_trapez';
sim(model_name)
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = figure;
plot(out.time,[out.signals.values]);
grid on
legend('����� ���������������',...
       '����������',...
       '����� ��������',...
       'Location', 'best')
print(fig, [img_path 'i_regul-1'], '-dpng', '-r300')

%% 2 ����� ����������������
K1 = 3 + .1*(2*rand()-1);
T1 = .1 + .01*(2*rand()-1);

f = fopen(data_file, 'w+');
fprintf(f, '%4.3f %4.3f\n', [K1;T1]);
fprintf('K1 = %4.3f\nT1 = %4.3f\n', [K1;T1]);
fclose(f);

%% 3 T0 <= 0.1*Tu
t_final = 2;
Tu = T1;
T0 = 0.01;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

model_name = 'i_isled';
sim(model_name);
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = pltout(out);
print(fig, [img_path 'i_regul-2'], '-dpng', '-r300')

%% 4 T0 == T1
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim(model_name);

fig = pltout(out);
print(fig, [img_path 'i_regul-3'], '-dpng', '-r300')

%% 5 T0=Tu ������������
t_final = 2;
Tu = T1;
T0 = T1;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

model_name = 'i_isled_zap';
sim(model_name);
print(['-s', model_name], [img_path 'model-' model_name '.png'], '-dpng', '-r300')

fig = pltout(out);
print(fig, [img_path 'i_regul-4'], '-dpng', '-r300')

%% 6 T0=Tu ����������� ������������
t_final = 2;
T0 = T1;
Tu = T1+T0/2;
Kia = 1/(2*Tu*K1);
Ki = Kia*T0;

sim(model_name);

fig = pltout(out);
print(fig, [img_path 'i_regul-5'], '-dpng', '-r300')


%% �������
function h = pltout(output)
    h = figure;
    plot(output.time,[output.signals.values, output.signals.values(:,1) - output.signals.values(:,3)]);
    grid on
    legend('������� ������',...
           '�������� ������',...
           '���������� ������',...
           '������ ��������',...
           '������ ����������',...
           'Location', 'best')
    
end
