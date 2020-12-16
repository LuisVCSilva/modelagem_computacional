#!/usr/bin/env octave

#{
1. Escreva o código em Octave para o método da Bisseção e, a partir dele, determine a raiz da
função f(x) = x^3 + 4x^2 − 10 no intervalo [0, 3] com precisão de 10^-7 . Imprima também o
número de iterações necessárias para alcançar o resultado dentro da precisão indicada.
#}

#{
#}
1;

function [Ex1] = main(argv)
a = str2num(argv{1});# a = 0
b = str2num(argv{2});# b = 3
tolerancia = str2num(argv{3});# 10^-7
N = str2num(argv{4});# N>=25

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
z = x^3 + 4*x^2 - 10;
endfunction

main(argv);
