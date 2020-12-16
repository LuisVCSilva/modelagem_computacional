#!/usr/bin/env octave

#{
Metodo de Newton
#}

#{
Casos de Teste:
#}
1;

function [Ex3] = main(argv)
  p0 = str2num(argv{1});
  TOL = str2num(argv{2});
  N = str2num(argv{3});
  printf("\n-------------------------\n");
  printf("\nRealizando o metodo de Newton para p0=%f, tol=%f,N=%d\n",p0,TOL,N);
  i = 1;
  while(i<=N)
    p = p0-f(p0)/fl(p0);
    if(abs(p-p0)<TOL)
      printf("O método convergiu em %d iterações.\n",i);
      printf("Raiz é = %f\n", p);
      exit();
    endif
  i = i+1;
  p0 = p;
  endwhile
printf("\nO método não convergiu em %d iterações\n", N);
endfunction


function z = f (x)
  z = x^3+4*x^2-10;
endfunction

function zl = fl (x)
  zl = 3*x^2+8*x;
endfunction

main(argv);
