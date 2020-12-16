#!/usr/bin/env octave

#{
6.
#}


#{
Entrada:
N/A

Saída:
Coeficientes Q da tabela de Neville considerando:

1) f(x) = ln(x)

2) x0 = 2
   x1 = 2.2
   x2 = 2.3

Tabela:
   0.69315   0.90109      -Inf
   0.00000       Inf   0.00000
      -Inf   0.00000   0.00000

#}
1;

function [Ex6] = main(argv)
  x = [0.0,1.0,2.0];
  y = [f(x(1)),f(x(2)),f(x(3))];
  n = length(x);
  xi = [2.0,2.2,2.3];
  for k = 1:length(xi)
     xd = [];
     for i = 1:n
        xd(i) = abs(x(i) - xi(k));
     endfor

     [xds,i] = sort(xd);

     x = x(i);
     y = y(i);

     Q = zeros(n,n);
     Q(:,1) = y(:);

     for i = 1:n-1
        for j = 1:(n-i)
           Q(j,i+1) = ((xi(k)-x(j))*Q(j+1,i) + (x(j+i)-xi(k))*Q(j,i))/(x(j+i)-x(j));
        endfor
     endfor

     yi(k) = Q(1,n);

     D = zeros(n,n);
     D(:,1) = y(:);

     for i = 1:n-1
        D(i,2) = (D(i+1,1)-D(i,1))/(x(i+1)-x(i));
     endfor

     for i = 2:n-1
        for j = 1:(n-i)
           D(j,i+1) = (Q(j+1,i)+(xi(k)-x(j))*D(j+1,i)-Q(j,i)+(x(j+i)-xi(k))*D(j,i))/(x(j+i)-x(j));
        endfor
     endfor

     ypi(k) = D(1,n);
   endfor
   disp("Coeficientes Q da tabela de Neville considerando: \n\n1) f(x) = ln(x)\n\n2) x0 = 2\n   x1 = 2.2\n   x2 = 2.3\n");
   disp("Tabela:");
   disp(Q);

endfunction

function z = f(x)
z = log(x);
endfunction

main(argv);
