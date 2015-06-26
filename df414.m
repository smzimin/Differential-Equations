clear;

step = 0.0001;
stik = 0.01;
x1 = 0:0.0001:stik;
x2 = stik+step:0.0001:1.5;
x = horzcat(x1,x2);

n = 3; m = 5;
p = sqrt(n + 1/3);

A = 0;

% figure;
% for a0 = -2:0.5:2
%     a1 = - (a0*p)/(m*(2*p + 1));
%     a2 = - a1/(4*m);
% 
%     u1 = a0*x1.^p + a1*x1.^(p+1) + a2*x1.^(p+2);
%     uStik = a0*(stik+step)^p + a1*(stik+step)^(p+1) + a2*(stik+step)^(p+2);
%     duStik = a0*p*(stik+step)^(p-1) + a1*(p+1)*(stik+step)^p + a2*(p+2)*(stik+step)^(p+1);
% 
%     f = inline('[u(2); (-(tan(x) + x^2/5)*u(2) + (3 + 1/3)*u(1))/(x^2) ]','x','u');
%     [x2,u2] = ode45(f,x2,[uStik duStik]);
%     
%     u = vertcat(u1.',u2(:,1));
%     
%     plot(x,u); hold on;
%     plot(stik+step,uStik,'rX','LineWidth',4);
% 
% end;
% xlabel('X','FontName','Arial Cyr','FontSize',25);
% ylabel('U','FontName','Arial Cyr','FontSize',25);
% title('Графики решений с a0 = -2:0.5:2 в ас-ке у нуля','FontName','Arial Cyr','FontSize',25);


figure;
for a0 = -1.925:0.0005:-1.9

    a1 = - (a0*p)/(m*(2*p + 1));
    a2 = - a1/(4*m);

    u1 = a0*x1.^p + a1*x1.^(p+1) + a2*x1.^(p+2);
    uStik = a0*(stik+step)^p + a1*(stik+step)^(p+1) + a2*(stik+step)^(p+2);
    duStik = a0*p*(stik+step)^(p-1) + a1*(p+1)*(stik+step)^p + a2*(p+2)*(stik+step)^(p+1);

    f = inline('[u(2); (-(tan(x) + x^2/5)*u(2) + (3 + 1/3)*u(1))/(x^2) ]','x','u');
    [x2,u2] = ode45(f,x2,[uStik duStik]);
    
    u = vertcat(u1.',u2(:,1));
    
    x0 = find(x == 1);
    
    if (abs(u(x0,1) + m/n ) < 10^-4)
        A = a0;
        plot(x,u,'r','LineWidth',3); hold on;
        plot(1,-m/n,'g+','LineWidth',6);
        plot(stik+step,uStik,'rX','LineWidth',4);
    else
        plot(x,u); hold on;
        plot(stik+step,uStik,'rX','LineWidth',4);
    end

end;
plot(1,-m/n,'g+','LineWidth',4);
xlabel('X','FontName','Arial Cyr','FontSize',25);
ylabel('U','FontName','Arial Cyr','FontSize',25);
title('Графики решений с a0 = -1.95:0.001:-1.9 в ас-ке у нуля','FontName','Arial Cyr','FontSize',25);
 
%A = -1.914;
a0 = A; 
a1 = - (a0*p)/(m*(2*p + 1));
a2 = - a1/(4*m);

u11 = a0*x1.^p + a1*x1.^(p+1) + a2*x1.^(p+2);
uStik1 = a0*(stik+step)^p + a1*(stik+step)^(p+1) + a2*(stik+step)^(p+2);
duStik1 = a0*p*(stik+step)^(p-1) + a1*p*(stik+step)^p + a2*p*(stik+step)^(p+1);
f = inline('[u(2); (-(tan(x) + x^2/5)*u(2) + (3 + 1/3)*u(1))/(x^2) ]','x','u');
[x3,u12] = ode45(f,x2,[uStik1 duStik1]);
u1 = vertcat(u11.',u12(:,1));

u21 = a0*x1.^p + a1*x1.^(p+1);
uStik2 = a0*(stik+step)^p + a1*(stik+step)^(p+1);
duStik2 = a0*p*(stik+step)^(p-1) + a1*p*(stik+step)^p;
f = inline('[u(2); (-(tan(x) + x^2/5)*u(2) + (3 + 1/3)*u(1))/(x^2) ]','x','u');
[x3,u22] = ode45(f,x2,[uStik2 duStik2]);
u2 = vertcat(u21.',u22(:,1));

figure;
plot(x,u2); hold on;
plot(x,u1,'r');
xlabel('X','FontName','Arial Cyr','FontSize',25);
ylabel('U','FontName','Arial Cyr','FontSize',25);
title('Графики решений с одним и двумя слагаемыми в ас-ке у нуля','FontName','Arial Cyr','FontSize',25);
legend('Одно слагаемое','Два слагаемых');

figure;
nev = abs(u1 - u2);
plot(x,nev); hold on;
xlabel('X','FontName','Arial Cyr','FontSize',25);
ylabel('|U1 - U2|','FontName','Arial Cyr','FontSize',25);
title('Невязка решений с одним и двумя слагаемыми в ас-ке у нуля','FontName','Arial Cyr','FontSize',25);




 
 
 
 
 