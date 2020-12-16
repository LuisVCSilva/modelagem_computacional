#!/usr/bin/env octave

function [Broyden] = main (argv)
      f1= @(x1,x2,x3) 3*x1-cos(x2*x3)-0.5
      f2= @(x1,x2,x3) x1^2-625*x2^2-0.25
      f3= @(x1,x2,x3) exp(-x1*x2)+20*x3+((10*pi-3)/(3))
      %combina todas as eqs em uma so
      f= @(raizes) [f1(raizes(1),raizes(2),raizes(3));
                    f2(raizes(1),raizes(2),raizes(3));
                    f3(raizes(1),raizes(2),raizes(3))];

      %jacobiana, 
      %jacobiana=@(x,y,z) ...
      %      [3 0 0;
      %       0 0 0;
      %       0 0 20];
             
      %criando derivada de f a partir da jacobiana
      %fl= @(raizes) jacobiana(raizes(1),raizes(2),raizes(3));

      palpite=[0 0 0]';%use 0 0 0, ja que se o palpite inicial=(1 1 -1), o metodo ñ converge

      raizes = broyden(f, palpite, 100,10^-6);

      x1 = raizes(1);
      x2 = raizes(2);
      x3 = raizes(3);
      printf('As raízes são (x1,x2,x3): %f %f %f\n',x1,x2,x3);
      endfunction
      
function [x,y,i,r]=broyden(f,x_anterior, max_it,tol);
_tol = tol;
y0 = feval(f,x_anterior);
jacobiana = [3 0 0;
             0 0 0;
             0 0 20];%eh singular, se computar numerica eh ok
erro = 1;
r = norm(y0);
for i = 1:max_it
    d = -jacobiana\y0;
    x = x_anterior+d;
    y = feval(f,x);
    jacobiana = jacobiana+((y-y0)-jacobiana*d)*d'/(d'*d);
    aux = sqrt((x-x_anterior)'*(x-x_anterior));
    erro = aux-_tol*(1+abs(x));
    f_erro = sqrt(y'*y);
    x_anterior = x;
    y0 = y;
    r(i+1)=norm(y);
    if r(i+1)<tol;
       break;
    endif
endfor
if f_erro<_tol;
    term = 1;
else
    term = 0;
endif
endfunction

main(argv);