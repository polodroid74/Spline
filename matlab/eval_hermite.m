function [Hermite_curve_points]= eval_Hermite(Pk, c, resolution, choix_approx_tangentes)
    mk = 0;
    n=size(Pk,2);
    
    if choix_approx_tangentes == 1 %%Notre proposition d'approximation des tangentes
        mk = notre_proposition(Pk);
    else %%Cardinal splines
        mk = cardinal_splines(Pk, c);
    end
    for i=2:n-2
          ptcont(1,1)=Pk(1,i)
          ptcont(2,1)=Pk(2,i)
          
          ptcont(1,2)=Pk(1,i) +1/3 * mk(1,i)
          ptcont(2,2)=Pk(2,i) + 1/3 * mk(2,i)

          ptcont(1,3)=Pk(1,i+1) -1/3 * mk(1,i+1)
          ptcont(2,3)=Pk(2,i+1) - 1/3 * mk(2,i+1)

          ptcont(1,4)=Pk(1,i+1)
          ptcont(2,4)=Pk(2,i+1)
         
          if i==2
             Hermite_curve_points=eval_decasteljau(ptcont, resolution);
          else  
             Hermite_curve_points= [Hermite_curve_points eval_decasteljau(ptcont, resolution)];      
          end
      
    end        
end