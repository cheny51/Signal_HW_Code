s = 100;
h = [1 1.5];
Var = 10e-4;
mu = 0.3;
N = 10;
n0 = 8;
lmsalgo (s, Var, h, n0, mu, N)

function [mmse, w_hat] = lmsalgo (s, Var, h, n0, mu, N)
% mu is learning rate
% N is the length of the FIR filter
e = zeros(1000,s-n0); %error matrix

% step 1: get the random vector define for x
% random vector between 1 and -1
for j = 1:1000
    x = round(rand(s,1));
    for i = 1:length(x)
        if x(i) == 0
            x(i) = -1;
        end
    end

    % step 2: get the desired response xhat
    x_hat = x(1+n0:s);

    % step 3: get the x filtered through h
    lti_out = filter(h,1,x);

    % step 4: add noise, v, to get y
    % noise v = N~(0, Var)
    mean_noise = 0;
    sigma = sqrt(Var);
    v = normrnd(mean_noise,sigma,[1,s])';
    y = lti_out + v;

    % step 5: now get the FIR filter working
    % this is the FIR filter coefficient for this time instance
    w_hat = zeros(N, 1);
    
    for n = N:s-n0 %(the output is delayed by no)
        n_range = (n-(N-1)):n; %when n=N, this is 1:N
        % u[n] = [y[n]...y[n-(M-1)]
        % if n = M
        % u @ time M = [y[M]....y[1]] -> we can flip that and it will be
        % good
        % u @ time M+1 = [y[M+2]....y[2]]
        % u @ time M+s-n0-1 = [y[s-n0] ...y[s-n0-(N-1)]]
        u_n = y(flip(n_range)); % pick 
        
        %error between desired output and generated output at iteration n
        e(j,n) = x(n-n0)-w_hat'*u_n;

        P_n_hat = u_n*x(n-n0);
        R_n_hat = u_n*u_n';

        %update the filter coefficients w_hat
        w_hat = w_hat + mu*(P_n_hat-R_n_hat*w_hat);
    end
end

end