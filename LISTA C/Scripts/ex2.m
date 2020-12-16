#!/usr/bin/env octave

#{
Dado o sistema linear abaixo faça o que se pede:

1  -1  L
-1  2 -L
L   1  1

-2
3
2

#}

#{
Exemplos:

SPD ./ex2.m "[2 ,0, 0, 0;1 ,1.5,0,0;0,-3, 0.5,0;2,-2,1,1]" "[3,4.5,-6.6,0.8]"
SPI ./ex2.m "[1,1,0,1;2,1,-1,1;4,-1,-2,2;3,-1,-1,2]" "[2,1,0,-3]"
SI  ./ex2.m "[1, -1, 2; 4, 4, -2; -2,2,-4]" "[-3,1,6]"


./ex2.m

L = -1 -> SPI 
     0 -> SPD
     1 -> SI

#}
1;
warning('off','all');

function x = GaussJordanSubstInv (A,b)
[n_linha n_coluna] = size(A);
if(n_linha!=n_coluna)
   %disp('Matriz A não é quadrada');
endif
nb = length( b );
if( n_linha != nb )
   %disp('Qtde de linhas da matriz de coeficientes é diferente da qtde de linhas da matriz ampliada')
endif
x = zeros( 1, n_linha );

for i = 1 : n_linha - 1
    if( A(i,i) == 0 )%checa propriedades e permuta linhas se necessario
	   t =  min( find( A(i+1:n_linha,i) != 0 ) + i );
	   if( isempty(t) ) 
	      %disp( 'Erro - Matriz nao possui inversa(singular)');
	   endif
	   temp = A(i,:);     tb = b(i);
	   A(i,:) = A(t,:);   b(i) = b(t);
	   A(t,:) = temp;     b(t) = tb;
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
    x(i) = (b(i) - sum( x(i+1:n_linha) .* A(i, i+1:n_linha) )) / A(i,i);
   endfor
endfunction

function _flag = AvaliaFactibilidadeDoSistema (A,b)
x = GaussJordanSubstInv(A, b);
if !all(x == x(1)) && !isnan(x(1))
_flag = 0; %SPD
else
   if isnan(x)
   _flag = 1; %SPI
   else
   _flag = 2; %SI
   endif
endif   
endfunction

function [ex2] = main(argv)
b = [-2,3,2];
h = 0.01; 
for k=-10:h:10
 L = k;
 A = [1,-1, L; -1, 2, -L; L, 1, 1];
 
 %printf("Para L=%f, temos:\n",L);
 %disp([A,b']);
 _flag = AvaliaFactibilidadeDoSistema(A,b);
 if _flag==0
  printf("\nPara L=%f, temos: SPD\n\n",k);
 elseif _flag==1
  printf("\nPara L=%f, temos: SPI\n\n",k);
 else
  printf("\nPara L=%f, temos: SI\n\n",k);
 endif
 %disp("--");
endfor

endfunction

main(argv);