#!/usr/bin/env octave

#{
5) Determine os valores de α para que a matriz A seja singular.
#}

#{

#}
1;
warning('off','all');

function [ex5] = main(argv)
L = 0;
h = 0.01;
A = [1,2,-1;1,L,1;2,L,-1];
for i=-10:h:10
L = i;
A = [1,2,-1;1,L,1;2,L,-1];
if isinf(inv(A))
 printf("\nPara L=%f, temos que a matriz abaixo é singular:\n",L);
 disp(A);
endif
endfor
endfunction

main(argv);