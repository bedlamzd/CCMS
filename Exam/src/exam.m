clear
clc
close all

img_path = './../img/';

T0 = 0.01;
T1 = 2*T0;
Tu = T0/2;

Kpa = 1/(3*Tu);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

tpp_r = 6.6*Tu;
disp(tpp_r);

model_name = 'Exam';

out = sim(model_name);

t = out.exam.time;
analog = out.exam.signals.values(:,3);

tpp = t(find(abs(analog - 1) >= 0.05, 1, 'last'));
peak = max(analog);
peak_time = t(analog==peak);
h = (peak-1)*100;
if h <= 0 
    h = 0;
end

fig = figure('name', 'PD');
hold on
xlim([.99 1+4*tpp_r]);
grid on
plot(t, [out.exam.signals.values]);
plot(xlim, [1.05 1.05], 'k:'); 
plot(xlim, [0.95 0.95], 'k:');
plot([tpp tpp], [0 0.95], 'k--'); 
plot(tpp, 0.95, 'ko');
xmax = max(xlim);
ymax = max(ylim);
if h ~= 0 % если есть перерегулирование - отметить
    text(xmax, 1, '1')
    plot([peak_time peak_time], [0 peak], 'k--');
    plot([0 peak_time], [peak peak], 'k--');
    plot(peak_time, peak, 'ko');
    set(gca, 'YTick', sort([0 peak ymax]))
    set(gca, 'XTick', sort([0 peak_time tpp max(xlim)]))
else
    set(gca, 'XTick', [0 tpp max(xlim)])
end
xtickformat('%4.3g');
ytickformat('%4.3g');
xlabel('t, с');
legend('Задание', 'Цифровой сигнал', 'Аналоговый сигнал' ,'Location', 'best');

print(['-s', model_name], '-dpng', [img_path, model_name,'.png'], '-r300');

T0 = 0.01;
T1 = 2*T0;
Tur = T0/2;
Tu = Tur + T0/2;

Kpa = 1/(3*Tu);
Kda = T1;

Kp = Kpa;
Kd = 1/(exp(T0/Kda)-1);

tpp_r = 6.6*Tu;
disp(tpp_r);

model_name = 'Exam2';

out = sim(model_name);

t = out.exam.time;
analog = out.exam.signals.values(:,3);

tpp = t(find(abs(analog - 1) >= 0.05, 1, 'last'));
peak = max(analog);
peak_time = t(analog==peak);
h = (peak-1)*100;
if h <= 0 
    h = 0;
end

fig2 = figure('name', 'PD');
hold on
xlim([.99 1+4*tpp_r]);
grid on
plot(t, [out.exam.signals.values]);
plot(xlim, [1.05 1.05], 'k:'); 
plot(xlim, [0.95 0.95], 'k:');
plot([tpp tpp], [0 0.95], 'k--'); 
plot(tpp, 0.95, 'ko');
xmax = max(xlim);
ymax = max(ylim);
if h ~= 0 % если есть перерегулирование - отметить
    text(xmax, 1, '1')
    plot([peak_time peak_time], [0 peak], 'k--');
    plot([0 peak_time], [peak peak], 'k--');
    plot(peak_time, peak, 'ko');
    set(gca, 'YTick', sort([0 peak ymax]))
    set(gca, 'XTick', sort([0 peak_time tpp max(xlim)]))
else
    set(gca, 'XTick', [0 tpp max(xlim)])
end
xtickformat('%4.3g');
ytickformat('%4.3g');
xlabel('t, с');
legend('Задание', 'Цифровой сигнал', 'Аналоговый сигнал' ,'Location', 'best');

print(fig, [img_path 'graph'], '-dpng','-r300');
print(fig2, [img_path 'graph2'], '-dpng','-r300');
print(['-s', model_name], '-dpng', [img_path, model_name,'.png'], '-r300');

