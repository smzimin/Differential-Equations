clear;

syms dx dy dz;
syms x y z;
syms s q w f positive;

assume(x >= 0);
assume(y >= 0);
assume(z >= 0);

dx = s*(y - x*y + x - q*x^2);
dy = s^(-1)*(-y - x*y + f*z);
dz = w*(x - z);

% Правая часть внутрь октанта
O = [subs(dx, x , 0); subs(dy, y , 0); subs(dz, z , 0)];

% Стац. точки и матрица Якоби
S = solve(dx == 0, dy == 0, dz == 0, x, y, z);
S = [S.x S.y S.z];

J = [diff(dx,x) diff(dx,y) diff(dx,z);
    diff(dy,x) diff(dy,y) diff(dy,z);
    diff(dz,x) diff(dz,y) diff(dz,z)];

% Устойчивость точки 0
J0 = subs(J, [x, y, z], [0, 0, 0]);

temp0 = simplify(charpoly(J0));

gurvic0 = [temp0(2) temp0(1) 0;
           temp0(4) temp0(3) temp0(2); 
           0 0 temp0(4)];
       
q10 = simplify(temp0(2)*temp0(3) - temp0(1)*temp0(4));
q20 = det(gurvic0);

%P0 = solve(temp0(2) > 0, q10 > 0, q20 > 0, s, w, f);

% Устойчивость точки A
H = double(subs(S,[s, q, w, f],[1,1,1,1])); % поняли, что нам нужна точка 3

JA = subs(J, [x, y, z], [S(3,1), S(3,2), S(3,3)]);  % Линеаризуем в точке А
JA = subs(JA, f, 1.25);                             % Подставляем f из таблицы

tempA = simplify(charpoly(JA));                     % Коэф-ы харак-го полинома

gurvicA = [tempA(2) tempA(1) 0;                     % Матрица Гурвица
           tempA(4) tempA(3) tempA(2); 
           0 0 tempA(4)];
       
q1A = simplify(tempA(2)*tempA(3) - tempA(1)*tempA(4));  % Второй минор
q2A = det(gurvicA);                                     % и определитель
%P = solve(tempA(2) > 0, q1 > 0, q2 > 0, s, q, w );

G = 9;
Q = 1.00000000000000e-05;
W = 1.11574230944075; % W  = 4; % больше -- устойчивость

DA = eig(JA);
DA = subs(DA, [s, q, w], [G, Q, W]);

% Интегрирование
t = 0:0.1:400;
G = 47.80;
Q = 8.14E-05;
W = 0.42;
F = 1.25;

% G = 9;
% Q = 1.00000000000000e-05;
% W = 2;


% wneyd = (9*q.^3*s^4 + (3*q.^2*s^4)/4 + 7*q*s^2 - 4*q + 1)/(q.*s*(12*q*s^2 + 8)) - (18*q + 73*q.^2*s^2 + (5*q.^2*s^4)/16 + (87*q.^3*s^4)/2 + 9*q^4*s^4 + (7*q*s^2)/4 + 4*q.^2 - ((12*q.^2*s^2 + q*s^2 - 8.*q + 2).*(9*q.^3*s^4 + (3*q.^2*s^4)/4 + 7*q*s^2 - 4*q + 1))./(12.*q*s^2 + 8) + 1/4)./(q.*s*(8*q - 12*q.^2*s^2 + 8*(q.^2 + (19*q)/2 + 1/16).^(1/2) - q*s^2 + 12*q.*s^2*(q.^2 + (19*q)/2 + 1/16).^(1/2) - 2))
% s = 9
% q = 0:0.00001:0.002

y0 = double ( subs( [S(3,1), S(3,2), S(3,3)], [s, q, w, f], [G, Q, W, F]));

clear dx dy dz x y z s q w f;
Krum = 0.1;
[t, y] = ode23s(@(t, y) df324_react(t, y), t, y0 + Krum);

comet3(y(:,1), y(:,2), y(:,3)); hold on;
plot3(y(:,1), y(:,2), y(:,3)); hold on; grid on;
xlabel('x -- a'); ylabel('y -- этта'); zlabel('z -- p');
%figure;  plot(t,y(:,1) ); figure; plot(t,y(:,2) ); figure;  plot(t,y(:,3) );


j = 100; norm = [y(j,1) - y(j-1,1); y(j,2) - y(j-1,2);y(j,3) - y(j-1,3) ];
[X,Y] = meshgrid(-200:10:200, -10:1:10);

Z = y(j,3) - (norm(1)*(X - y(j,1)) +  norm(2)*(Y - y(j,2)))/norm(3);

mesh(X,Y,Z);

temp = 0;
counter = 1;
b = 0.0035;
for p = 210:length(y(:,2))
        if y(p,2) - y(p-1,2) < 0 && abs(y(p,2) - y(101,2)) <= b
            temp(1,counter) = p;
            temp(2,counter) = t(p);
            counter = counter + 1;
        end
end

T = t(temp(1,3)) - t(temp(1,2));

A = [y(1,1) y(temp(1,1) - 210,1) y(temp(1,3) - 210,1);
    y(1,2) y(temp(1,1) - 210,2) y(temp(1,3) - 210,2);
    y(1,3) y(temp(1,1) - 210,3) y(temp(1,3) - 210,3)];

B = [y(temp(1,1) - 210,1) y(temp(1,3) - 210,1) y(temp(1,4) - 210,1);
    y(temp(1,1) - 210,2) y(temp(1,3) - 210,2) y(temp(1,4) - 210,2);
    y(temp(1,1) - 210,3) y(temp(1,3) - 210,3) y(temp(1,4) - 210,3)];

MONODROMIA = B * A^(-1);
d = eig(MONODROMIA);