%%  �������� ��������
opt_name = "��������";

%% ��������� ��������
T1 = 0.1;
T2 = 0.005;
Tu = T2;

%% ������ ������������ �������
A_ou = [1];
B_ou = [T1 1];

A_r = [T1 1];
B_r = [T2 0];

A_raz = conv(A_ou, A_r);
B_raz = conv(B_ou, B_r);

A_et = [1];
B_et = [T2 1];

%% ��������� �������� ��������
tpp = 3 * T2;







