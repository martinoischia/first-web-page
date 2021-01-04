%% 
% *VECTORS AND ARRAYS*
% 
% Ex 1. Definition of vectors

v1 = 2.^(0:10)
v2 = cos (pi ./ (1:10))'
format short g, v3 = 0.1 .* 2 .^ (0:-1:-5)
%% 
% Ex 2. Definition of array B

B = [1:7; 9:-2:-3; 2.^(2:8)]
%% 
% Ex 3. 

%Sum 5 and 7 columns of B 
B * [0 0 0 0 1 0 1]'
%Last row of B
[0 0 1] * B
%Swap 2nd and 3rd rows of B
[1 0 0; 0 0 1; 0 1 0] * B
%% 
% *PLOTS*
% 
% Ex 1. Use of '@' and 'inline' commands to define and evaluate a function

x=[0:3];
% definition with @
f1=@(x) x.*sin(x)+(1/2).^(sqrt(x));
f1(x)
% definition with 'inline'
f1_in = inline('x.*sin(x)+(1/2).^(sqrt(x))','x');
f1_in(x)

% the same cna be done for f2
f2=@(x) x.^4+log(x.^3+1);
f2(x)
f2_in = inline('x.^4+log(x.^3+1)','x');
f2_in(x)
%% 
% Ex 2. Plot different curves in the same figure 

figure()
x = 0:0.01:6;
f = @(x) 2 + (x-3).*sin(5*(x-3));
plot(x,f(x),'Linewidth',2,'Color','r') 
hold on; grid on;
g = @(x) -x +5;
h = @(x) x - 1;
plot(x,g(x),'LineWidth',1,'LineStyle','--','Color','k')
plot(x,h(x),'LineWidth',1,'LineStyle','--','Color','k')
legend('2 + (x-3).*sin(5*(x-3)');

xlim([0.64 5.45])
ylim([0.15 4.54])
%% 
% Ex 3. Plot functions using the logarthmic scale

x = 0:0.01:10;
f = @(x) exp(x);
g = @(x) exp(2*x);
figure;
semilogy(x,f(x),'Linewidth',2,'Color','b') 
hold on; grid on;
semilogy(x,g(x),'LineWidth',2,'LineStyle','--','Color','k')
legend('exp(x)','exp(2x)');
xlabel('linear scale');
ylabel('logarithmic scale');
%% 
% *SCRIPTS AND LOOPS*
% 
% Ex 1. Double for loop for the definition of the HIlbert matrix

a = zeros(5);
for i = 1 : 5
    for j = 1 : 5
        a(i,j) = 1/(i+j-1);
    end
end
disp(a)
disp([a-hilb(5)])
%% 
% Ex 2.  Example of while loop

year = 0;
deposit = 10e3;
deposit_values = deposit;
interest_rate = 1.02;
while (deposit < 1e6)
    year = year + 1;
    deposit = deposit * interest_rate + 10e3;
    deposit_values = [deposit_values deposit];
end
disp(year);
%% 
% Ex 3. An other use of the while loop

n=1;
while ( sum(1:n) < 88 )     
   n=n+1;
end
n
%% 
% *FUNCTIONS AND OUTPUTS*
% 
% Ex 1. Use of the funtion Is_triangle.m to check whether a triangle is rectangle 
% or not.

Is_triangle(3,4,5);
%% 
% Ex 2. Definition of the matrix T using the matrixT.m function

T = matrixT(10)
%% 
% Ex 3.  Definition of a recursive sequence

clear; clc;
a(1) = 1;
for ii = 1:10
  a(ii+1) = a(ii)/2 + 1/a(ii);
end
figure()
subplot(2,1,1)
plot(1:numel(a), a, 'x-b')
hold on
plot(1:numel(a), sqrt(2)+0*a, 'r--')
grid on
title('sequence')

subplot(2,1,2)
semilogy(1:length(a),abs(a-sqrt(2)),'o-')
grid on
title('error')
%% 