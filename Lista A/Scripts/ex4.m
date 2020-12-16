#!/usr/bin/env octave

#{
4. Resolve o problema adiante usando o código para o método de Newton com precisão de 10^-5.
Encontre dois números tais que a soma resulte em 20. Além disso, se cada número é adicionado a
sua raiz quadrada, o produto das duas somas é 155,55
#}

#{
Entrada 1:
  a     |   tol   |   N
---------------------------
6          10^-5     100

Saída:
Se:
a+b=20
(a+sqrt(a))*(b+sqrt(b))=155.55

Logo...
a = 13.487156
b = 6.512844
#}
1;

function [Ex4] = main(argv)
p0 = str2num(argv{1});
TOL = str2num(argv{2});
N = str2num(argv{3});
i = 1;
while(i <= N)
    p = p0 - f(p0)/fl(p0);
    a=p;
    b=20-a;
    if( abs(p-p0) < TOL)
        printf("Se:\na+b=20\n");
        printf("(a+sqrt(a))*(b+sqrt(b))=155.55\n\nLogo...\n");
        printf("a = %f\n", a);
        printf("b = %f\n", b);
        printf("\n\nO metodo convergiu em %d iteracoes\n\n",i);
        exit();
    endif
    i = i+1;
    p0 = p;
endwhile
printf("\nO metodo nao convergiu em %d iteracoes \n", N);
endfunction

function z = f(x)
z = ((20-x)+sqrt(20-x))*(x+sqrt(x))-155.55;
endfunction

function zl = fl(y)
zl = (y+sqrt(y))*(-1/(2*sqrt(20-y)-1))+(1/(2*sqrt(y))+1)*((20-y)+sqrt(20-y));
endfunction

main(argv);
