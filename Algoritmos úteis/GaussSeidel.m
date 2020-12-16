#!/usr/bin/env octave

1;

function [GaussSeidel] = main(argv)
A = [10, -1, 2, 0; -1,11,-1,3; 2,-1,10,-1;0,3,-1,8];
b = [6,25,-11,15];
es = 10^-5;
maxit = 9999;

[m,n] = size(A);
if m!=n, error('Matrix A must be square'); endif
C = A;
for i = 1:n
    C(i,i) = 0;
    x(i) = 0;
endfor
x = x';
for i = 1:n
    C(i,1:n) = C(i,1:n)/A(i,i);
endfor
for i = 1:n
    d(i) = b(i)/A(i,i);
endfor

iter = 0;
while (1)
  xold = x;
  for i = 1:n
    x(i) = d(i)-C(i,:)*x;
    if x(i) ~= 0
      ea(i) = abs((x(i) - xold(i))/x(i)) * 100;
    endif
  endfor
  iter = iter+1;
  if max(ea)<=es || iter >= maxit
     break;
  endif
endwhile
disp(x);
endfunction

main(argv);