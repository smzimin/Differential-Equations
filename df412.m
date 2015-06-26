clear;

a = -2;
b = 0.1;
c = -1.9;
d = 0.2;
L = 7.4;

X = -L:0.1:L;
Y = X;

% syms x y f g dfdx dfdy dgdx dgdy;
% 
% f = cos(a*x + b*y) + 2*sinh(c*x + d*y);
% g = exp(c*y + d*x) - exp(a*y - b*x);
% dfdx = diff(f,x);
% dfdy = diff(f,y);
% dgdx = diff(g,x);
% dgdy = diff(g,y);


[X2,  Y2] = meshgrid(X, Y);
F = cos(a*X2 + b*Y2) + 2*sinh(c*X2 + d*Y2);
G = exp(c*Y2 + d*X2) - exp(a*Y2 - b*X2);
nev = abs(F) + abs(G);
figure;
[cont,h]=contour(X,Y,F,-0.1:0.1:0.1,'g'); clabel(cont,h); hold on;
[cont,h]=contour(X,Y,G,-0.1:0.1:0.1,'r'); clabel(cont,h); hold on;
% 0.177640622396722  -0.532921867190166
plot(0.17764062239672,-0.532921867190166,'kX');
title('Изолинии, отвечающие значениям  f = 0 и g = 0','FontName','Arial Cyr','FontSize',25);
xlabel('X','FontName','Arial Cyr','FontSize',25);
ylabel('Y','FontName','Arial Cyr','FontSize',25);

n = length(X);
x0 = zeros(n,n);
y0 = zeros(n,n);

figure;
for i = 1:n
    for k = 1:n        
        temp = [X(i);   Y(k)];
        for iter = 1:100
            temp1 = temp;
            f = cos(a*temp(1) + b*temp(2)) + 2*sinh(c*temp(1) + d*temp(2));
            g = exp(c*temp(2) + d*temp(1)) - exp(a*temp(2) - b*temp(1));
            dfdx = - (19*cosh((19*temp(1))/10 - temp(2)/5))/5 - 2*sin(2*temp(1) - temp(2)/10); 
            dfdy = (2*cosh((19*temp(1))/10 - temp(2)/5))/5 + sin(2*temp(1) - temp(2)/10)/10;
            dgdx = exp(- temp(1)/10 - 2*temp(2))/10 + exp(temp(1)/5 - (19*temp(2))/10)/5;
            dgdy = 2*exp(- temp(1)/10 - 2*temp(2)) - (19*exp(temp(1)/5 - (19*temp(2))/10))/10;
            temp = temp - [dfdx dfdy; dgdx dgdy]^-1 * [f; g];
            
            if (abs(temp1 - temp) == 0)
                break;
            end
            %plot([temp1(1), temp(1)], [temp1(2), temp(2)]);
        end
        x0(i,k) = temp(1);
        y0(i,k) = temp(2);
        
        if abs(x0(i,k)) <= L && abs(y0(i,k)) <= L
            plot(x0(i,k),y0(i,k)); hold on;
        end
        
%         if abs(x0(i,k)) > L || abs(y0(i,k)) > L
%             plot(X(i),Y(k),'b*'); hold on;
%         elseif abs(x0(i,k) - 0.177640622396722) < 0.001 && abs(y0(i,k) + 0.532921867190166) < 0.001
%             plot(X(i),Y(k),'r*'); hold on;
%         else
%             plot(X(i),Y(k),'y*'); hold on;
%         end
    end
end

figure;
for i = 1:n
    for k = 1:n  
        if abs(x0(i,k)) > L || abs(y0(i,k)) > L
            plot(X(i),Y(k),'b*'); hold on;
        %elseif abs(x0(i,k) - 0.177640622396722) < 10^-4 && abs(y0(i,k) + 0.532921867190166) < 10^-4
        %    plot(X(i),Y(k),'y*'); hold on;
       else
            plot(X(i),Y(k),'y*'); hold on;
        end
    end
end

 plot(0.177640622396722, -0.532921867190166,'k*','LineWidth',4); hold on;
xlabel('X','FontName','Arial Cyr','FontSize',25);
ylabel('Y','FontName','Arial Cyr','FontSize',25);
 
