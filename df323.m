clear;

a = 2.78;		
b = 3.73;
c = 2.06;
d = 2.5;

% ������ ����� ���������
syms dx dy;
syms x y;

dx = x*(a - b*y);                       % �������
dy = y*(-c + d*x);

S = solve(dx == 0, dy == 0, x, y);      % ������� ����. �����
S = double([S.x S.y]);                  % �� 2,��� ����� ���������

J = [diff(dx,x) diff(dx,y);             % ������� �����
    diff(dy,x) diff(dy,y)];

J = subs(J, [x, y], [S(2,1), S(2,2)]);  % ������� �������, �������������� � ���. ����. �����

T = double(2*pi/sqrt(-J(2,1)*J(1,2)));  % ������

% ���� ����������� ������� �� ������������ ����������� �
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
title('�������� ������� ���������');
xlabel('������');
ylabel('�������');

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
title('����������� ����. ���-�� ����� �� �������');
xlabel('������������ ���-�� �����');
ylabel('������');
figure;

% ������ ����� ������ T
t = 0:0.001:13;
[t,y] = ode45(@(t,y) df323_LV(t,y), t, [S(2,1), k(1,101)]);
plot(t,y(:,1)); hold on;
plot(t,y(:,2),'r');
title('����������� ��� T = 2*2.6256');
xlabel('�����');
ylabel('�����������');
legend('������','�������');
