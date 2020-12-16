#!/usr/bin/env octave

#{
1. Escreva o código em Octave para o método de Eliminação de Gauss com substituição inversa
e, a partir dele, determine a solução dos seguintes sistemas. O programa deverá imprimir se foi
preciso realizar permutação entre linhas.
#}

#{
Exemplos:
A)
./GaussJordan.m "[2 ,0, 0, 0;1 ,1.5,0,0;0,-3, 0.5,0;2,-2,1,1]" "[3,4.5,-6.6,0.8]"

B)
./GaussJordan.m "[1,1,0,1;2,1,-1,1;4,-1,-2,2;3,-1,-1,2]" "[2,1,0,-3]"
#}
1;

warning('off','all');
function [GaussJordan] = main(argv)
A = eval(cell2mat(argv(1)))
b = eval(cell2mat(argv(2)))

[n_linha n_coluna] = size(A);
if(n_linha!=n_coluna)
   disp('Matriz A não é quadrada');
   return;
endif
nb = length( b );
if( n_linha != nb )
   disp('Qtde de linhas da matriz de coeficientes é diferente da qtde de linhas da matriz ampliada')
   return;
endif
x = zeros( 1, n_linha );

for i = 1 : n_linha - 1
    if( A(i,i) == 0 )%checa propriedades e permuta linhas se necessario
	   t =  min( find( A(i+1:n_linha,i) != 0 ) + i );
	   if( isempty(t) ) 
	      disp( 'Erro - Matriz nao possui inversa(singular)');
		  return;
	   endif
	   temp = A(i,:);     tb = b(i);
	   A(i,:) = A(t,:);   b(i) = b(t);
	   A(t,:) = temp;     b(t) = tb;
	   printf("Permutação de linha efetuada\n");
    endif
    for j = i+1 : n_linha%escalona
	    m = -A(j,i) / A(i,i);
		A(j,i) = 0;
		A(j, i+1:n_linha) = A(j, i+1:n_linha) + m * A(i, i+1:n_linha);
		b(j) = b(j) + m * b(i);
    endfor
endfor
x(n_linha) = b(n_linha) / A(n_linha, n_linha);
for i = n_linha - 1 : -1 : 1%substitui
    if(A(i,i))==0
    x(i) = "NaN"
    else
    x(i) =( b(i) - sum( x(i+1:n_linha) .* A(i, i+1:n_linha) ) ) / A(i,i);
    endif
endfor

printf("Resolução do sistema:\n")
for i=1:n_linha
    printf("x_%d = %.2f\n",i,x(i));
endfor

endfunction

main(argv);