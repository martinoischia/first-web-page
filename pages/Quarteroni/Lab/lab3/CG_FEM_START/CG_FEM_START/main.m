clear
clc
% test = 'Transport 0';
test = 'Test2';

[errors,~,femregion,Dati] = C_main2D ( test, 1);

ref = length(Dati.refinement_vector);

h=[femregion.h];
if (Dati.plot_errors=='Y')
	errorh1 = errors.Error_H1;
	errorl2 = errors.Error_L2;
end
while(ref>0) % non usare while
	
	[errors,~,femregion,~] = C_main2D ( test, flip(Dati.refinement_vector)(ref));
	h = [h, femregion.h];
	
	if (Dati.plot_errors=='Y')
		errorh1 = [errorh1, errors.Error_H1];
		errorl2 = [errorl2, errors.Error_L2];
	end
	ref=ref-1;
end


if (Dati.plot_errors=='Y')
	figure
	loglog(h, errorh1, 'linewidth', 2 , '-o')
	hold on
	loglog(h, errorl2, 'linewidth', 2, 'r-o')
	loglog(h, 10*h, 'k-.','linewidth',1)
	loglog(h, 10*h.^2, 'k--','linewidth',1)
	set(gca,'FontSize',18)
	legend('H^1','L^2','h','h^2')
end