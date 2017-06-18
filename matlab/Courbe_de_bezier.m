function []= Courbe_de_bezier()

resolution=50;       % precision de la future courbe de Bezier
K=0;                 % variable d'etat
matrice=0;
curvature=0% ensemble des points de controle
x=0
legende=0
while K~=4 % arr�ter
   K=menu('Que voulez-vous faire ?','NEW -cardinal splines- (bouton souris, puis <ENTER>)', 'NEW -Autre calcul des tangentes-', 'Superposer une courbe (cardinal spline)','ARRETER')
   if K==1 % NEW
      answer=inputdlg({'Valeur de c ?', 'Couleur du tracé ? (r,m,c,b,g,y,k)'});
      c=str2num(answer{1});
      figure(1)
      clf                  % affichage d'une fenetre vide
      hold on              % tous les plot seront ex�cut�s sur cette meme fenetre
      axis([0 10 0 10])    % les axes sont definitivement fixes
      axis off
      matrice=0;
      
      % Points de controle
      annotation('textbox', [0.3 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           'String', 'Entrer les points de controle', 'Tag', 'EntrerPC');
      for i=2:999         % on limite le nombre de points de controle � 1000
         [X,Y]=ginput(1);  % prise en compte d'un clic de souris
         if isempty(X)     % si on appuie sur <ENTER>
            break
      end
      matrice(1,i)=X;
      matrice(2,i)=Y;
      figure(1)
	  plot(matrice(1,i),matrice(2,i),'o') % affichage du point de controle i
      plot(matrice(1,2:i),matrice(2,2:i),'k') % affichage du polygone de controle
      end
      % Tangentes
      delete(findall(gcf,'Tag','EntrerPC'));
      annotation('textbox', [0.35 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           'String', 'Entrer les tangentes', 'Tag', 'EntrerTG');
      [X,Y]=ginput(1);
      matrice(1,1)=X;
      matrice(2,1)=Y;
	  plot(matrice(1,1),matrice(2,1),'x') % affichage du point 1
      plot(matrice(1,1:2),matrice(2,1:2),'r--') % affichage de la premiere tangente
      [X,Y]=ginput(1);
      nbpoints = size(matrice, 2)+1;
      matrice(1,nbpoints)=X;
      matrice(2,nbpoints)=Y;
	  plot(matrice(1,nbpoints),matrice(2,nbpoints),'x') % affichage du point 2
      plot(matrice(1,nbpoints-1:nbpoints),matrice(2,nbpoints-1:nbpoints),'r--') % affichage de la deuxieme tangente
      
      
      delete(findall(gcf,'Tag','EntrerTG'))
       
      Hermite_curve_points = eval_hermite(matrice,c, resolution, 0);
      figure(1)
      plot(Hermite_curve_points(1,:),Hermite_curve_points(2,:),answer{2})
      %calcul de la courbure de la courbe
      x=Hermite_curve_points(1,:)
      y=Hermite_curve_points(2,:)
      for i=2:size(x,2)-1
          curvature(i)=2*((x(i)-x(i-1))*(y(i+1)-y(i))-(y(i)-y(i-1))*(x(i+1)-x(i)));
          curvature(i) =curvature(i)/sqrt(((x(i)-x(i-1))^2 +(y(i)-y(i-1))^2)*((x(i+1)-x(i))^2+(y(i+1)-y(i))^2)*((x(i-1)-x(i+1))^2+(y(i-1)-y(i+1))^2));
      end
      curvature(1)=curvature(2)
      curvature(size(x,2))=curvature(size(x,2)-1)
      figure(2)
      clf;
      hold on
      plot(curvature,answer{2})
          
   elseif K==2 % Notre calcul des tangentes
      answer=inputdlg({'Couleur du tracé ? (r,m,c,b,g,y,k)'});
      c=0;
      figure(1)
      clf                  
      hold on              
      axis([0 10 0 10])    
      axis off
      matrice=0;
      
      % Points de controle
      annotation('textbox', [0.3 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           'String', 'Entrer les points de controle', 'Tag', 'EntrerPC');
      for i=2:999         
         [X,Y]=ginput(1);  
         if isempty(X)     
            break
      end
      matrice(1,i)=X;
      matrice(2,i)=Y;
      figure(1)
	  plot(matrice(1,i),matrice(2,i),'o') % affichage du point de controle i
      plot(matrice(1,2:i),matrice(2,2:i),'k') % affichage du polygone de controle
      end
      % Tangentes
      delete(findall(gcf,'Tag','EntrerPC'));
      annotation('textbox', [0.35 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           'String', 'Entrer les tangentes', 'Tag', 'EntrerTG');
      [X,Y]=ginput(1);
      matrice(1,1)=X;
      matrice(2,1)=Y;
	  plot(matrice(1,1),matrice(2,1),'x') % affichage du point 1
      plot(matrice(1,1:2),matrice(2,1:2),'r--') % affichage de la premiere tangente
      [X,Y]=ginput(1);
      nbpoints = size(matrice, 2)+1;
      matrice(1,nbpoints)=X;
      matrice(2,nbpoints)=Y;
	  plot(matrice(1,nbpoints),matrice(2,nbpoints),'x') % affichage du point 2
      plot(matrice(1,nbpoints-1:nbpoints),matrice(2,nbpoints-1:nbpoints),'r--') % affichage de la deuxieme tangente
      
      delete(findall(gcf,'Tag','EntrerTG'))
       
      Hermite_curve_points = eval_hermite(matrice,c, resolution, 1);
      figure(1)
      plot(Hermite_curve_points(1,:),Hermite_curve_points(2,:),answer{1})
      %calcul de la courbure de la courbe
      x=Hermite_curve_points(1,:)
      y=Hermite_curve_points(2,:)
      for i=2:size(x,2)-1
          curvature(i)=2*((x(i)-x(i-1))*(y(i+1)-y(i))-(y(i)-y(i-1))*(x(i+1)-x(i)));
          curvature(i) =curvature(i)/sqrt(((x(i)-x(i-1))^2 +(y(i)-y(i-1))^2)*((x(i+1)-x(i))^2+(y(i+1)-y(i))^2)*((x(i-1)-x(i+1))^2+(y(i-1)-y(i+1))^2));
      end
      curvature(1)=curvature(2)
      curvature(size(x,2))=curvature(size(x,2)-1)
      figure(2)
      clf;
      hold on
      plot(curvature,answer{1})
      
   elseif K==3 % ajouter une courbe
      answer=inputdlg({'Valeur de c ?', 'Couleur du tracé ?(r,m,c,b,g,y,k)'});
      c=str2num(answer{1});
      Hermite_curve_points = eval_hermite(matrice,c, resolution, 0);
      figure(1)
      plot(Hermite_curve_points(1,:),Hermite_curve_points(2,:),answer{2});
      x=Hermite_curve_points(1,:)
      y=Hermite_curve_points(2,:)
      for i=2:size(x,2)-1
          curvature(i)=2*((x(i)-x(i-1))*(y(i+1)-y(i))-(y(i)-y(i-1))*(x(i+1)-x(i)));
          curvature(i) =curvature(i)/sqrt(((x(i)-x(i-1))^2 +(y(i)-y(i-1))^2)*((x(i+1)-x(i))^2+(y(i+1)-y(i))^2)*((x(i-1)-x(i+1))^2+(y(i-1)-y(i+1))^2));
      end
      curvature(1)=curvature(2)
      curvature(size(x,2))=curvature(size(x,2)-1)
      figure(2)
      plot(curvature,answer{2})
   end
end
close
