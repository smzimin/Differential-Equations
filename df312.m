function df312


p = -1.3:0.05:1.3;
q = -1.7:0.05:1.7;


t = 0:0.1:2;
for i = 1:length(p)
    for k = 1:length(q)
        [t,y] = ode45(@(t, y) f(t, y), t, [p(i),q(k)]);
        plot(y(:,1),y(:,2));  hold on;
    end
end
xlabel('y'); ylabel('dy/dt');

figure;
t = 0:0.1:4;
for i = 1:length(p)
    for k = 1:length(q)
        [t,y] = ode45(@(t, y) f(t, y), t, [p(i),q(k)]);
        plot(y(length(t),1),y(length(t),2));  hold on;
    end
end


xlabel('y'); ylabel('dy/dt');

figure;
t = 0:-0.1:-1;
for i = 1:length(p)
    for k = 1:length(q)
        [t,y] = ode45(@(t, y) f(t, y), t, [p(i),q(k)]);
        plot(y(length(t),1),y(length(t),2));  hold on;
    end
end


xlabel('y'); ylabel('dy/dt');

end

function yp = f(t,y)

yp = zeros(2,1);

k = 2.2;
r = 2.4;

yp(1) = y(2);
yp(2) = -k*y(2) - sinh(r*t)*y(1);

end