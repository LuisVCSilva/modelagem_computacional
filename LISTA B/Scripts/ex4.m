#!/usr/bin/env octave

function [ex4] = main (argv)
      f1= @(x1,x2,x3) 3*x1-cos(x2*x3)-0.5
      f2= @(x1,x2,x3) x1^2 - 625*x2^2 - 0.25
      f3= @(x1,x2,x3) exp(-x1*x2)+20*x3+((10*pi-3)/3)
      %combina todas as eqs em uma so
      f= @(raizes) [f1(raizes(1),raizes(2),raizes(3));
                    f2(raizes(1),raizes(2),raizes(3));
                    f3(raizes(1),raizes(2),raizes(3))];

      %jacobiana, 
      jacobiana=@(x,y,z) ...
            [3 0 0;
             0 0 0;
             0 0 20];
             
      %criando derivada de f a partir da jacobiana
      fl= @(raizes) jacobiana(raizes(1),raizes(2),raizes(3));

      palpite=[1 1 -1]';
      disp(f);
      raizes = newton(f, fl, palpite, 10^-5, 100);

      x1 = raizes(1);
      x2 = raizes(2);
      x3 = raizes(3);
      disp('As raízes são (x1,x2,x3):');
      disp([x1,x2,x3]);
      endfunction
      
function x = newton(f, fl, palpite, tol, max_it)
x = palpite;
for i=1 : max_it
   a = feval(f,x);
   dfdx=jacobi_num(f,palpite);
   x_anterior = x;
   _inv = inv(dfdx);
   k = 0;
   x = x-_inv*a;
   if ( norm(x-x_anterior) <= tol || norm(a) <= tol )
      break;
   endif
endfor
endfunction

function g=jacobi_num(f,x);
fx=feval(f,x); 
n=size(fx,1);
d=size(x,1);
%passo do gradiente
h=0.001;
xh=x+h;
h=xh-x;
xx=x(:,ones(d,1));
xx(d*(0:(d-1))+(1:d))=xh;
g=zeros(n,d);
for i=1:d
  g(:,i)=feval(f,xx(:,i));
endfor 
temp=h';
g=(g-fx(:,ones(d,1)))./temp(ones(n,1),:);
endfunction