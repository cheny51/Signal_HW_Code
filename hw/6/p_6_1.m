N = 23;
wc = 0.3*pi;
[w,Ad,phi,h] = type1_dft(N,wc);
phitrue = [1.0000+0.0000i  -0.9907-0.1362i   0.9629+0.2698i  -0.9172-0.3984i   0.8544+0.5196i  -0.7757-0.6311i   0.6826+0.7308i  -0.5767-0.8170i   0.4601+0.8879i  -0.3349-0.9423i   0.2035+0.9791i  -0.0682-0.9977i  -0.0682+0.9977i   0.2035-0.9791i  -0.3349+0.9423i   0.4601-0.8879i  -0.5767+0.8170i   0.6826-0.7308i  -0.7757+0.6311i   0.8544-0.5196i -0.9172+0.3984i   0.9629-0.2698i  -0.9907+0.1362i];
assert(max(abs(phi-phitrue))<1e-4,'Phase vector is wrong.')


function [w,Ad,phi,h] = type1_dft(N,wc)

% Create vector of equally-spaced frequencies
k = 0:N-1;
w = 2*pi*k/N;

% Create ideal amplitude response of low-pass filter (remember, it should
% be symmetric about w = pi)

Ad=(w <= wc) | (w >= 2*pi-wc);

% Compute linear phase vector using correct slope
phi = exp(-1j*w*(N-1)/2);

% Compute ideal frequency samples as product of Ad and phi

H = Ad.*phi;

% Compute filter taps via inverse DFT

h = ifft(H);

% Make result real to get rid of near-zero imaginary parts

h = real(h);
h = h(1:N-1);
end