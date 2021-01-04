Lx = 1.e5;
Ly = 2*pi*1.e4;
H = 200;
W = 0.3*1.e-7;
R = 0.6*1.e-3;
% beta = 0;
beta = 5*1e-10;

alpha = H*beta/R;
gamma = W*pi/(R*Ly);

lambda1 = -alpha*0.5 + sqrt((alpha*0.5)^2+(pi/Ly)^2);
lambda2 = -alpha*0.5 - sqrt((alpha*0.5)^2+(pi/Ly)^2);

c2 = (Ly/pi)^2*gamma*((exp(lambda1*Lx)-1)/(exp(lambda2*Lx)-exp(lambda1*Lx)));
c1 = - c2 - (Ly/pi)^2*gamma;

psi = @(x,y,c1,c2,lambda1,lambda2,Ly,gamma) (c1*exp(lambda1*x) + c2*exp(lambda2*x) + (Ly/pi)^2*gamma).*sin(pi/Ly*y);

x = linspace(0,Lx,100);
y = linspace(0,Ly,1000);

[X,Y] = meshgrid(x,y);

surf(X,Y,psi(X,Y,c1,c2,lambda1,lambda2,Ly,gamma),'EdgeColor','none');
