#!/usr/bin/env octave

#{
10) Determine o(s) valor(es) de α para que a matriz A abaixo seja positiva definida.
Programa verificador da resposta analítica.

./ex10.m | grep "a matriz é pos"
./ex10.m | grep "a matriz não é pos"
-2,1.5
#}

#{

#}
1;
%warning('off','all');

function x=ehPositivaDefinida(A)
    [m,n]=size(A); 
    if m!=n
        disp("A não é simétrica");
        return;
    endif
    

    x=1;
    for i=1:m
        _sub=A(1:i,1:i);
        if(det(_sub)<=0);
            x=0;
            break;
        endif
    endfor
endfunction

function x = _print (L)
 A=[2, L, -1;L, 2, 1;-1, 1, 4];
 x=ehPositivaDefinida(A);
 if x
  printf("Para L = %f, temos que a matriz é positiva definida\n",L);
 else
  printf("Para L = %f, temos que a matriz não é positiva definida\n",L); 
 endif
endfunction

function [verificador_ex10] = main(argv)
h = 0.01;
maxIt = 10
for i=-maxIt:h:maxIt
 L = i;
 _print(L);
endfor
endfunction

main(argv);