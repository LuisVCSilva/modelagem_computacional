#!/usr/bin/env octave

% defines: constants and initial conditions
format long;
global a=0;
global b=0;
global x=0;
global y=0;
global R=50*10^-3; % convert to meters
global r=20*10^-3; % convert meter
global relerr = 0.1; % threshold to continue loop
global L=2; % 2 meters %L = input('Enter a number to represent the beam length in metres: ');
global t=a:1:L; % legend('-DynamicLegend'); % for plotting
global h;
global P=20000; % 20 kN %P = input('Enter a number to represent the force to place on the beam: ');
global E = 70*10^9; % modulus of elasticity
global result = 1; % initialize to allow execution;
global iteration = 0;
global cmap = hsv(6);
global legend_array;
global old_legend_array;
title('{Simpson 3/8 evaluation for displacement on a beam}','FontSize',14)
xlabel('x - position on beam');
ylabel('\delta - displacement');
fprintf('Using:\r\n P=%f newtons, R=%f meters, r=%f meters, L=%f meters, E=%e Pa \r\n',P,R,r,L,E);
% user-defined function to take another function and two input parameters and return an integral result
function [result] = Simpsons38 (Fun,a,b)
	global iteration;
    global result;
	global relerr;
    global a;
    global L;
    global h;
    global cmap; % color map
	global legend_array;
	global old_legend_array;
    global t; % for plotting
	result = 1;
	fprintf('\r\nStarting execution of S38\r\n');
    fprintf('Range of evaluation [%f,%f]\r\n',a,b);
    i = 3; % Simpsons rule should only be evaluated with even subintervals!
    if (mod(i,3)>0)
        fprintf ('	S38 method must be evaluated with even subintervals! %d is not a valid number of intervals!\r\n');
    endif;

    % execute Simpson's loop if the number of intervals is even and difference not less than 0.1
    do
        iteration = iteration+1;
        points = i+1;
		fprintf('\r\nSimpson 3/8: iteration:%d\r\n',iteration);
        iteration_title = strcat('  Simspon 3/8: intervals:', int2str(i));
        result_matrix = size(points,2);

        fprintf('  Subintervals: %d\r\n', i);
        fprintf('  Points: %d\r\n', points);
		h = (a+b)/i; % calculate the interval width
        fprintf('  Interval width: %f\r\n', h);

        % evaluate first term
        fprintf('  >>Calculating first_term\r\n');
        first_term = Fun(a);
        result_matrix(1,round(a/h+1)) = [a]; % store x value
        result_matrix(2,round(a/h+1)) = [first_term]; % store y value

		% first sum will be evaluated for 2,3, 5,6, 8,9, 11,12 etc.
		% first sum will be multiplied by 3
		first_sum = 0; %initialize
		% skip to the second term
		j = a + h;
        interval = 1;
        fprintf('  >>Calculating first_sum\r\n');

        while (j<(b-h))
            l = j;
            k = j + h; % term for the second evaluation, Fun(k)
            j_term = Fun(j);
            result_matrix(1,round(j/h+1)) = [j]; % store x value
            result_matrix(2,round(j/h+1)) = [j_term]; % store y value
            k_term = Fun(k);
            result_matrix(1,round(k/h+1)) = [k]; % store x value
            result_matrix(2,round(k/h+1)) = [k_term]; % store y value
            first_sum = first_sum + j_term + k_term;
            j = l + (h*3); % increment for the next loop
        endwhile;

        % second sum will be evaluated for 4,7,10,13, etc.
        % second sum will be multiplied by 2
        second_sum = 0; % initialize

        % skip to the fourth term
        j = a + h + h + h;
        fprintf('  >>Calculating second_sum\r\n');
        while (j < (b-h))
            j_term = Fun(j);
            result_matrix(1,round(j/h+1)) = [j]; % store x value
            result_matrix(2,round(j/h+1)) = [j_term]; % store y value
            second_sum = second_sum + j_term;
            j = j + (h*3);
        endwhile;

        % evaluate last term
        fprintf('  >>Calculating last term\r\n');
        last_term = Fun(b);
        result_matrix(1,round(b/h+1)) = [b]; % store x value
        result_matrix(2,round(b/h+1)) = [last_term]; % store y value

        % save old Simpson sum
        old_result = result;

        % add up all the results for new result
        result = (3*h/8)*(first_term + 3*first_sum + 2*second_sum + last_term);
		fprintf ('  Result: %e meters\r\n',result);

        % calculate the difference between the last Simpson sum
        SimpsonDifference = abs( ( (result - old_result) / result) * 100 );
        fprintf('  Simpson Difference:%e percent\r\n',SimpsonDifference);

        % plotting
        fprintf([repmat('%e\t', 1, size(result_matrix, 2)) '\n'], result_matrix');
        hold on;
        t = a:h:L;
        p = plot ( t, result_matrix(2,:), 'Color', cmap( mod(iteration,7) , : ) );
		set(p,'userdata',iteration_title);

        %plot ( t, result_matrix(2,:),'b');
        %legend(iteration_title);

        i = i * 2; % double the interval count

    until (SimpsonDifference <= relerr); fprintf('\r\nHit exit condition\r\n\r\n');
	%..collect labels from each curve and put up legend
	fprintf('children:%d\r\n',iteration);
	legend('3 subintervals','6 subintervals','12 subintervals','24 subintervals');
	iteration = 0;
endfunction;

% subfunctions
fprintf ('Testing subfunctions\r\n');

% function for cross-sectional area of a beam
function [area] = SB_crossSectionalArea(x,L)
	global R;
    global r;
	area = pi * ( R - (R-r)/L * x )^2;
	fprintf('	SB_crossSectionalArea() x=%f R=%f r=%f L=%f Area=%f \r\n',x,R,r,L,area);
endfunction; SB_crossSectionalArea(3,100); % test this function

% function for the normal strain in a beam
% P : force applied
% E : Modulus of Elasticity, 70 GPa
% A : Cross-sectional area of the beam
function [normal_strain] = SB_normalStrain(P,A)
	global E;
	normal_strain = P / ( E * A );
endfunction; SB_normalStrain(20,7000); % test this function

% function to combine the previous functions in composite displacement function
function [displacement] = SB_compositeDisplacement(x)
    global P;
    global E;
    global L = 12;
    global R;
    global r;
    fprintf('	SB_compositeDisplacement() (%d / %e) * ( 1 / ( pi * ( ( %d - ((%d-%d)/%d)*%d) )^2 ) )\r\n',P,E,R,R,r,L,x);
    displacement = (P / E) * ( 1 / ( pi * ( ( R - ((R-r)/L)*x) )^2 ) );
endfunction; SB_compositeDisplacement(10); % test this function

% inline function for displacement at given x
SB_inline_comDis = inline('(P ./ E) * ( 1 ./ ( pi * ( ( R - ((R-r)/L)*x) ).^2 ) )');
% anonymous function for displacement at given x
SB_anon_comDis = @(t)(P ./ E) * ( 1 ./ ( pi * ( ( R - ((R-r)/L)*t) ).^2 ) );
% loose function
SB_loose_comDis = (P ./ E) * ( 1 ./ ( pi * ( ( R - ((R-r)/L)*t) ).^2 ) );

% function to calculate the displacement of a point x = x_p along the beam
function [displacement] = SB_pointDisplacement(x_p)
    global P;
	global L;
	global E;
    A = SB_crossSectionalArea(x_p,L);
	displacement = SB_normalStrain(P,A);
	fprintf('	SB_pointDisplacement()  x=%f P=%f A=%f E=%e displacement=%e \r\n',x_p,P,A,E,displacement);
endfunction; SB_pointDisplacement(10); % test this function

% calculate the displacement with QUAD
q = quad(SB_anon_comDis,a,L,0.1);
fprintf ('integrate fun(P ./ E) * ( 1 ./ ( pi * ( ( R - ((R-r)/L)*x) ).^2 ) ) between [%d,%d]\r\n',a,L);
fprintf ('quad(fun,a,L,0.1) = %e meters\r\n', q);

% evaluate user-defined Simpsons38 function
final_answer = Simpsons38( @SB_pointDisplacement, 0, L);

% plot the QUAD calculated displacement as a function of x
t = a:1:L;
%subplot(a,1,L);
%legend ('1','2');
hold off;
pause (5);
