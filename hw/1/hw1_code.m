fs = 44100;
t = 0:1/fs:1;
% Clarinet-like sound
amps = [1 0 0.66 0 0.66 0 0.31 0.48 0.24];
y = harmonics(t,440,amps);
ystart = [0    0.3714    0.6812    0.8818    0.9500     0.8915    0.7378    0.5377    0.3443    0.2021    0.1368    0.1509    0.2251    0.3258    0.4154    0.4632    0.4534    0.3890    0.2890    0.1830];
% assert(norm(y(1:20)-ystart)<5e-4,'Sum of harmonics doesn''t match reference solution.');
% sound(y,fs);
function y = harmonics(t, f0, harmamps, harmphase)

    % Initialize y to 0
    y = zeros(size(t));

    if nargin<4  % phase is the same (0) for all harmonics
        harmphase = zeros(size(t));
    end

    figure;
    hold on;
    
    % Loop over harmonics, adding weighted versions to y
    for i=1:length(harmamps)
        sinusoid_harmonic = harmamps(i)*sin(2*pi*i*f0*t+harmphase(i));
        plot_name = sprintf('n =%i', i);
        plot(t, sinusoid_harmonic,'--','DisplayName',plot_name);
        y = y+sinusoid_harmonic;
    end
    % Normalize maximum amplitude to 0.95 so that 
    % sound(y,fs) doesn't get distorted
    y = y/max(y(:))*0.95;
    plot(t, y, 'LineWidth', 2,'DisplayName','Sum of harmonic');
    hold off;
    xlim([0 1/f0]);
    title('Different Signal Harmonics and Sum of all Signal Harmonics')
    xlabel('time (s)');
    ylabel('y(t)');
    lgd = legend;
    lgd.NumColumns = 2;
end

function [t,e] = envelope(fs,a,d,s,dur,r)



% In each phase of the signal, determine the corresponding piece of time vector and envelope.

% Attack: signal linearly increases from 0 to 1 in a seconds
t = 0:1/fs:a;
e = 1/a*t
    
% Decay: signal linearly decreases from 1 to s in d seconds
tdelay = (a+1/fs):1/fs:a+d; 
t = [t, tdelay];
% just decay portion
% y = mx+b
% m
m = (s-1)/(tdelay(end)-a)
b = s - m*tdelay(end)
e = [e, m*tdelay+b];

% Sustain: signal stays at s for dur seconds
tsustain = (a+d+1/fs):1/fs:a+d+dur; 
t = [t, tsustain];
e = [e, s + zeros(size(tsustain))];

% Release: signal linearly decreases from s to 0 in r seconds
trelease = (a+d+dur+1/fs):1/fs:a+d+dur+r;
t = [t, trelease];
m = (0-s)/(trelease(end)-(a+d+dur));
b = 0-m*(trelease(end));
e = [e, m*trelease+b];
end