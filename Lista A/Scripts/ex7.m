#!/usr/bin/env octave

#{
7. Escreva o código em Octave para imprimir o polinômio interpolador P_3 (x) com
os coeficientes obtidos a partir da fórmula de Diferenças Divididas para
aproximar f(x) sabendo que:
f(8.1) = 16.94410
f(8.3) = 17.56492
f(8.6) = 18.50515
f(8.7) = 18.82091

Imprima o valor de P_3 (8.5) também.
#}

#{
Entrada:
N/A

Saída:
f(x) = -0.002083*x^3+0.112083*x^2+1.686204*x^1+-2.960772*x^0+0
f(8.100000) = 16.944100
#}
1;

function [Ex7] = main(argv)
  x = [8.1,8.3,8.6,8.7];
  y = [16.94410,17.56492,18.50515,18.82091];
  xbuscado = 8.5;
  yinterpolado = 0.0;
  n = length(x);
  D = zeros(n,n);
  D(:,1) = y';
  for j=2:n
    for k=j:n
        D(k,j) = (D(k,j-1)-D(k-1,j-1))/(x(k)-x(k-j+1));
    endfor
  endfor
  C = D(n,n);
  for k=(n-1):-1:1,
    C = conv(C,poly(x(k)));
    printf("Tabela de coeficientes na iteração k=%d:\n",k);
    disp(C);
    printf("--------------------------------------------");
    m = length(C);
    C(m) = C(m) + D(k,k);
  endfor
  printf("f(x) = ");
  for k=1:n
    printf("%f*x^%d+",C(k),n-k);
    yinterpolado = yinterpolado+(C(k)*xbuscado^(n-k));
  endfor
  printf("0\n");
  printf("f(%f) = %f\n",xbuscado,yinterpolado);
  disp(C);
endfunction

main(argv);
