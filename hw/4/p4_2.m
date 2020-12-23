lens = [64]; 
for n = lens
  rng(n);
  a=@(n) 10*exp(-1j*pi/8*n);
  g=[0:1:n-1];
  v=a(g);
  v = v - mean(v);
  y1 = fft(v);
  y2 = radix2fft(v);
  figure();
  stem(abs(y2));
  err = sum(abs(y1 - y2));
  assert(err < 1)
end


function w = radix2fft(v);

% v should be a length-N column vector

N = length(v);

if ~isequal(unique(factor(N)),2)
    error('N is not a power of 2!');
end


if N == 2
    % Compute length-2 DFT directly (it's super simple)
    wn = exp(-1j*2*pi/N);
    F = zeros(N,N);
    for i = 1:N
        for k = 1:N
            F(k, i) = wn.^((i-1)*(k-1));
        end
    end
    w = F*v;
else
    % Split input vector into even and odd parts
    v_even = v(1:2:end,:);
    v_odd = v(2:2:end,:);
    
    % Take radix 2 FFT of each part
    w_even = radix2fft(v_even);
    w_odd = radix2fft(v_odd);
    for k = 1:N/2
        w_odd(k) = w_odd(k) * exp(-j*2*(pi./N.*(k-1)));
    end
    w = [w_even+w_odd ; w_even-w_odd];
end
   
end