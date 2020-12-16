function Eqeliptica(a,b,c,d,h,k,TOL, N)
%Código para resolver Equações Diferenciais Parciais na Forma elíptica, sendo k  espaçamento vercial e horizontal, TOL a tolerância máxima e N o número máximo de iterações. a,b pontos horizontais e c,d pontos verticais. h e k já são os valores depois de dividir (a-b)/n e (d-c)/m.

global aa;% isso aqui é para a função g(x,y) já atualizar os valores para qualquer caso
global bb; 
global cc;
global dd; 

aa = a;
bb = b;
cc = c;
dd = d;

n  = (b-a)/h;
m =  (d-c)/k;
for i=1:n-1
    x(i) = a +i*h;
endfor

for j= 1:m-1
    y(j) = c+ j*k;
endfor
w = zeros(n-1,m-1); %Cria matriz de zeros substituindo o for do pseudocódigo
lamb = (h/k)^2; %lamb = lâmbida
mi = 2*(1+lamb);
l = 1;
while (l <= N)
    z = (-h*h*f(x(1), y(m-1)) + g(a,y(m-1)) + lamb*g(x(1), d) + lamb*w(1,m-2) + w(2,m-1))/mi;
    NORM = abs(z - w(1, m-1));
    w(1, m-1) = z;
    
    for i= 2:n-2
    z = (-h*h*f(x(i), y(m-1)) +  lamb*g(x(i), d) + w(i-1,m-1) + w(i+1, m-1) + lamb*w(i,m-2))/mi;
    NORM = max(NORM, abs(z - w(i, m-1))); %compara os valores anterior e atual e pega o máximo
    w(i, m-1) = z;
    endfor
    
    z = (-h*h*f(x(n-1), y(m-1)) +  g(b, y(m-1)) + lamb*g(x(n-1), d) + w(n-2,m-1) +  lamb*w(n-1,m-2))/mi;
    NORM = max(NORM, abs(z - w(n-1, m-1)));
    w(n-1, m-1) = z;
    
    for j=m-2:-1:2 %decrementando de -1
    z = (-h*h*f(x(1), y(j)) + g(a,y(j)) + lamb*w(1,j+1) + lamb*w(1,j-1) + w(2,j))/mi;
    NORM = abs(z - w(1, j));
    w(1, j) = z;
    
    for i= 2:n-2
    z = (-h*h*f(x(i), y(j)) +  w(i-1,j) + lamb*w(i,j+1) + w(i+1, j) + lamb*w(i,j-1))/mi;
    NORM = max(NORM, abs(z - w(i, j)));
    w(i, j) = z;
    endfor
    
     z = (-h*h*f(x(n-1), y(j)) +  g(b, y(j)) + w(n-2,j) +  lamb*w(n-1,j+1)+ lamb*w(n-1,j-1))/mi;
    NORM = max(NORM, abs(z - w(n-1, j)));
    w(n-1, j) = z;
    endfor
    
    z = (-h*h*f(x(1), y(1)) + g(a,y(1)) + lamb*g(x(1), c) + lamb*w(1,2) + w(2,1))/mi;
    NORM = abs(z - w(1,1));
    w(1, 1) = z;
    
    for i= 2:n-2
    z = (-h*h*f(x(i), y(1)) +  lamb*g(x(i), c) + w(i-1,1) + lamb*w(i,2)+ w(i+1,1))/mi;
    NORM = max(NORM, abs(z - w(i, 1)));
    w(i, 1) = z;
    endfor
    
    z = (-h*h*f(x(n-1), y(1)) +  g(b, y(1)) + lamb*g(x(n-1), c) + w(n-2,1) +  lamb*w(n-1,2))/mi;
    NORM = max(NORM, abs(z - w(n-1, 1)));
    w(n-1, 1) = z;
    
    if NORM <= TOL 
        for i= 1:n-1
            for j = 1:m-1
            printf("\n (%.3f,%.3f): %f", x(i), y(j), w(i,j));
            endfor
        endfor
    return;
    endif
    l = l +1;
endwhile
printf("\nNumero maximo de iteracoes");
endfunction

function z= f(x,y) %é o f(x,y) da força externa
z = 0;
endfunction

function z = g(x,y) %como o g(x,y) foi utilizado como uma só função deve fazer vários if's para definir de qual contorno está se tratando o g(x,y)
global aa;
global bb; 
global cc;
global dd;
    if x== aa
        z = 0;
    elseif y== cc
        z = 0;
    elseif x == bb
        z = 200*y;
    elseif y == dd
        z = 200*x;
    endif
endfunction











