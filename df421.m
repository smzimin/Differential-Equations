clear;

N = 3;
r = 4 + N;
e = [1 2 3];
T = [-1 1 2 3];
sigm = 2.12;
b = 1.3;
f = [1 0 0; 0 1 0; 0 0 1];

syms x y z dx dy dz;

dx = -sigm*(x-y);
dy = -x*z-y+r*x;
dz = x*y - b*z;

S = solve(dx == 0, dy == 0, dz == 0, x, y, z);      % Находим стац. точки
S = double([S.x S.y S.z]);

S = [0 0 0;
    2.7928 2.7928 6.0000;
    -2.7928 -2.7928 6.0000];

J = [diff(dx,x) diff(dx,y) diff(dx,z);             % Матрица Якоби
    diff(dy,x) diff(dy,y) diff(dy,z);
     diff(dz,x) diff(dz,y) diff(dz,z)];
 
JT = zeros(3,3);
 
 for i = 1:3
     JT(i,:) = eig(double(subs(J, [x, y, z], S(i,:))));
 end

A = zeros(4, 3);

for i = 1
    step = 0.001*T(i)/(abs(T(i)));
    t = 0:step:T(i);
 
    [t,u] = ode45(@(t,u)[-sigm*(u(1)-u(2)); -u(1)*u(3)-u(2)+r*u(1); u(1)*u(2) - b*u(3); ], t, e);
    
    s = 10^-2; 
    while 2 < 3 
          
        [t,u1s] = ode45(@(t,us)[-sigm*(us(1)-us(2)); -us(1)*us(3) - us(2)+r*us(1); us(1)*us(2) - b*us(3); ], t, e + s*f(1,:));
        [t,u2s] = ode45(@(t,us)[-sigm*(us(1)-us(2)); -us(1)*us(3) - us(2)+r*us(1); us(1)*us(2) - b*us(3); ], t, e + s*f(2,:));
        [t,u3s] = ode45(@(t,us)[-sigm*(us(1)-us(2)); -us(1)*us(3) - us(2)+r*us(1); us(1)*us(2) - b*us(3); ], t, e + s*f(3,:));

        [t,u1s2] = ode45(@(t,us)[-sigm*(us(1)-us(2)); -us(1)*us(3) - us(2)+r*us(1); us(1)*us(2) - b*us(3); ], t, e + s*f(1,:)/2);
        [t,u2s2] = ode45(@(t,us)[-sigm*(us(1)-us(2)); -us(1)*us(3) - us(2)+r*us(1); us(1)*us(2) - b*us(3); ], t, e + s*f(2,:)/2);
        [t,u3s2] = ode45(@(t,us)[-sigm*(us(1)-us(2)); -us(1)*us(3) - us(2)+r*us(1); us(1)*us(2) - b*us(3); ], t, e + s*f(3,:)/2);
        
        temp1 = abs(u1s(length(t), :) - u(length(t), :) - 2*( u1s2(length(t), :) - u(length(t), :)  )) < 10^-2;
        temp2 = abs(u2s(length(t), :) - u(length(t), :) - 2*( u2s2(length(t), :) - u(length(t), :)  )) < 10^-2;
        temp3 = abs(u3s(length(t), :) - u(length(t), :) - 2*( u3s2(length(t), :) - u(length(t), :)  )) < 10^-2;
        
        if min(temp1) == 1 && min(temp2) == 1 && min(temp3) == 1
            break;
        else
            s = s/5;
        end
        
    end
    
    M0 = [u1s(1,1) - u(length(t),1) u1s(1,2) - u(length(t),2)  u1s(1,3) - u(length(t),3);
            u2s(1,1) - u(length(t),1) u2s(1,2) - u(length(t),2)  u2s(1,3) - u(length(t),3);
            u3s(1,1) - u(length(t),1) u3s(1,2) - u(length(t),2)  u3s(1,3) - u(length(t),3)];
        
        MT = [u1s(length(t),1) - u(length(t),1) u1s(length(t),2) - u(length(t),2)  u1s(length(t),3) - u(length(t),3);
            u2s(length(t),1) - u(length(t),1) u2s(length(t),2) - u(length(t),2)  u2s(length(t),3) - u(length(t),3);
            u3s(length(t),1) - u(length(t),1) u3s(length(t),2) - u(length(t),2)  u3s(length(t),3) - u(length(t),3)];
        
        A(i,:) = eig( MT * M0^-1);
        
       % figure;
       % comet3(u(:,1),u(:,2),u(:,3));

end
 
figure;
plot3(u(:,1),u(:,2),u(:,3), 'r'); hold on;
plot3(u1s(:,1),u1s(:,2),u1s(:,3)); 
plot3(u2s(:,1),u2s(:,2),u2s(:,3)); 
plot3(u3s(:,1),u3s(:,2),u3s(:,3)); 
title('Траектории от t = 0 до T = 3','FontName','Arial Cyr','FontSize',15);
xlabel('X','FontName','Arial Cyr','FontSize',15);
ylabel('Y','FontName','Arial Cyr','FontSize',15);
zlabel('Z','FontName','Arial Cyr','FontSize',15);
