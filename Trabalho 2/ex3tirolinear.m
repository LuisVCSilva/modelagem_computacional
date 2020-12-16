#!/usr/bin/env octave

function [ex1tirolinear] = main(argv)
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
   N = (B-A)/h;
   k = 0;

   u(1,1) = alfa;
   u(2,1) = 0;
   v(1,1) = 0;
   v(2,1) = 1;

   for i=1:N
   if i==1
      x = A;
   else
      x = A + (i-1)*h;
   endif
   k11 = h*u(2,i);
   k12 = h*(p(x)*u(2,i) + q(x)*u(1,i) + r(x));
   k21 = h*(u(2,i) + 0.5*k12);
   k22 = h*(p(x+0.5*h)*(u(2,i)+0.5*k12) + (q(x+0.5*h)*(u(1,i)+0.5*k11)) + r(x+0.5*h));
   k31 = h*(u(2,i) + 0.5*k22);
   k32 = h*(p(x+0.5*h)*(u(2,i)+0.5*k22) + (q(x+0.5*h)*(u(1,i)+0.5*k21)) + r(x+0.5*h));
   k41 = h*(u(2,i) + k32);
   k42 = h*(p(x+h)*(u(2,i)+k32) + q(x+h)*(u(1,i)+k31) + r(x+h));
   u(1,i+1) = u(1,i) + ((k11 + 2*k21 + 2*k31 + k41)/6);
   u(2,i+1) = u(2,i) + ((k12 + 2*k22 + 2*k32 + k42)/6);
   
   K11 = h*v(2,i);
   K12 = h*(p(x)*v(2,i) + q(x)*v(1,i));
   K21 = h*(v(2,i) + 0.5*K12);
   K22 = h*(p(x+0.5*h)*(v(2,i)+0.5*K12) + (q(x+0.5*h)*(v(1,i)+0.5*K11)));
   K31 = h*(v(2,i) + 0.5*K22);
   K32 = h*(p(x+0.5*h)*(v(2,i)+0.5*K22) + (q(x+0.5*h)*(v(1,i)+0.5*K21)));
   K41 = h*(v(2,i) + K32);
   K42 = h*(p(x+h)*(v(2,i)+K32) + q(x+h)*(v(1,i)+K31));
   v(1,i+1) = v(1,i) + ((K11 + 2*K21 + 2*K31 + K41)/6);
   v(2,i+1) = v(2,i) + ((K12 + 2*K22 + 2*K32 + K42)/6);  
   k++;
   endfor

   w(1,1) = alfa;
   w(2,1) = ((_beta - u(1,N+1))/(v(1,N+1)));    

   printf("\nMétodo do Tiro Linear %d!\n",k);
   printf("i\tx\t\tw\t\tex\t\terro\n");
   for i=1:N+1 
      W1(i) = u(1,i) + w(2,1)*v(1,i);
      W2(i) = u(2,i) + w(2,1)*v(2,i);

      if i==1
         x = A;
      else
         if i==N+1
            x = B;
         else
            x = A + (i-1)*h;
         endif
      endif

   ex(i) = y(x);
   erro(i) = abs(W1(i) - ex(i));
   printf("%d\t%f\t%f\t%f\t%f\n", i, x, W1(i),ex(i),erro(i));
   endfor
endfunction

main(argv);