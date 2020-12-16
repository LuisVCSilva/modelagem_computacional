#!/usr/bin/env octave

#{
A) ./ex4.m "[1,2,0;2,1,-1;3,1,1]" -> -8
B) ./ex4.m "[2 0 1 2;1 1 0 2;2 -1 3 1;3 -1 4 3]" -> 3
#}



function [ex4] = main(argv)
%A = [1,2,0;2,1,-1;3,1,1];
%A = [2 0 1 2;1 1 0 2;2 -1 3 1;3 -1 4 3];
A = eval(cell2mat(argv(1)))
s = determinante(A);
disp(s);
endfunction



function [dt,flops] = determinante(A)
[m,n] = size(A);
if m!=n
    disp("Matriz não é Quadrada");
    return
endif

flops = 0;
n = size(A,1);
if n==1 
   dt = A(1,1);
else
   sinal = 1;
   dt = 0;
   for j = 1:n
      % Computa determinante do determinante
      if j == 1
         [dt1,fl] = determinante(A([2:n],[2:n]));
      elseif j==n
         [dt1,fl] = determinante(A([2:n],[1:n-1]));
      else
         [dt1,fl] = determinante(A([2:n],[1:j-1, j+1:n]));
      endif
      %Cria primeira linha
      dt = dt + sinal*A(1,j)*dt1;
      printf("%f+(%f)*%f*%f = %f\n",dt,sinal,A(1,j),dt1,dt);
      sinal = (-1)*sinal; 
   endfor
endif
endfunction

