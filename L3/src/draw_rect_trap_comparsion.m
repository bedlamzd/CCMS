clear
clc
close all

img_path = 'img\'; % путь куда сохранять картинки

if ~exist(img_path, 'dir')
    mkdir(img_path)
end

x = 0:0.01:6*pi;
y = sin(x);

tx = x(1:50:end);
ty = sin(tx);
[rx, ry] = stairs(tx,ty);

fig = figure;
xlim([0 3*pi])
hold on
grid on
crv = plot(x,y, 'k');
trap = area(tx,ty, 'FaceColor', 'y', 'FaceAlpha', 1);
rect = area(rx,ry, 'FaceColor', 'b', 'FaceAlpha', 0.7);
legend('sin(x)', 'Метод трапеций','Метод прямоугольников', 'Location', 'best')

print(fig, [img_path, 'rect_trap_comparsion'], '-dpng', '-r300')