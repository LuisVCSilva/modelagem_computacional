#!/usr/bin/env octave

#{
3. Escreva o código em Octave para o método de Newton e, a partir dele, determine a raiz da
função f(x) = 2xcos(2x) − (x − 2)^2  no intervalo [0, 3] com precisão de 10^-7 . Imprima também
o número de iterações que foram necessárias para obter a solução.
#}

#{
Entrada 1:
  a     |   tol   |   N
---------------------------
4.64899    10^-7     100

Saída:
Raiz é = 2.370687


Entrada 2:
  a     |   tol   |   N
---------------------------
0.00000    10^-7     100

Saída:
Raiz é = 3.722113

Note que o algoritmo deve ser executado com intervalos distintos a fim de computar
todas as raízes da função.
#}
1;

function [Ex3] = main(argv)
  p0 = str2num(argv{1});
  TOL = str2num(argv{2});
  N = str2num(argv{3});
  i = 1;
  while(i<=N)
    p = p0-f(p0)/fl(p0);
    if(abs(p-p0)<TOL)
      printf("O método convergiu em %d iterações.\n",i);
      printf("A raiz é = %f\n", p);
      exit();
    endif
  i = i+1;
  p0 = p;
  endwhile
printf("\nO método não convergiu em %d iterações\n", N);
endfunction


function z = f (x)
  z = 2*x*cos(2*x) - (x - 2)^2;
endfunction

function zl = fl (x)
  zl = -2*x-4*x*sin(2*x)+2*cos(2*x)+4;
endfunction

main(argv);
