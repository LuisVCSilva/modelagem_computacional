#!/usr/bin/env octave

1;

function [estudodecaso] = main()
a = 0;
b = 10;
h = 0.01;
alpha = 0.2;
beta = 0.5;

N = (b-a)/h;
t = a;
u1 = alpha;
u2 = beta;

T(1) = t;
U1(1) = u1;
U2(1) = u2;

printf("\n%f\t%f\t%f", t, u1, u2);

for i=1:N
    k11 = h*f1(t, u1, u2);
    k12 = h*f2(t, u1, u2);
    
    k21 = h*f1(t + h/2, u1 + k11/2, u2 + k12/2);
    k22 = h*f2(t + h/2, u1 + k11/2, u2 + k12/2);
    
    k31 = h*f1(t + h/2, u1 + k21/2, u2 + k22/2);
    k32 = h*f2(t + h/2, u1 + k21/2, u2 + k22/2);
    
    k41 = h*f1(t + h, u1 + k31, u2 + k32);
    k42 = h*f2(t + h, u1 + k31, u2 + k32);
    
    u1 = u1 + (k11 + 2*k21 + 2*k31 + k41)/6;
    u2 = u2 + (k12 + 2*k22 + 2*k32 + k42)/6;
    t = a + i*h;
    
    T(i+1) = t;
    U1(i+1) = u1;
    U2(i+1) = u2;     
    printf("\n%f\t%f\t%f", t, u1, u2);
endfor

figure
hold on
plot(T, U1);
plot(T, U2);
hold on
endfunction

%primeira EDO do sistema
function g = f1(t, u1, u2)
g = u2;
endfunction

%segunda EDO do sistema
function h = f2(t, u1, u2)
h = (F(t) - k(t)*u1 - k1(t)*u1^3)/(m(t));
endfunction

%calculo do m(t)
function z = m(t)
a = 0.5*t;
b = t+1;
n = 100;
h = (b-a)/n;
x0 = fs(a) + fs(b);
x1 = 0;
x2 = 0;

for i=1:n-1
    x = a+i*h;
    if(mod(i, 2) == 0)
        x2 = x2 + fs(x);
    else
        x1 = x1 + fs(x);
    endif
endfor

xi = (h/3)*(x0 + 2*x2 + 4*x1);
z = abs(xi);

endfunction
  
function z = fs(t)
    z = t^2*exp(-t);
endfunction

%calculo do k(t)
function z = k(t)
h = 0.00001;
z = (1/h^2)*(fdev(t+h) - 2*fdev(t) + fdev(t-h));
endfunction

function z = fdev(t)
z = -exp(-t)*(t^2 + 2*t + 2);
endfunction

function z=k1(t)
  z = pint(0.25*t); 
endfunction

%calculo polinomio interpolador
function z = pint(t)

x0 = bissec(-4, -1.5, t);
x1 = bissec(-1.5, 1, t);
x2 = bissec(1, 4, t);
rx0 = t;
rx1 = t+1;
rx2 = t+2;

L0 = ((t - x1)*(t-x2)) / ((x0 -x1)*(x0-x2));
L1 = ((t - x0)*(t-x2)) / ((x1 -x0)*(x1-x2));
L2 = ((t - x0)*(t-x1)) / ((x2 -x0)*(x2-x1));

z = rx0*L0 + rx1*L1 + rx2*L2;
endfunction

%metodo da bissecao
function z = bissec(a, b, t)
FA = fp(a,t);
N = 10000;
TOL = 0.001;
while (i <= N)
    p = a + (b-a)/2;
    FP = fp(p,t);
    if(FP == 0 || abs((b-a)/2) < TOL )
        z = p;
        return;
    endif
   
    if(FA*FP > 0)
        a = p;
        FA = FP;
    else
        b = p;
    endif
endwhile
z = NaN;
endfunction

%calculo de k1(t)
function [x0, x1, x2] = buscalinear(t)
a = -3;
b = 4;
inc = 0.00001;
tol = 0.001;
k = 1; %indice das raizes
rt = zeros(1,3);
ii = a;
while ii <= b
    r = fp(ii, t);
    if(abs(r) <= tol)
        rt(k) = ii;
        k = k + 1;
        ii = ii + 0.5;
    else
        ii = ii + inc;
    endif
    if(k > 3)
        break;
    endif
endwhile
x0 = rt(1);
x1 = rt(2);
x2 = rt(3);

endfunction

function z = fp(x,t)
z = -4*x^3 + 3*x^2 + 25*x + t;
endfunction

%calculo do F(t)
function z = F(t)
  
    a = 0;
    b = pi/4;
    
    n=50;
    m=50;
    
    h = (b-a)/n;
    
    J1 = 0;
    J2 = 0;
    J3 = 0;
    
    for i = 0 : n
        x = a + i*h;
        cx = c(x*t);
        dx = d(x*t);
        flag = 0;
        if(dx < cx)
            aux = dx;
            dx = cx;
            cx = aux;
            flag = 1;
        endif
        HX = (dx - cx)/m;
        if(flag == 0)
            K1 = fint(x,cx) + fint(x,dx);
        else
            K1 = -(fint(x,cx) + fint(x,dx));
        endif
        K2 = 0;
        K3 = 0;
        for j = 1:m-1
            y = cx +j*HX;
            Q = fint(x,y);
            if (mod(i,2) == 0)
                K2 = K2 + Q;
            else
                K3 = K3 + Q;
            endif
        endfor
        L = (K1 +2*K2+ 4*K3)*HX/3.0;
        if (i == 0 || i == n)
            J1 = J1 + L;
        elseif (mod(i,2) == 0)
            j2 = J2 + L;
        else
            J3 = J3 +L;
        endif
    endfor
    
    J = h*(J1+2*J2+4*J3)/3.0;
    z = J;

endfunction

function z = fint(x,y)
    z = (2*y*sin(x) + (cos(x))^2);
endfunction

function C = c(x)
    C = sin(x);
endfunction

function D = d(x)
    D = cos(x);
endfunction

main();
