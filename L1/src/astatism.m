%%  �������� ��������
opt_name = "��������";

%% ��������� ��������
T1 =0.1;
T2 = 0.005;
Tu = T2;
Kob = 10;

%% ������ ������������ �������
A_ou = [Kob];
B_ou = conv([T1 1], [T2 1 0]);

A_r = conv(conv([T1 1], [16*Tu 1]), [4*Tu 1]);
B_r = [128*Tu^3*Kob 0 0];

A_raz = conv(A_ou, A_r);
B_raz = conv(B_ou, B_r);

B_r = conv(B_r, [0.00001 1]);

A_et = conv([16*Tu 1], [4*Tu 1]);
B_et = [128*Tu^4 128*Tu^3 64*Tu^2 20*Tu 1];

%% ��������� �������� ��������
tpp = 16.4 * Tu;