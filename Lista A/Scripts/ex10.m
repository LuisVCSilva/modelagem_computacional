#!/usr/bin/env octave

#{
10. Escreva o código em Octave para aproximar a integral S|0, 0.45| dx usando a
fórmula de Newton-Cotes aberta para n=3. Imprima também o erro absoluto ao
realizar a aproximação.
#}

#{
Entrada:
N/A

Saída:
S|0, 0.45|  2/((x^2)-4) = -0.228839
Erro absoluto: 0.000078
#}
1;

function [Ex10] = main(argv)
a = 0;
b = 0.45;
n = 3;
h = (b - a) / (n*3);
hh = h * 2;
x = a + h;
s = 0;
for i=1:n
    s = s + f(x);
    x = x + h;
    s = s + f(x);
    x = x + hh;
endfor;
s = s * h*1.5;
printf("S|0, 0.45|  2/((x^2)-4) = %f\n",s);
printf("Erro absoluto: %f\n",abs(s-(-0.228917)));
endfunction


function z = f(x)
z = 2/((x^2)-4);
endfunction

main(argv);
