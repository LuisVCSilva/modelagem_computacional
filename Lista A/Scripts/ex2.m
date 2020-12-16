#!/usr/bin/env octave

#{
2. Escreva o código em Octave para o método da Bisseção e, a partir dele, determine a raiz da
função f(x) = 2*x*(cos(2*x))-(x+1)^2 para −4 ≤ x ≤ −1,5. Considere uma precisão de 10^-6 e determine também o número de iterações.
#}

#{
Entrada 1:
  a |  b  |  tol   | N
---------------------------
 -4 |-1.5 | 10^-6 | 100

Saída:
Raiz é = -2.191308


Entrada 2:
a |  b  |  tol   | N
---------------------------
-1 1 10^-6 100

Saída:
Raiz é = -0.798160

Note que o algoritmo deve ser executado com intervalos distintos a fim de computar
todas as raízes da função.
#}
1;

function [Ex2] = main(argv)
a = str2num(argv{1});
b = str2num(argv{2});
tolerancia = str2num(argv{3});
N = str2num(argv{4});

i = 1;
FA = f(a);

while(i<=N)
   p = (b+a)/2;
   FP = f(p);
   if((FP == 0) || ((b-a)/2<tolerancia))
    printf("O método convergiu em %d iterações.\n",i);
    printf("Raiz é = %f\n",p);
    exit();
   endif
   i = i+1;
   if(FA*FP>0)
     a = p;
     FA = FP;
   else
     b = p;
   endif
endwhile
printf("O método não convergiu em %d iterações\n",N);
endfunction

function z = f(x)
z = 2*x*cos(2*x) - (x + 1)^2;
endfunction

main(argv);
