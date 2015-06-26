function yp = df224f(t,y)
yp = zeros(2,1);

yp(1)= y(2);
yp(2)= -7.4*sin(3*y(1)) + 10*cos(2*y(1));