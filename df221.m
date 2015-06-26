x = 0:0.001:2*pi;

[x,y1] = ode45(@(x, y1) df221f(x, y1),x,[1,1]);
[x,y2] = ode45(@(x, y2) df221f(x, y2),x,[4,4]);

figure;
plot(x, y1(:,1), 'r');  hold on;
plot(x, y2(:,1));  hold on;

W1 = y1(:,1).*y2(:,2) - y1(:,2).*y2(:,1);

figure;
plot(x, W1);  hold on;

W2 = (y1(1,1)*y2(1,2) - y2(1,1)*y1(1,2))*exp(-0.4*x);
dW = abs(W1 - W2);
figure;
plot(x, dW);  hold on;

M = [y1(length(x),1) y2(length(x),1); y1(length(x),2) y2(length(x),2)] * [y1(1,1) y2(1,1); y1(1,2) y2(1,2)]^(-1);

l = eig(M);