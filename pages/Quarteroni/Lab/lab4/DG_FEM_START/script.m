clc
clear
nRef = [3:5];

for i = 1:length(nRef)
	{	
	[errors,solutions,femregion,Data]= main2D('Test2',nRef(i));
	
	errorl2(i) = errors.E_L2; 
	errorh1(i) = errors.E_H1;
	errordg(i) = errors.E_DG; 
	h(i) = femregion.h;
	condA(i) = Data.condA ;
	}
	
end
% close all
figure()
loglog( h, errorl2 , 'linewidth', 2, 'r-o')
hold on
loglog(h , errordg , 'linewidth', 2, 'b-o')
loglog( h , errorh1 , 'linewidth', 2, 'g-o')
loglog( h , h , 'linewidth', 2, 'k-.')
loglog( h , h.^2 , 'linewidth', 2, 'k-.')
xlabel('h')
legend('L^2', 'DG' , "H1" , "h" , "h^2")
set(gca,'FontSize',18)

figure()
loglog( h , condA , 'linewidth', 2, 'r-o')
hold on
loglog( h , h.^-2 , 'linewidth', 2, 'b-.')
loglog( h , h.^-1 , 'linewidth', 2, 'b-.')
