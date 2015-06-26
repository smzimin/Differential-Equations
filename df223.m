t = 0:0.0001:4*1.01585;
y0 = [ -7, -2, 4,	-8,	-7,	-7];
 
[t,y] = ode45(@(t, y) df223f(t, y),t,y0);

for i = 1:6
   figure;
   plot(t, y(:,i));
end

figure;
plot3(y(:,1), y(:,2), y(:,3));
grid;
figure;
plot3(y(:,4), y(:,5), y(:,6));
grid;

p = zeros(1,1); r = 0;
for i = 3:length(t)
    if abs(y(i,4) - y(1,4)) < 0.005 && abs(y(i,5) - y(1,5)) < 0.005 && abs(y(i,6) - y(1,6)) < 0.005
        r = r + 1;
        p(r,1) = i;
    end
end

figure;
plot(y(:,1), y(:,2));
figure;
plot(y(:,2), y(:,3));
figure;
plot(y(:,1), y(:,3));