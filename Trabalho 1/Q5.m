#!/usr/bin/env octave

function [Q5] = main(argv)
a = 1;
b = 3;
h = 0.25;
condicaoInicial = 1;
alpha = 1;
TOL = 10^-5;
maxIteracoes = 9999;
N = (b-a)/h;
t = a;
w = condicaoInicial;

T(1) = t;
W(1) = w;
S(1) = funcaoExata(t);
erro(1) = abs (W(1) - S(1));

printf("Buscando solução através do Método Trapezoidal Implícito");
disp("\nt\tw\t\ty\t\terro");
printf("%.2f\t%f\t%f\t%f\n",t,w,S(1),erro(1));
for i=1:N
  k1 = w + (h/2)*f(t,w);
  w0 = k1;
  j = 1;
  flag = 0;
    while flag == 0
      w = w0 - ((w0-(h/2)*f(t + h, w0) - k1)/(1-(h/2)*flinha(t + h, w0)));
      if abs(w-w0) < TOL 
        flag = 1;
      else
        j = j +1;
        w0 = w;
      endif
      if j > maxIteracoes
        printf("O numero maximo de iteracoes foi excedido");
        return
      endif
    endwhile
    t=a+i*h;
    T(i+1) = t;
    W(i+1) = w;
    S(i+1) = funcaoExata(t);
    erro(i+1) = abs (W(i+1) - S(i+1));
    printf("%.2f\t%f\t%f\t%f\n",t, w, S(i+1), erro(i+1));
endfor

hold on 
plot (T, W);
plot (T, S);

N=(b-a)/h;
t(1)=a;
w(1)=alpha;
funcaoExata(1)=y(t(1));

printf("\nBuscando solução através do Método de Runge-Kutta de 4th ordem");
disp("\nt\tw\t\ty\t\terro");
printf("%.2f\t%f\t%f\tN/A\n",t(1),w(1),funcaoExata(1));
for i=1:N
    K1=h*f(t(i), w(i));
    K2=h*f(t(i)+h/2, w(i)+K1/2);
    K3=h*f(t(i)+h/2, w(i)+K2/2);
    K4=h*f(t(i)+h,w(i)+K3);
    w(i+1)=w(i)+(K1+2*K2+2*K3+K4)/6;
    t(i+1)=a+i*h;
    funcaoExata(i+1)=y(t(i+1));
    erro(i+1)=abs(w(i+1)-funcaoExata(i+1));
    printf("%.2f\t%f\t%f\t%f\n", t(i+1), w(i+1), funcaoExata(i+1), erro(i+1));
endfor

figure;
hold on;
plot(t,w);
plot(t,funcaoExata);


N=(b-a)/h;
t(1)=a;
w(1)=alpha;
funcaoExata(1)=y(t(1));


printf("\n\nBuscando solução através do Método Preditor Corretor de Adams")
disp("\nt\tw\t\ty\t\terro");
printf("%.2f\t%f\tN/A\t\tN/A\n",t(1),w(1));
for i=1:3
    k1=h*f(t(i), w(i));
    k2=h*f(t(i)+h/2, w(i)+k1/2);
    k3=h*f(t(i)+h/2, w(i)+k2/2);
    k4=h*f(t(i)+h, w(i)+k3);
    w(i+1)=w(i)+(1/6)*(k1+2*k2+2*k3+k4);
    t(i+1)=t(i)+h;
    funcaoExata(i+1)=y(t(i+1));
    erro(i)=abs(w(i)-funcaoExata(i));
    printf("%.2f\t%f\t%f\t%f\n", t(i+1), w(i+1), funcaoExata(i+1), erro(i));
endfor

for i=4:N
    t(i+1)=t(i)+h;
    w(i+1)=w(i)+(h/24)*(55*f(t(i),w(i))-59*f(t(i-1),w(i-1))+37*f(t(i-2),w(i-2))-9*f(t(i-3),w(i-3))); %preditor
    w(i+1)=w(i)+(h/24)*(9*f(t(i+1),w(i+1))+19*f(t(i),w(i))-5*f(t(i-1),w(i-1))+f(t(i-2),w(i-2))); %corretor
    funcaoExata(i+1)=y(t(i+1));
    erro(i)=abs(w(i)-funcaoExata(i));
    printf("%.2f\t%f\t%f\t%f\n", t(i+1), w(i+1), funcaoExata(i+1), erro(i));
endfor

figure;
hold on;
plot(t,w);
plot(t,funcaoExata);
printf("\n");
endfunction 

function r = funcaoExata(t)
  r = -exp(-15*t)+t^(-3);
endfunction

function r = f(t,y) 
  r = -15*(y-t^(-3))-3*t^(-4);  
endfunction

function r = flinha(t,y);
  r = -15;
endfunction

function z=y(t)
z = -exp(-15*t)+t^(-3);
endfunction

main(argv);