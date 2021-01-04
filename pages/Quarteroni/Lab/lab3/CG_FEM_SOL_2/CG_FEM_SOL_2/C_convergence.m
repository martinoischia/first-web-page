function C_convergence(TestName)
%% Usage: C_convergence('Test1')

    Data = C_dati(TestName);
    
    n_tests = length(Data.refinement_vector);

    for i_test = 1:n_tests
        [errors,~,femregion,~]= C_main2D(TestName, Data.refinement_vector(i_test));
        err_L2(i_test) = errors.Error_L2;
        err_H1(i_test) = errors.Error_H1;
        h(i_test) = femregion.h;
    end
    
    disp('h:')
    disp(h)
    disp('L2 errors:')
    disp(err_L2)
    disp('H1 errors:')
    disp(err_H1)

    %%
    figure()
    loglog(h, [err_L2;err_H1],'o-','linewidth',2)
    hold on
    loglog(h, h, 'k-','linewidth',2)
    loglog(h, h.^2, 'k--','linewidth',2)
    grid on
    legend('L^2','H^1','h','h^2')

end