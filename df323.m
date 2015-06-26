clear;

a = 2.78;		
b = 3.73;
c = 2.06;
d = 2.5;

% Период малых колебаний
syms dx dy;
syms x y;

dx = x*(a - b*y);                       % Система
dy = y*(-c + d*x);

S = solve(dx == 0, dy == 0, x, y);      % Находим стац. точки
S = double([S.x S.y]);                  % Их 2,нам нужна ненулевая

J = [diff(dx,x) diff(dx,y);             % Матрица Якоби
    diff(dy,x) diff(dy,y)];

J = subs(J, [x, y], [S(2,1), S(2,2)]);  % Матрица системы, линеаризованой в окр. стац. точки

T = double(2*pi/sqrt(-J(2,1)*J(1,2)));  % Период

% Ищем зависимость периода от максимальной численности Х
clear x y;

X = 0:0.1:18;
Y = X;
[X, Y] = meshgrid(X,Y);
I = d.*X + b.*Y - log(X.^c .* Y.^a);

t = 0:0.001:10;
k = S(2,2):0.05:15-0.3;
maxX = zeros(1,length(k));
period = maxX;
b = 0.05;

[c,h]=contourf (X, Y, I); clabel(c,h); hold on;

plot([S(2,1) - 0.25, S(2,1) + 0.25], [S(2,2) - 0.25, S(2,2) + 0.25], 'r'); 
plot([S(2,1) - 0.25, S(2,1) + 0.25], [S(2,2) + 0.25, S(2,2) - 0.25], 'r');
plot([S(2,1), S(2,1)], [S(2,2), 15-0.3], 'r','LineWidth' ,2);
title('Изолинии первого интеграла');
xlabel('Жертвы');
ylabel('Хищники');

figure;

for i = 1:length(k)
    [t,y] = ode45(@(t,y) df323_LV(t,y), t, [S(2,1), k(1,i)]);
    maxX(1,i) = max(y(:,1));
    for p = 2:length(y(:,1))
        if y(p,1) - y(p-1,1) < 0 && abs(y(p,1) - y(1,1)) <= b && p > 1000
            period(1,i) = t(p);
            break
        end
    end
    
end

plot(maxX, period); hold on;
plot([1.3 - 0.25, 1.3 + 0.25], [T - 0.25, T + 0.25], 'r'); 
plot([1.3 - 0.25, 1.3 + 0.25], [T + 0.25, T - 0.25], 'r');
title('Зависимость макс. кол-ва жертв от периода');
xlabel('Максимальное кол-во жертв');
ylabel('Период');
figure;

% Период вдвое больше T
t = 0:0.001:13;
[t,y] = ode45(@(t,y) df323_LV(t,y), t, [S(2,1), k(1,101)]);
plot(t,y(:,1)); hold on;
plot(t,y(:,2),'r');
title('Численности при T = 2*2.6256');
xlabel('Время');
ylabel('Численность');
legend('Жертвы','Хищники');
