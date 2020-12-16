#!/usr/bin/env octave

function [Q4] = main(argv)
a = 1;
b = 2;
h = 0.01;
N = (b - a) / h;

alpha1 = 2;
alpha2 = 8;
alpha3 = 6;

printf("Buscando solução através do Método Preditor Corretor de Adams:\n")
tt = a;
S1(1) = funcao1Exata(tt);
S2(1) = funcao2Exata(tt);
S3(1) = funcao3Exata(tt);

for i = 1:N
tt = a + i * h;
S1(i + 1) = funcao1Exata(tt);
S2(i + 1) = funcao2Exata(tt);
S3(i + 1) = funcao3Exata(tt);
endfor

t(1) = a;
w1 = alpha1;
w2 = alpha2;
w3 = alpha3;

T(1) = t;
W1(1) = w1;
W2(1) = w2;
W3(1) = w3;

for i = 1:3
k11 = h * f1(t, w1, w2, w3);
k12 = h * f2(t, w1, w2, w3);
k13 = h * f3(t, w1, w2, w3);

k21 = h * f1(t + h / 2.0, w1 + (k11 / 2.0), w2 + (k12 / 2.0), w3 + (k13 / 2.0));
k22 = h * f2(t + h / 2.0, w1 + (k11 / 2.0), w2 + (k12 / 2.0), w3 + (k13 / 2.0));
k23 = h * f3(t + h / 2.0, w1 + (k11 / 2.0), w2 + (k12 / 2.0), w3 + (k13 / 2.0));

k31 = h * f1(t + h / 2.0, w1 + (k21 / 2.0), w2 + (k22 / 2.0), w3 + (k23 / 2.0));
k32 = h * f2(t + h / 2.0, w1 + (k21 / 2.0), w2 + (k22 / 2.0), w3 + (k23 / 2.0));
k33 = h * f3(t + h / 2.0, w1 + (k21 / 2.0), w2 + (k22 / 2.0), w3 + (k23 / 2.0));

k41 = h * f1(t + h, w1 + k31, w2 + k32, w3 + k33);
k42 = h * f2(t + h, w1 + k31, w2 + k32, w3 + k33);
k43 = h * f3(t + h, w1 + k31, w2 + k32, w3 + k33);

w1 = w1 + (k11 + 2 * k21 + 2 * k31 + k41) / 6.0;
w2 = w2 + (k12 + 2 * k22 + 2 * k32 + k42) / 6.0;
w3 = w3 + (k13 + 2 * k23 + 2 * k33 + k43) / 6.0;

t = a + i * h;

T(i + 1) = t;
W1(i + 1) = w1;
W2(i + 1) = w2;
W3(i + 1) = w3;
endfor

i = 4;
disp(["t\tw_1\t\terro(w_1-s_1)\tw_2\t\terro(w_2-s_2)\tw3\t\terro(w_3-s_3)"]);
while (T(i) < b)
T(i + 1) = a + i * h;
%passo da predicao
W1(i + 1) = W1(i) + (h / 24.0) * (55 * f1(T(i), W1(i), W2(i), W3(i)) - 59 * f1(T(i - 1), W1(i - 1), W2(i - 1), W3(i - 1)) + 37 * f1(T(i - 2), W1(i - 2), W2(i - 2), W3(i - 2)) - 9 * f1(T(i - 3), W1(i - 3), W2(i - 3), W3(i - 3)));
W2(i + 1) = W2(i) + (h / 24.0) * (55 * f2(T(i), W1(i), W2(i), W3(i)) - 59 * f2(T(i - 1), W1(i - 1), W2(i - 1), W3(i - 1)) + 37 * f2(T(i - 2), W1(i - 2), W2(i - 2), W3(i - 2)) - 9 * f2(T(i - 3), W1(i - 3), W2(i - 3), W3(i - 3)));
W3(i + 1) = W3(i) + (h / 24.0) * (55 * f3(T(i), W1(i), W2(i), W3(i)) - 59 * f3(T(i - 1), W1(i - 1), W2(i - 1), W3(i - 1)) + 37 * f3(T(i - 2), W1(i - 2), W2(i - 2), W3(i - 2)) - 9 * f3(T(i - 3), W1(i - 3), W2(i - 3), W3(i - 3)));
%passo da correcao
W1(i + 1) = W1(i) + (h / 24.0) * (9 * f1(T(i + 1), W1(i + 1), W2(i + 1), W3(i + 1)) + 19 * f1(T(i), W1(i), W2(i), W3(i)) - 5 * f1(T(i - 1), W1(i - 1), W2(i - 1), W3(i - 1)) + f1(T(i - 2), W1(i - 2), W2(i - 2), W3(i - 2)));
W2(i + 1) = W2(i) + (h / 24.0) * (9 * f2(T(i + 1), W1(i + 1), W2(i + 1), W3(i + 1)) + 19 * f2(T(i), W1(i), W2(i), W3(i)) - 5 * f2(T(i - 1), W1(i - 1), W2(i - 1), W3(i - 1)) + f2(T(i - 2), W1(i - 2), W2(i - 2), W3(i - 2)));
W3(i + 1) = W3(i) + (h / 24.0) * (9 * f3(T(i + 1), W1(i + 1), W2(i + 1), W3(i + 1)) + 19 * f3(T(i), W1(i), W2(i), W3(i)) - 5 * f3(T(i - 1), W1(i - 1), W2(i - 1), W3(i - 1)) + f3(T(i - 2), W1(i - 2), W2(i - 2), W3(i - 2)));
i++;
endwhile

erro1 = abs (W1 - S1);
erro2 = abs (W2 - S2);
erro3 = abs (W3 - S3);

for i = 1:N + 1
printf("%.2f\t%f\t%f\t%f\t%f\t%f\t%f\n",T(i),W1(i),erro1(i),W2(i),erro2(i),W3(i),erro3(i));
endfor

figure;
hold on;
plot (T, W1);
plot (T, W2);
plot (T, W3);

% Método Runge - Kutta de Quarta Ordem
%Passo 1

N = floor((b - a) / h);
t = a;
w1 = alpha1;
w2 = alpha2;
w3 = alpha3;

T(1) = t;
W1(1) = w1;
W2(1) = w2;
W3(1) = w3;
S1(1) = funcao1Exata(t);
S2(1) = funcao2Exata(t);
S3(1) = funcao3Exata(t);


printf("\nBuscando solução através do Método de Runge-Kutta Quarta Ordem:\n");

for i = 1:N
k11 = h * f1(t, w1, w2, w3);
k12 = h * f2(t, w1, w2, w3);
k13 = h * f3(t, w1, w2, w3);
k21 = h * f1(t + h / 2.0, w1 + (k11 / 2.0), w2 + (k12 / 2.0), w3 + (k13 / 2.0));
k22 = h * f2(t + h / 2.0, w1 + (k11 / 2.0), w2 + (k12 / 2.0), w3 + (k13 / 2.0));
k23 = h * f3(t + h / 2.0, w1 + (k11 / 2.0), w2 + (k12 / 2.0), w3 + (k13 / 2.0));
k31 = h * f1(t + h / 2.0, w1 + (k21 / 2.0), w2 + (k22 / 2.0), w3 + (k23 / 2.0));
k32 = h * f2(t + h / 2.0, w1 + (k21 / 2.0), w2 + (k22 / 2.0), w3 + (k23 / 2.0));
k33 = h * f3(t + h / 2.0, w1 + (k21 / 2.0), w2 + (k22 / 2.0), w3 + (k23 / 2.0));
k41 = h * f1(t + h, w1 + k31, w2 + k32, w3 + k33);
k42 = h * f2(t + h, w1 + k31, w2 + k32, w3 + k33);
k43 = h * f3(t + h, w1 + k31, w2 + k32, w3 + k33);
w1 = w1 + (k11 + 2 * k21 + 2 * k31 + k41) / 6.0;
w2 = w2 + (k12 + 2 * k22 + 2 * k32 + k42) / 6.0;
w3 = w3 + (k13 + 2 * k23 + 2 * k33 + k43) / 6.0;
t = a + i * h;
T(i + 1) = t;
W1(i + 1) = w1;
W2(i + 1) = w2;
W3(i + 1) = w3;
S1(i + 1) = funcao1Exata(t);
S2(i + 1) = funcao2Exata(t);
S3(i + 1) = funcao3Exata(t);
endfor

erro1 = abs (W1 - S1);
erro2 = abs (W2 - S2);
erro3 = abs (W3 - S3);

disp(["t\tw_1\t\terro(w_1-s_1)\tw_2\t\terro(w_2-s_2)\tw3\t\terro(w_3-s_3)"]);
for i = 1:N + 1
printf("%.2f\t%f\t%f\t%f\t%f\t%f\t%f\n",T(i),W1(i),erro1(i),W2(i),erro2(i),W3(i),erro3(i))
endfor

figure;
hold on;
plot (T, W1);
plot (T, W2);
plot (T, W3);

endfunction

function z = funcao1Exata(t)
z = (2 * t) - (t^(- 1)) + (t^2) + (t^3) - 1;
endfunction

function z = funcao2Exata(t)
z = (3 * t^(2)) + (t^(- 2)) + (2 * t) + 2;
endfunction

function z = funcao3Exata(t)
z = ((- 2) * t^(- 3)) + (6 * t) + 2;
endfunction

function z = f1(t, u1, u2, u3)
z = u2;
endfunction

function z = f2(t, u1, u2, u3)
z = u3;
endfunction

function z = f3(t, u1, u2, u3)
z = ((8 * t^(2)) - 2 - 2 * u1 + 2 * t * u2 - t^(2) * u3) / (t^3);
endfunction

main(argv);
