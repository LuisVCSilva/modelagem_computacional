#!/usr/bin/env octave

function [ex3] = main (argv)
      f1= @(x1,x2,x3) 6*x1-2*cos(x2*x3)-1;
      f2= @(x1,x2,x3) 9*x2+sqrt(x1^2+sin(x3)+1.06)+0.9;
      f3= @(x1,x2,x3) 60*x3+3*exp(-x1*x2)+10*pi-3;
      %combina todas as eqs em uma so
      f= @(raizes) [f1(raizes(1),raizes(2),raizes(3));
                    f2(raizes(1),raizes(2),raizes(3));
                    f3(raizes(1),raizes(2),raizes(3))];

      %jacobiana, 
      jacobiana=@(x,y,z) ...
            [6 0 0;
             0 9 0.4856;
             0 0 60];
             
      %criando derivada de f a partir da jacobiana
      fl= @(raizes) jacobiana(raizes(1),raizes(2),raizes(3));

      palpite=[0 0 0]';

      raizes = raiz_newton(f, fl, palpite, 10^-6, 100);

      x1 = raizes(1);
      x2 = raizes(2);
      x3 = raizes(3);
      disp('As raízes são (x1,x2,x3):');
      disp([x1,x2,x3]);
      endfunction
      
function x = raiz_newton(f, fl, palpite, tol, max_it)
   x = palpite;
   for i=1 : max_it
      a = feval(f, x);
      jacobiana = feval(fl, x);
      x_anterior = x;
      x = x-inv(jacobiana)*a;
      if ( norm(x-x_anterior) <= tol || norm(a) <= tol ) 
         break;
      endif
   endfor
endfunction