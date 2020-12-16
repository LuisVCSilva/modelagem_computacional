#!/usr/bin/env octave

function [_ex1] = main(argv)
f1 = inline('5*x1-x2^2');
f2 = inline('x2-0.25*(sin(x1)+cos(x2))');
      f= @(raizes) [f1(raizes(1),raizes(2));
                    f2(raizes(1),raizes(2))
                   ];
                   
      %jacobiana, 
      jacobiana=@(x1,x2) ...
            [5 0;
             -1/4 1];
             
      %criando derivada de f a partir da jacobiana
      fl= @(raizes) jacobiana(raizes(1),raizes(2));

      palpite=[1/4 1/4]';

      raizes = raiz_newton(f, fl, palpite, 10^-6, 100);

      x1 = raizes(1);
      x2 = raizes(2);
      disp('As raízes são (x1,x2):');
      disp([x1,x2]);
      endfunction
      
function x = raiz_newton(f, fl, palpite, tol, max_it)%ponto fixo aqui
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


main(argv);