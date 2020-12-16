#!/usr/bin/env octave

#{
5) Determine os valores de α para que a matriz A seja singular.
#}

#{
Matriz de coeficientes precisa ser quadrada.
#}
1;
%warning('off','all');

function [ex9] = main(argv)
A = [4, 1, -1, 0, 7;1, 3, -1, 0, 8;-1, -1, 5, 2, -4;0, 0, 2, 4, 6];%Sistema original não pode ser decomposto na forma LDL porque a matriz não é positiva definida e não é simétrica (matriz hermitiana)
%A = [2, -1, 0;-1, 3, -1;0, -1,4]
n = size(A);
S = A;

for i=1:n,
  for j=i+1:n,
    S(j,j:n) = S(j,j:n) - S(i,j:n)*S(i,j)/S(i,i);
  end
  S(i,i:n) = S(i,i:n)/sqrt(S(i,i));
end

S = triu(S)';
disp(S);
endfunction

main(argv);