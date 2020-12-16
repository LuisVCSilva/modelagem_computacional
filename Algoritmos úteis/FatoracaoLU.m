#!/usr/bin/env octave

#{
6) Escreva o código em Octave para o método de Fatoração LU com l ii = 1 para todo i. A partir
dele, determine a fatoração da seguinte matriz.
#}

#{

#}
1;
%warning('off','all');

function [FatoracaoLU] = main(argv)
A = [2.1756, 4.0231, -2.1732, 5.1967; -4.0231, 6.0, 0.0, 1.1973; -1.0, -5.2107, 1.1111, 0.0; 6.0235, 7.0, 0.0, -4.1561];
b = [17.102, -6.1593, 3.004, 0.0000]';
A
tam_A = length(A);
U = A;
L = zeros(tam_A);
pivos = (0:tam_A-1)';
for j=1:tam_A,
    [!,k]=max(abs(U(j:tam_A,j)));
    k=k+(j-1);
    t=pivos(j); pivos(j)=pivos(k); pivos(k)=t;
    t=L(j,1:j-1); 
    L(j,1:j-1)=L(k,1:j-1);
    L(k,1:j-1)=t;
    t=U(j,j:end);
    U(j,j:end)=U(k,j:end);
    U(k,j:end)=t;
    
    L(j,j)=1;
    for i=(1+j):size(U,1)
       c= U(i,j)/U(j,j);
       U(i,j:tam_A)=U(i,j:tam_A)-U(j,j:tam_A)*c;
       L(i,j)=c;
    endfor
endfor
P = zeros(tam_A);
P(pivos(:)*tam_A+(1:tam_A)') = 1;
disp("Matrizes L, U e P:");
L
U
P
endfunction

main(argv);