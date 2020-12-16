#!/usr/bin/env octave

#{
8. Estenda o código da questão 7 para imprimir o polinômio interpolador P_4 (x) sabendo que f(-0.1)= 5.3, f(0) = 2.0, f(0.2) = 3.19, f(0.3) = 1.0 e f(0.35) = 0.97260.
#}

#{
Entrada:
N/A

Saída:
f(x) = (2730.243386*x^4)+(-1648.764021*x^3)+(212.802434*x^2)+(7.498127*x^1)+(2.000000*x^0)+0
#}
1;

function [Ex8] = main(argv)
  x = [-0.1,0.0,0.2,0.3,0.35];
  y = [5.3,2.0,3.19,1.0,0.97260];
  %xint = 0.2;
  %yint = 0.0;
  n = length(x);
  Q = zeros(n,n);
  Q(:,1) = y';
  for j=2:n
    for k=j:n
        Q(k,j) = (Q(k,j-1)-Q(k-1,j-1))/(x(k)-x(k-j+1));
    endfor
  endfor
  C = Q(n,n);
  for k=(n-1):-1:1,
    C = conv(C,poly(x(k)));
    m = length(C);
    C(m) = C(m) + Q(k,k);
  endfor
  printf("f(x) = ");
  for k=1:n
    printf("(%f*x^%d)+",C(k),n-k);
    %yint = yint+(C(k)*xint^(n-k));
  endfor
  printf("0\n");
  %printf("f(%f) = %f\n",xint,yint);
endfunction

main(argv);
