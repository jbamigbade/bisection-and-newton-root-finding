% Bamigbade_Oluwaseyi_hw5.m
format long;

epsi = 0.5e-6;
nmax = 100;
delta = 1e-14;

% === 1. Bisection Method ===
function root = bisection(f, a, b, nmax, epsi)
  for i = 1:nmax
    c = (a + b)/2;
    if abs(f(c)) < epsi || (b - a)/2 < epsi
      root = c;
      return;
    endif
    if f(a)*f(c) < 0
      b = c;
    else
      a = c;
    endif
  endfor
  root = (a + b)/2;
endfunction

% === 2. Newton's Method ===
function root = newton(f, df, x, nmax, epsi, delta)
  for i = 1:nmax
    fx = f(x);
    dfx = df(x);
    if abs(dfx) < delta
      break;
    endif
    x_new = x - fx / dfx;
    if abs(x_new - x) < epsi
      root = x_new;
      return;
    endif
    x = x_new;
  endfor
  root = x;
endfunction

% Question 1 - Bisection
ans_1a = bisection(@(x) x - tan(x), 0, pi/2, nmax, epsi);
ans_1b = bisection(@(x) x - 2^x, 0, 1, nmax, epsi);
ans_1c = bisection(@(x) 2^x + exp(x) + 2*cos(x) - 6, 1, 3, nmax, epsi);
ans_1d = bisection(@(x) (x^3 + 4*x^2 + 3*x + 5)/(2*x^3 - 9*x^2 + 18*x - 2), 0, 4, nmax, epsi);

% Question 2 - Newton vs Bisection
f = @(x) atan(erfc(x) - x^4);
df = @(x) (1/(1 + (erfc(x) - x^4)^2)) * (-2*exp(-x^2)/sqrt(pi) - 4*x^3);

tic;
root_bisect = bisection(f, 0, 2, nmax, 1e-13);
time_bisect = toc;

tic;
root_newton = newton(f, df, 1, nmax, 1e-13, delta);
time_newton = toc;

ans_2a = root_newton;
if time_newton < time_bisect
  ans_2b = "newton";
else
  ans_2b = "bisection";
endif

% Question 3 - Root finding
f3 = @(x) atan(x) - (2*x)/(1 + x^2);
df3 = @(x) (1/(1 + x^2)) - (2*(1 - x^2))/(1 + x^2)^2;
g = @(x) atan(x);
dg = @(x) 1/(1 + x^2);

ans_3a = bisection(f3, 0, 1, nmax, eps);
ans_3b = newton(f3, df3, 0.5, nmax, eps, delta);
ans_3c = newton(g, dg, ans_3a, nmax, eps, delta);

% Save Output to Text File (clean structure)
outputFile = 'C:\\Users\\johnb\\OneDrive\\Desktop\\Numerical Analysis\\Homework 5\\Bamigbade_Oluwaseyi_HW5_Results.txt';
fid = fopen(outputFile, "w");

fprintf(fid, "Bamigbade_Oluwaseyi_HW5_Results\n\n");

fprintf(fid, "Question 1 Results:\n");
fprintf(fid, "ans_1a = %.15f\n", ans_1a);
fprintf(fid, "ans_1b = %.15f\n", ans_1b);
fprintf(fid, "ans_1c = %.15f\n", ans_1c);
fprintf(fid, "ans_1d = %.15f\n\n", ans_1d);

fprintf(fid, "Question 2 Results:\n");
fprintf(fid, "ans_2a = %.15f\n", ans_2a);
fprintf(fid, "ans_2b = %s\n\n", ans_2b);

fprintf(fid, "Question 3 Results:\n");
fprintf(fid, "ans_3a = %.15f\n", ans_3a);
fprintf(fid, "ans_3b = %.15f\n", ans_3b);
fprintf(fid, "ans_3c = %.15f\n", ans_3c);

fclose(fid);
