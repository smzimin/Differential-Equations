clear;

a = 2.3 - 0.5i;
b = 1.7 + 0.6i;
%b = -0.105098 - 0.0235737i;

reX = -2.5:0.01:2.5;
imY = reX;

syms z f df;

f = sinh(z) + a * z^2 - b;
df = diff(f,z);


[imY,  reX] = meshgrid(imY, reX);
z0 = abs(sinh(reX + 1i*imY) + a * ( reX + 1i*imY ).^2 - b);
figure;
mesh(reX,imY,z0); hold on;
plot3(-1.11766871646989, -0.335658468067915,0,'r*','LineWidth',4); hold on;
plot3(0.650717663993730, 0.188782025950836,0,'r*','LineWidth',4); hold on;
xlabel('Re(Z)','FontName','Arial Cyr','FontSize',25);
ylabel('Im(Z)','FontName','Arial Cyr','FontSize',25);
zlabel('|sinh(z) + a * z^2 - b|','FontName','Arial Cyr','FontSize',25);
figure;
[c,h]=contour(reX,imY,z0); clabel(c,h); hold on;
[c,h]=contour(reX,imY,z0, 0:1:5); clabel(c,h); hold on;
[c,h]=contour(reX,imY,z0, 0:0.2:1); hold on;
plot(-1.11766871646989, -0.335658468067915,'r+'); hold on;
plot(0.650717663993730, 0.188782025950836,'r+'); hold on;
xlabel('Re(Z)','FontName','Arial Cyr','FontSize',25);
ylabel('Im(Z)','FontName','Arial Cyr','FontSize',25);



reX = -2.5:0.1:2.5;
imY = reX;

z0 = zeros(length(reX),length(reX));
n = length(reX);

for i = 1:n
    for k = 1:n        
        z0(i,k) = reX(i) + 1i*imY(k);
        for iter = 1:100                      
            z0(i,k) = z0(i,k) - (sinh(z0(i,k)) + z0(i,k)^2*(23/10 - 1i/2) - 17/10 - (3*1i)/5)/(z0(i,k)*(23/5 - 1i) + cosh(z0(i,k))); 
        end
        
        if abs(real(z0(i,k))) > 2.5 || abs(imag(z0(i,k))) > 2.5
            z0(i,k) = 1;
        elseif abs(-1.11766871646989 - 0.335658468067915i - z0(i,k)) < 0.00000000001
            z0(i,k) = 2;
        elseif abs(0.650717663993730 + 0.188782025950836i - z0(i,k)) < 0.00000000001
            z0(i,k) = 3;
        else
           z0(i,k) = 4; 
        end
    end
end

figure;
for i = 1:n
    for k = 1:n        
        if z0(i,k) == 1
           plot(reX(i),imY(k),'b*','LineWidth',2); hold on;
        elseif z0(i,k) == 2
           plot(reX(i),imY(k),'g*'); hold on;
        elseif z0(i,k) == 3
           plot(reX(i),imY(k),'r*'); hold on;
        else
           plot(reX(i),imY(k),'y*'); hold on;
        end
    end
end

plot(-1.11766871646989, -0.335658468067915,'k*','LineWidth',4); hold on;
plot(0.650717663993730, 0.188782025950836,'k*','LineWidth',4); hold on;
xlabel('Re(Z)','FontName','Arial Cyr','FontSize',25);
ylabel('Im(Z)','FontName','Arial Cyr','FontSize',25);

