function army

x = 0:0.0001:2.6;
%[x,y] = ode45 (@(x, y) df221f(x, y), x, 1/7 + 1/14i);
A = 1.4+2.6i;
B = -3.2-4.9i;

% w0 = 1/7 + 1/14i;
% C = log( tanh(B*w0/2) ) / B;

C = - 2.5*A;
y = 2 * atanh( exp( B*(A*x + C) ) ) / B;plot(real(y), imag(y), 'r');  hold on;
xlabel('re(W)'); ylabel('im(W)');
figure;
plot(x,real(y) ); 
figure;
plot(x,imag(y) ); 


end


function yp = df221f(x,y)

A = 1.4+2.6i;
B = -3.2-4.9i;

yp = A*sinh(B*y);

end