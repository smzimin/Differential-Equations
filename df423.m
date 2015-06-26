A = 2; 
B =	1;
C = -3.44;
D = 7.1;
F = 2.52;
w = 2.14;

period = 10*pi/w;

syms x t g v k ak bk ck dk u v u1 u2

u1 = A*sin(w*t);
u2 = B*cos(w*t);


% a = -(pi*k)^2;
% b = 2*(-1)^(k+1) *w*B/(pi*k);
% p = -2*w*A/(pi*k);

a = -D*(pi*k)^2;
b = 2*((-1)^(k+1) *(w*B*(k^2-4)+F*k^2) + F*k^2) / (pi*k*(k^2-4));
p = -2*w*A/(pi*k);


dk = (a*b*sin(w*t) + b*w*cos(w*t)-p*w*sin(w*t)+a*p*cos(w*t))/(a^2 + w^2);
ck = 2*(-1)^k *(B-C)/(pi*k) - (b*w+a*p)/(a^2+w^2);
bk = ck*exp(a*t) - dk;


a2 = -D*(pi*2)^2;
b2 = -2*w*B/(2*pi);
p2 = -2*w*A/(2*pi);


dk2 = (a2*b2*sin(w*t) + b2*w*cos(w*t)-p2*w*sin(w*t)+a2*p2*cos(w*t))/(a2^2 + w^2);
ck2 = 2*(-1)^2 *(B-C)/(pi*2) - (b2*w+a2*p2)/(a2^2+w^2);
bk2 = ck2*exp(a2*t) - dk2;

v =  symsum(bk*sin(pi*k*x), k, 1, 1) + symsum(bk*sin(pi*k*x), k, 3, 500) + bk2*sin(pi*2*x);
u = v + u1 + (u2-u1)*x;


X = 0:0.01:1;
T = 0:0.01:period;

% figure;
% ezplot(subs(u, t, 0), [0 1]);
% title('График u(t,x) в момент t=0, M=500','FontName','Arial Cyr','FontSize',25);
figure;
ezcontourf(u, [0, period, 0, 1]);
title('Изолинии u(t,x), M=500','FontName','Arial Cyr','FontSize',25);



