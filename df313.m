% x = -1.5:0.00001:2;
x = -1.45:0.001:-1.25;
p = 7.2;
q = -8.7;

% a =  - ( 10*p*x.^3 + 6*q*x.^2 + 3*x  );
% b = - x .* ( 2*a + 5*p*x.^3 + 4*q*x.^2 + 3*x    ) ;
% 
% plot(a,b); hold on;
% xlabel('a'); ylabel('b');


y = -0.6:0.001:0.6;
[X, Y] = meshgrid(x,y);


% a1 = 1;
% b1 = 5;
% figure;
% %f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;
% %plot(x,f);
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% figure;
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);


% a1 = 1;
% b1 = -4;
% figure;
% % f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;
% % plot(x,f);
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% figure;
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% 
% a1 = -0.045;
% b1 = 0.00009;
% figure;
% %f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;
% %plot(x,f);
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% figure;
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% 
% a1 = 2.66;
% b1 = -1.306;
% figure;
% %f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;;
% %plot(x,f);
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% figure;
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% 
% t = -1;
% a1 =  - ( 10*p*t^3 + 6*q*t^2 + 3*t  );
% b1 = - t* ( 2*a1 + 5*p*t^3 + 4*q*t^2 + 3*t    ) ;
% figure;
% %f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;
% %plot(x,f);
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% figure;
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% 
% t = 0.2;
% a1 =  - ( 10*p*t^3 + 6*q*t^2 + 3*t  );
% b1 = - t* ( 2*a1 + 5*p*t^3 + 4*q*t^2 + 3*t    ) ;
% figure;
% %f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;
% %plot(x,f);
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% figure;
% Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
% [c,h]=contourf (X, Y, Z); clabel(c,h);
% 
t = 1;
a1 =  - ( 10*p*t^3 + 6*q*t^2 + 3*t  );
b1 = - t* ( 2*a1 + 5*p*t^3 + 4*q*t^2 + 3*t    ) ;
figure;
%f = x.^5 + p*x.^4 + q*x.^3 + a1*x.^2 + b1*x + 7;
%plot(x,f);
Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 - Y.^2;
[c,h]=contourf (X, Y, Z); clabel(c,h);
figure;
Z = X.^5 + p*X.^4 + q*X.^3 + a1*X.^2 + b1*X + 7 + Y.^2;
[c,h]=contourf (X, Y, Z); clabel(c,h);