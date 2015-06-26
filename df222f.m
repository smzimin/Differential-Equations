function yp = df222f(y, x)
yp = zeros(2,1);

yp(1)= y(2) + 5*y(1)*(y(1)^2+y(2)^2);
yp(2)= -y(1) + 5*y(2)*(y(1)^2+y(2)^2);