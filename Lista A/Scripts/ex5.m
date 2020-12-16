#!/usr/bin/env octave

#{
5. Escreva o código em Octave para imprimir o polinômio interpolador de Lagrange de grau 3 para
aproximar f x = cos x − sin (x) com x 0 = 1, x 1 = 0,25, x 2 = 0,5 e x 3 = 1,0.
#}

#{
Entrada:
N/A

Saída:
f(x) = (-0.125000*x^3)+(0.875000*x^2)+(-1.500000*x^1)+(1.000000*x^0)+0
#}
1;

function [Ex5] = main(argv)
  X = [0.0,1.0,2.0,3.0];  % [entrada] os xis conhecidos
  Y = [1.0,0.25,0.5,1.0]; % [entrada] os ipsolons conhecidos
  w=length(X);
  n=w-1;
  L=zeros(w,w);
  for k=1:n+1
     V=1;
     for j=1:n+1
        if k!=j
           V=conv(V,poly(X(j)))/(X(k)-X(j));
        endif
     endfor
     L(k,:)=V;
  endfor
  C=Y*L;
  printf("f(x) = ");
  for k=1:length(C)
    printf("(%f*x^%d)+",C(k),length(C)-k);
  endfor
  printf("0\n");
endfunction

function z = f(x)
z = cos(x) - sin(x);
endfunction

main(argv);
