clear;

a = -1.15;
b = -2.69;

step = 0.001;

x1 = -pi/2:0.0001:-pi/2+step;
x2 = -pi/2+2*step:step:0;
x3 = pi/2-2*step:-step:0;
x4 = pi/2:-0.0001:pi/2-step;

counter = 0;

lambda = -15;



    c0 = 1;
    c1 = c0*(lambda - a - b);

    u1 = c0 + c1*(x1+pi/2);
    uStuk1 = c0 + c1*(-pi/2+2*step+pi/2);
    duStuk1 = c1;

    [t,u2] = ode45(@(t,u)[u(2); (sin(t)*u(2) + (lambda - a - b*(sin(t))^2)*u(1)) / cos(t)  ], x2, [uStuk1  duStuk1]);


%    c0 = 1;
    c1 = -c0*(lambda - a - b);

    u4 = c0 + c1*(x4-pi/2);
    uStuk2 = c0 + c1*(pi/2-2*step-pi/2);
    duStuk2 = c1;

    [t,u3] = ode45(@(t,u)[u(2); (sin(t)*u(2) + (lambda - a - b*(sin(t))^2)*u(1)) / cos(t)  ], x3, [uStuk2  duStuk2]);


    x3 = x3(end:-1:1);
    x4 = x4(end:-1:1);
    u3(:, :) = u3(end:-1:1, :);
    u4 = u4(end:-1:1);

x = horzcat(x1, x2, x3, x4);
u = horzcat(u1, u2(:,1)', u3(:,1)', u4);

plot(x, u);

