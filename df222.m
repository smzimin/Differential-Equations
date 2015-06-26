x = 0:0.001:2*pi;

[x,y1] = ode45(@(x, y1) df222f(x, y1),x,[1,0]);
[x,y2] = ode45(@(x, y2) df222f(x, y2),x,[0,1]);

figure;
plot(x, real(y1(:,1)), 'r');  hold on;
plot(x, real(y2(:,1)));  hold on;

figure;
plot(x, imag(y1(:,1)), 'r');  hold on;
plot(x, imag(y2(:,1)));  hold on;

W1 = y1(:,1).*y2(:,2) - y1(:,2).*y2(:,1);

figure;
plot(x, real(W1));  hold on;

figure;
plot(x, imag(W1));  hold on;


W2 = (y1(1,1)*y2(1,2) - y2(1,1)*y1(1,2))*exp(-0.4i*x);
dW = abs(W1 - W2);
figure;
plot(x, dW);  hold on;

M = [y1(length(x),1) y2(length(x),1); y1(length(x),2) y2(length(x),2)] * [y1(1,1) y2(1,1); y1(1,2) y2(1,2)]^(-1);

l = eig(M);