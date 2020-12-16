#!/usr/bin/env octave

function [ex11] = main(argv)
%y'' = 4(y-x)
%y'' = 4y'-4x+0

f = inline('4*z-4','x','y','z');
limSup = 0;
limInf = 1;
_alfa = 0;
_beta = 2;
n = 2;%4 para 0.25 2 para 0.5 e assim por diante
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
        deriv = abs(w(i) - nova);
        if deriv > deriv_max 
            deriv_max = deriv;
        end;
        w(i-1) = nova_1;
        nova_1 = nova;
    end;
    w(n) = nova_1;
endwhile
printf("I W1\n");
for i=1:n
printf("%d %f\n",i,w(i));
endfor

endfunction

main(argv);