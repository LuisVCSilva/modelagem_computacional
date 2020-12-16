#!/usr/bin/env octave

function [ex4] = main(argv)
  f = inline('cos(x)*sin(2*pi*x)','x','y');
  g = inline('cos(2*pi*x)','x');
  l = 1;   
  T = 1; 
  alfa = sqrt(2);
  h = 0.05; 
  k = 0.01;%precisa alterar o k para 0.01 devido a instabilidade do método, p. 669 numerical analysis burden
  

       m = l/h;
       if (m<2)
       printf("M deve ser > =  2.\n");
       return;
       endif
       N = T/k;
       if (N<2)
       printf("N deve ser > =  2.\n");
       return;
       endif  
    lambda = (k*alfa)/h;


  for j = 1:N+1
        w(1,j) = 0.5;
        w(m+1,j) = 1.8;
  endfor

    w(1,1) = f(0);
    w(m+1,1) = f(l);
    

  for i = 2:m 
      w(i,1) = f((i-1)*h);
      w(i,2) = (1-lambda^2) * f((i-1)*h) + ((lambda^2)/2) * (f((i)*h) + f((i-2)*h)) + k*g((i-1)*h);
  endfor


  for j = 2:N
    for i = 2:m
      w(i,j+1) = 2*(1-lambda^2) * w(i,j) + (lambda^2) *(w(i+1,j) + w(i-1,j)) - w(i,j-1);
    endfor
  endfor
  

  printf("(i,j)\tt\t\t\tx\t\t\tw\n");
  for j = 0:N
      t = j*k;
      for i = 0:m  
          x = i*h;
          printf("(%d,%d)\t%f\t\t%f\t\t%f\n", i, j, t, x, w(i+1,j+1));
      endfor  
  endfor
endfunction