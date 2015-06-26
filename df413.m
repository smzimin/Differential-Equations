clear;

R = 2.85;
k = 4;
p = k;
step = 0.01;
stik = 0.1;
r1 = 0:step:stik;
r2 = stik+step:step:R;
r = horzcat(r1,r2);
a0 = 1;

lambdihoroshenkie = zeros(1,4);
counter = 1;

figure;
for lambda = -38.17:-0.001:-38.2

    a2 = lambda*a0/(4*(p+1));

    u1 = a0*r1.^p + a2*r1.^(p+2);
    uStik = a0*(stik+step)^p + a2*(stik+step)^(p+2);
    duStik = a0*p*(stik+step)^(p-1) + a2*(p+2)*(stik+step)^(p+1);

    [r2,u2] = ode45(@(r,u2)[u2(2); (-r*u2(2)+lambda*r^2*u2(1)+16*u2(1))/(r^2) ],r2,[uStik duStik]);
    
    r0 = find(r == R);

    u = vertcat(u1.',u2(:,1));
    plot(r,u); hold on;
    
    if (abs(u(r0,1)) < 10^-5)
        lambdihoroshenkie(counter) = lambda;
        counter = counter + 1;
        plot(r,u,'r','LineWidth',1.5); hold on;
    else
        plot(r,u); hold on;
    end
 
end
plot(R,0,'g+','LineWidth',2);
xlabel('r','FontName','Arial Cyr','FontSize',25);
ylabel('U','FontName','Arial Cyr','FontSize',25);
title('Графики решений с lambda = -7:-1:-30 в ас-ке у нуля','FontName','Arial Cyr','FontSize',25);

lambdihoroshenkie = [-7.09825; -15.0707; -25.428; -38.199];
fi = 0:(2*pi)/(length(r)-1):2*pi;

for numLambd = 1:4

    figure;
    lambda = lambdihoroshenkie(numLambd);
    a2 = lambda*a0/(4*(p+1));
    u1 = a0*r1.^p + a2*r1.^(p+2);

    uStik = a0*(stik+step)^p + a2*(stik+step)^(p+2);
    duStik = a0*p*(stik+step)^(p-1) + a2*(p+2)*(stik+step)^(p+1);
    [r3,u2] = ode45(@(r,u2)[u2(2); (-r*u2(2)+lambda*r^2*u2(1)+16*u2(1))/(r^2) ],r2,[uStik duStik]);
    u = vertcat(u1.',u2(:,1)); u = u.';

    
    Y = zeros(length(r), length(fi));
    A = zeros(length(r), length(fi));
    B = zeros(length(r), length(fi));

    for i = 1:length(r)
        for p = 1:length(fi)
           Y(i,p) = u(i)*sin(k*fi(p));
           A(i,p) = cos(fi(p))*r(i);
           B(i,p) = sin(fi(p))*r(i);
        end
    end
    mesh(A,B,Y);

    xlabel('x','FontName','Arial Cyr','FontSize',25);
    ylabel('y','FontName','Arial Cyr','FontSize',25);
    zlabel('Y','FontName','Arial Cyr','FontSize',25);
    
end

