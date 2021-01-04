function is_triangle(a,b,c)
    lati = sort([a b c]);
    ip = max(lati);
    cat1 = lati(1); 
    cat2 = lati(2);
    if abs(1 - (cat1^2 + cat2^2)/ip^2) < 2*eps
        disp('Yes!');
    else
        disp('No!');
    end
end