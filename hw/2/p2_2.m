h = [1 2 1];
w = [-4:4]/4*pi;
A = [9:-1:1];
ph = pi/4*ones(1,9);
[A_out, phi_out] = cosinefreqresp(h, w, A, ph);
A_ref = [0    4.6863   14.0000   20.4853   20.0000   13.6569    6.0000    1.1716        0];
phi_ref = [1 4 3 2 1 0 -1 -2 1]/4*pi;
assert(norm(A_out-A_ref)<1e-4,'Output amplitudes are wrong.');
assert(norm(phi_out-phi_ref)<1e-10,'Output phases are wrong.');

function [A_out, phi_out] = cosinefreqresp(h, w, A_in, phi_in);

% Compute the complex frequency response at each of the entries of w
% If using freqz, need an extra step if length(w) = 1.
[H,W] = freqz(h,1,w);
% Compute magnitude and phase of sampled frequency response
for i=1:length(w)
    A_out(i) = A_in(i) * abs(H(i));
    phi_out(i) = phi_in(i) + angle(H(i));
end
% Use these to determine how input cosines are transformed
end
