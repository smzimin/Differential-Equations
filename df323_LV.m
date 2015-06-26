function yp = df323_LV(t,y)

yp = zeros(2,1);

a = 2.78;		
b = 3.73;
c = 2.06;
d = 2.5;

yp(1) = y(1)*(a - b*y(2));
yp(2) = y(2)*(-c + d*y(1));