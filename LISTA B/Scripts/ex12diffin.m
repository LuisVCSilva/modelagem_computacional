#!/usr/bin/env octave

function [ex12diffin] = main(argv)
%y'' = x^(-1)*y'   +   3*x^(-2)*y   +x^(-1)*log(x)-1 		1<=x<=2 	y(1)=y(2)=0
%P = x^(-1) 	Q = 3*x^(-2)	R = x^(-1)*log(x)-1
f = inline('1/x-(6/x^3)+x^(-1)*log(x)-1','x','y','z');
limSup = 2;
limInf = 1;
_alfa = 0;
_beta = 0;
n = 10;%4 para 0.25 2 para 0.5 e assim por diante
h = (limInf - limSup) / n;
rou = h * h * 10; 
c1 = 0.5 / (1 + rou);
c2 = rou / (1 + rou);
c3 = -h * h * 0.5 / (1 + rou);
c4 = 0.5 / h;

x = linspace(limSup,limInf,n+1);
w = linspace(_alfa,_beta,n+1);

tol = 10^-5;
deriv_max = tol + 1;
while deriv_max > tol
    deriv_max = 0;
    nova_1 = w(1);
    for i = 2 : n
        nova = c1 * (w(i-1) + w(i+1)) + c2 * w(i) + c3 * f(x(i), w(i), (w(i+1) - w(i-1)) * c4);
        diff = abs(w(i) - nova);
        if diff > deriv_max 
            deriv_max = diff;
        end;
        w(i-1) = nova_1;
        nova_1 = nova;
    end;
    w(n) = nova_1;
endwhile
printf("I W1\n");
for i=1:n
printf("%f %f\n",i/n+limInf,w(i));
endfor

endfunction

main(argv);