#!/usr/bin/env octave

#{
11. Escreva o código em Octave para aproximar a integral S|0,2.5|  e^(2x)*sin(3x) dx usando a regra do
Trapézio Composta com a precisao de 10^-5. Imprima o valor de n, de h, a aproximação encontrada
e o erro absoluto ao realizar a aproximação.
#}

#{
Entrada:
N/A

Saída:
Para n=100000 e h=0.000025 temos:

S|0, 2.5|  e^(2x)*sin(3x) = 9.775950
Erro absoluto: 0.000000
#}
1;

function [Ex11] = main(argv)
a = 0.0;
b = 2.5;
n = 10^5;
h = (b - a) / n;
s = f(a) * 0.5;
x = a + h;
for i = 1 : n-1
    s = s + f(x);
    x = x + h;
endfor;
s = s + f(b) * 0.5;
s = s * h;
printf("Para n=%d e h=%f temos: \n\n",n,h);
printf("S|0, 2.5|  e^(2x)*sin(3x) = %f\n",s);
printf("Erro absoluto: %f\n",abs(s-(9.77595)));
endfunction


function z = f(x)
z = exp(2*x)*sin(3*x);
endfunction

main(argv);
