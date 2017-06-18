function [Bezier_curve_points]= eval_decasteljau(matrice,resolution)
tmp=matrice;
n=size(matrice,2)-1;
temps=1:resolution;
for t=temps
    tmp=matrice;
    for k=1:n
        for i=1:n-k +1
            tmp(1, i)=((t-1)/resolution)*(tmp(1, i+1)) + (1-((t-1)/resolution))*(tmp(1, i));
            tmp(2, i)=((t-1)/resolution)*(tmp(2, i+1)) + (1-((t-1)/resolution))*(tmp(2, i));
        end
    end
    Bezier_curve_points(1,t)=tmp(1,1);
    Bezier_curve_points(2,t)=tmp(2,1);         
end 

% affichage de la courbe de B�zier
%plot(abscisse,ordonnee,'r')