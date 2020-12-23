clear all; clc; close all;
%October 21, 2019
%Derya Malak

%% DFT

F = dftmtx(2);
F'*F %orthogonality

%reconstruct a time domain signal using its frequency components
N = 16;
F = dftmtx(N); %NxN DFT matrix
n = linspace(0,1,N)';
x = rand(N,1);
figure; 
stem(n,x,'linewidth',2)

X = F*x;
Q = inv(F);
% x = Q*X;

imax = N; %imax<=N
x_estimate = zeros(N,1);
for i = 1:imax 
    x_estimate = x_estimate+Q(:,i)*X(i);
end
hold on;
stem(n,real(x_estimate),'-r','linewidth',2)


%% DFT vs DTFT

%Example DTFT we computed
w = linspace(0,2*pi,200);
DTFT = exp(-2*j*w).*sin(5*w/2)./sin(w/2);

plot(w,abs(DTFT),'linewidth',2);

%take length 10 DFT
N = 100; %vs 100 larger period
x = [ones(1,5) zeros(1,N-5)];
w_s = 2*pi/N*[0:N-1];
DFT = fft(x);
hold on
stem(w_s,abs(DFT),'-r','linewidth',2)

%or use fft(x,N): N-point FFT
hold on
N = 50;
w_s = 2*pi/N*[0:N-1];
stem(w_s,abs(fft(x,N)),'-.g','linewidth',2)

%% FFT (an efficient algorithm in MATLAB to compute DFT)