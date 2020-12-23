%The Levinson-Durbin recursion algorithm
%Dec 4, 2019
%Derya Malak

%Estimate the coefficients of an autoregressive process given by
%x(n)=-0.1x(n-1)+0.8x(n-2)+w(n)

a = [1 0.1 -0.8];

%Generate a realization of the process by filtering white noise of variance 0.4.

rng('default')
v = 0.4;
w = sqrt(v)*randn(15000,1); %noise process
x = filter(1,a,w);


%Estimate the correlation function. 
[r,lg] = xcorr(x,'biased');

%Discard the correlation values at negative lags. 
r(lg<0) = [];


N = numel(a)-1;
%Use the Levinson-Durbin recursion to estimate the model coefficients
%and the prediction error e for an autoregressive model of order N.
% reflection coefficients k as a column vector of length n.
[ar,e,k] = levinson(r,N)

