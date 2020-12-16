#!/usr/bin/env octave

function [ex3diffin] = main(argv)
 printf('Metodo das diferenças finitas\n');

   %inicio da entrada
   p = inline('-4*(x^(1))','x');
   q = inline('2*x^(-2)','x');
   r = inline('-2*x^(-2)*log(x)','x');
   y = inline('4*(x^-1)-2*x^(-2)+log(x)-(3/2)','x');
   A=1;
   B=2;
   alfa=1/2;
   _beta=log(2);
   h = 0.01;
   %fim da entrada
   N = ((B-A)/h);
   
   if N<2
      N=2;
   else
      N = ((B-A)/h);
   endif
   
   a = zeros();
   b = zeros();
   c = zeros();
   d = zeros();
   
   x = A + h;
   a(2) = 2 + (h^2)*q(x);
   b(2) = -1 + (h/2)*p(x);
   d(2) = -(h^2)*r(x) + (1+(h/2)*p(x))*alfa;
   
   for i=3:N-1
      x = A + (i-1)*h;
      a(i) = 2 + (h^2)*q(x);
      b(i) = -1 + (h/2)*p(x);
      c(i) = -1 - (h/2)*p(x); 
      d(i) = -(h^2)*r(x);
   endfor
   
   x = B-h;
   a(N) = 2 + (h^2)*q(x);
   c(N) = -1 - (h/2)*p(x);
   d(N) = -(h^2)*r(x) + (1-(h/2)*p(x))*_beta;
   
   l(2) = a(2);
   u(2) = b(2)/a(2);
   z(2) = d(2)/l(2);
   
   for i=3:N-1
      l(i) = a(i) - (c(i)*u(i-1));
      u(i) = b(i)/l(i);
      z(i) = (d(i) - c(i)*z(i-1))/l(i);
   endfor
   
   l(N) = a(N) - (c(N)*u(N-1));
   z(N) = (d(N) - c(N)*z(N-1))/l(N);
   
   w(1) = alfa;
   w(N+1) = _beta;
   w(N) = z(N);
   
   for i=N-1:-1:2
      w(i) = z(i) - u(i)*w(i+1);
   endfor
   printf("i\tx\t\tw\t\tex\t\terro\n");
   for i=1:N+1
      if i==1
         x = A;
      else
         x = A + (i-1)*h;
      endif
      ex(i) = y(x);
      erro = abs(w(i) - ex(i));
      printf("%d\t%f\t%f\t%f\t%f\n", i, x, w(i),ex(i),erro);
   endfor
endfunction

main(argv);