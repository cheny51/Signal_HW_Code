assessFunctionAbsence('fft','Filename', 'directdft.m','Feedback','Make sure to implement the algorithm without using built-in MATLAB functions.')
assessFunctionAbsence('dftmtx','Filename', 'directdft.m','Feedback','Make sure to implement the algorithm without using built-in MATLAB functions.')
lens = [5 10 25]; 
for n = lens
  rng(n)
  v = rand(n,1) + j*rand(n,1);
  v = v - mean(v);
  y1 = fft(v);
  y2 = directdft(v);
  err = sum(abs(y1 - y2));
  assert(err < 1e-12)
end


function w = directdft(v)

% v should be a length-N column vector

N = length(v);
wn = @(N) exp(-1j*2*pi/N);
% create N x N DFT matrix

F = zeros(N, N);
for i = 1:N
    for k = 1:N
        F(k, i) = wn.^((i-1)*(k-1));
    end
end

% compute w using a matrix-vector product

w = F*v;
end
