h = [1 1.5];
N = 10;
n0 = 0:8;
Var = 10e-4;
mmse = zeros(1, length(n0));
w = zeros(length(n0), length(n0));
for j = n0
    [~, mmse(j+1)] = findmmsefireq(h, Var, N, j);
end
figure
plot(n0, mmse)
title('output delay vs. mmse');
xlabel('output delay')
ylabel('mmse')

function [w, mmse] = findmmsefireq(h,Var,N,no)
    % the impulse response -> h
    % zero-pad the impulse response so it match the FIR filter size
    h1 = [h zeros(1, N-1)];
    h2 = h1;
    for i = 1:N-1
        h2 = [h2; circshift(h1, i)];
    end
    % find H matrix -> auto-corr of y
    R = h2*h2'+Var*eye(N,N); % autocorrelation multiplu
    
    % find P -- cross correlation of x and x-n0
    % We know impulse response, now we make r vector same length as h
    r = zeros(length(h)+N-1, 1);
    r(no+1) = 1; %x is zero mean but variance of 1
    
    P = h2*r;
    w = R^(-1) * P;
    var_x = 1;
    mmse = var_x - P'*R^(-1)*P;
end