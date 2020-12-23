% problem 5
syms w
Y = @(w) -2*sin(w)-5*sin(2*w)+(1+2*cos(w)+3*cos(2*w))*exp(j*2*w);
y_iFT = ifourier(Y(w));

N=5;
k = 0:1:N-1;
w = 2*pi/N;
Xr = @(k) (1 + 2*cos(k*w)+3*cos(k*w*2)).*exp(1i*2*w*k);
Xi = @(k) (1*(-2)*sin(k*w)+1*(-5)*sin(k*2*w));
Result = (Xr(k)+Xi(k))/N;
for r = 1:length(Result)
    fprintf('For a_%d\n', r);
    fprintf('|a_%d| = %d\n', r, abs(Result(r)));
    fprintf('<(a_%d) = %d\n', r, angle(Result(r)));
end
plot(k, angle((Xr(k)+Xi(k))/N));

% Problem 7a
w = -2*pi:pi/100:2*pi;
h = @(w) ((1-1/4*cos(w))+1i*(1/4*sin(w))).^(-1);
plot(w, abs(h(w)));

% Problem 7b
w = -2*pi:pi/100:2*pi;
h = @(w) ((1-1/4*cos(w))+1i*(1/4*sin(w))).^(-1);
plot(w, angle(h(w)));

% Problem 6c

% 6c: original x[n]
n = -5:1:1;
x_all = @(n) 3-abs(n+2);
figure();
stem(n,x_all(n));
% 6c: only perform fourier on the n where x[n] is 0
%     X_n_lim: the fourier of x[n] when x[n] is now n-limited
X_n_lim = exp(i*w*4)+2*exp(i*w*3)+3*exp(i*w*2)+2*exp(i*w*1)+1;

% To Simplify
X_n_lim = simplify(X_n_lim);

% x_n_new: x[n+10]
%          using property we know x[n-n0] <-> X[w]*Exp(-i*w*n0)
X_n_new = exp(i*w*10)*(exp(i*w*4)+2*exp(i*w*3)+3*exp(i*w*2)+2*exp(i*w*1)+1);

% To Simplify
X_n_new = @(w) exp(w*10i).*(exp(w*1i) + exp(w*2i) + 1).^2;

% now plot X_new(w)
w = -2:0.001:2;
plot(w, X_n_new(w));

% problem 6eii
syms w
X = (1-exp(-1-1i*w)).^(-1);
H = 0.5*((1-exp(-1-1i*w)).^(-1))+0.5*((1-exp(-3-1i*w)).^(-1));
Y = @(w) X*H;
simplify(ifourier(Y(w)))


