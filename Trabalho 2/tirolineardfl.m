function tirolinearedfl()

    clc;
    
    A = 1;
    B = 2;
    alpha = 0.5;
    beta = log(2);
    h = 0.01;
    N = (B-A)/h;
    
    u(1,1) = alpha;
    u(2,1) = 0;
    v(1,1) = 0;
    v(2,1) = 1;   
    
    for i=1:N
        if i==1
            x = A;                       
        else
           x = A + (i-1)*h;
        end
       
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
        
    end   

    w(1,1) = alpha;
    w(2,1) = ((beta - u(1,N+1))/(v(1,N+1)));    

    fprintf("\nMétodo do Tiro Linear!\n");
    
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
            end
        end
        
        ex(i) = y(x);
        
        erro(i) = abs(W1(i) - ex(i));
        
        
        fprintf("\ni=%d,x=%.2f,w(%d)=%.5f,y(x)=%.5f,erro=%.10f", i, x, i, W1(i),ex(i),erro(i));

        
    end
    
    A = 1;
    B = 2;
    alpha = 0.5;
    beta = log(2);
    h = 0.01;
    N = ((B-A)/h);
    
    if N<2
        N=2;
    else
        N = ((B-A)/h);
    end
    
    a = zeros;
    b = zeros;
    c = zeros;
    d = zeros;
    
    x = A + h;
    a(2) = 2 + (h^2)*q(x);
    b(2) = -1 + (h/2)*p(x);
    d(2) = -(h^2)*r(x) + (1+(h/2)*p(x))*alpha;
    
    for i=3:N-1
        
        x = A + (i-1)*h;
        a(i) = 2 + (h^2)*q(x);
        b(i) = -1 + (h/2)*p(x);
        c(i) = -1 - (h/2)*p(x); 
        d(i) = -(h^2)*r(x);
    end
    
    x = B-h;
    a(N) = 2 + (h^2)*q(x);
    c(N) = -1 - (h/2)*p(x);
    d(N) = -(h^2)*r(x) + (1-(h/2)*p(x))*beta;
    
    l(2) = a(2);
    u(2) = b(2)/a(2);
    z(2) = d(2)/l(2);
    
    for i=3:N-1
        
        l(i) = a(i) - (c(i)*u(i-1));
        u(i) = b(i)/l(i);
        z(i) = (d(i) - c(i)*z(i-1))/l(i);                
    end
    
    l(N) = a(N) - (c(N)*u(N-1));
    z(N) = (d(N) - c(N)*z(N-1))/l(N);
    
    w(1) = alpha;
    w(N+1) = beta;
    w(N) = z(N);
    
    for i=N-1:-1:2
        w(i) = z(i) - u(i)*w(i+1);        
    end
    
    fprintf("\n\nMétodo das Diferenças Finitas Linear!\n");
    
    for i=1:N+1
        if i==1
            x = A;                       
        else
            x = A + (i-1)*h;
        end
        ex(i) = y(x);        
        erro = abs(w(i) - ex(i));
        fprintf("\ni=%d,x=%.2f,w(%d)=%.5f,y(x)=%.5f,erro=%.10f", i, x, i, w(i),ex(i),erro);
    end  
    
    
end    

function z = p(x)
    z = -1/(4*x);
end

function z = q(x)
    z = 1/(2*x);
end

function z = r(x)
    z = log(x)*(-1)/(2*x);
end

function z = y(x)
    z = (4/x)-(2/x^2)-1.5 +log(x) ;
end