t = 0:0.0001:2*pi;

nachZnach = zeros(1,4); p = 1;
z = zeros(1,length(t));

for i = 1:length(t)
    z(1,i) = -7.4*sin(3*t(1,i)) + 10*cos(2*t(1,i));
  if abs(-7.4*sin(3*t(1,i)) + 10*cos(2*t(1,i))) <= 0.0115
      nachZnach(1,p) = t(1,i);
      p = p + 1;
  end
end


t = 0:0.01:2*pi;

[t,y] = ode45(@(t, y) df224f(t, y),t,[0,0]);
%plot(t, y(:,1),'r');  hold on;

% for d = 0.01:0.03:0.1
%    [t,y] = ode45(@(t, y) df224f(t, y),t,[nachZnach(1,4) + d,0 + d]);
%    plot(t, y(:,1));  hold on;
% end


[y1,y2] = meshgrid(y(:,1),y(:,2));
E = 0.5*y(:,2).^2 - 7.4/3*cos(3*y(:,1)) - 5*sin(2*y(:,1));
E1=meshgrid(E);
t1=meshgrid(t);
z1=meshgrid(z);
streamslice(y1,y2,z1,E1);