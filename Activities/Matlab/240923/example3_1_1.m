function[x,y,Ex,En,He]=example3_1_1(y_spor,n)
    Ex=mean(y_spor);
    En=mean(abs(y_spor-Ex)).*sqrt(pi./2);
    He=sqrt(var(y_spor)-En.^2);
    for q=1:n
        Enn=randn(1).*He+En;
        x(q)=randn(1).*Enn+Ex;
        y(q)=exp(-(x(q)-Ex).^2./(2.*Enn.^2));
    end
    x;
    y;