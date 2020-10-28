f = @(t) exp(-abs(t));   % This signal is not bandlimited, so if we sample too slow, aliasing will be noticeable
w = -3*pi:pi/100:3*pi;   % Remember the DTFT will be 2pi-periodic
F20 = dtft(f, 1/20, 600, w);   % Sampling really fast; aliasing shouldn't be visible
F3 = dtft(f, 1/3, 30, w);   % Sampling slower; aliasing starts to be visible
F1 = dtft(f,1,30, w);  % Sampling way too slow; aliasing will be quite visible (e.g., F is far from 0 near pi)

plot(w, abs(F20)/20, w, abs(F3)/3, w, abs(F1))

F1samp = real(F1(301:10:401));
F3samp = real(F3(301:10:401))/3;
F20samp = real(F20(301:10:401))/20;

assert(norm(F1samp-[2.1640    1.9851    1.6010    1.2302    0.9523    0.7616    0.6345    0.5515    0.4996    0.4712    0.4621])<1e-3, 'DTFT values are incorrect.');
assert(norm(F3samp-[2.0184    1.0778    0.4581    0.2417    0.1515    0.1072    0.0829    0.0688    0.0607    0.0564    0.0551])<1e-3, 'DTFT values are incorrect.');
assert(norm(F20samp-[2.0004    0.0498    0.0130    0.0060    0.0036    0.0025    0.0019    0.0016    0.0014    0.0013    0.0012])<1e-3, 'DTFT values are incorrect.');

function F = dtft(f,T,N,w)

% f = function
% T = sampling period
% n = number of samples
% w = frequencies to sample the DTFT

% Evaluate the DTFT sum directly for each of the w samples

for i=1:length(w)
    F(i) = 0;
    for n=-N:N
        F(i) = F(i) + exp(-n*j*w(i))*f(n*T);
    end
end

% Plot the normalized DTFT magnitude 
Fnorm = abs(F)*T;
plot(w, Fnorm);

% Scale the y axis to go from 0 to the max value
set(gca, 'ylim', [0 max(Fnorm(:))])
end