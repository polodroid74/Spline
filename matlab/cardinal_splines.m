function [mk]= cardinal_splines(Pk, c)
    mk=0;
    n=size(Pk,2);
    for k=3:n-2 %On utilise le premier et dernier point comme tracé des dérivées m0 et mN
        mk(1,k)= (1-c)*(Pk(1,k+1)-Pk(1,k));
        mk(2,k)= (1-c)*(Pk(2,k+1)-Pk(2,k));
    end
    % Evaluation des tangentes aux extrémités à l'aide des points entrés à
    % la souris
    mk(1, 2)= Pk(1, 1) - Pk(1, 2);
    mk(2, 2)= Pk(2, 1) - Pk(2, 2); 
    mk(1, n-1)= Pk(1, n) - Pk(1, n-1);
    mk(2, n-1)= Pk(2, n) - Pk(2, n-1);
end