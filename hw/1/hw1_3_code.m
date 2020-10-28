% % A simple scale, played like a clarinet
% notes = [262 294 330 349 392 440 494 524];
% durs = 0.5*ones(1,8);
% amps = [1 0 0.66 0 0.66 0 0.31 0.48 0.24];
% adsr = [.05,.1,0.95,.05];
% fs = 10000;
% y = synthesizer(notes, durs, amps, adsr, fs);
% assert(abs(length(y)-56008)<20,'Output vector is the wrong length.');
% % Crop a region that should correspond to one note
% cr = y(37000:39000);
% % Find the peaks in this segment's spectrum
% [m,loc] = findpeaks(abs(fft(cr)));
% assert(norm(m-  [399.8421  256.7753  244.2749  105.6992  155.5791   73.5213   73.5213  155.5791  105.6992  244.2749  256.7753  399.8421])<2,'Peak heights of cropped signal seem incorrect.')
% assert(norm(loc - [89   265   441   617   705   793  1210  1298  1386  1562   1738  1914])<5,'Peak locations of cropped signal seem incorrect.')

fs = 10000;
[t,e] = envelope(fs,.2,.2,0.5,.3,.3);
function y = synthesizer(notes,durs,harmamps,adsr,fs)

% Initialize output as empty
y = [];

% Loop over the notes
for i=1:length(notes)
    % Compute the time vector and ADSR envelope for this note
    [t,e] = envelope(fs, adsr(1), adsr(2), adsr(3), durs(i), adsr(4));
    
    % Compute the sum of harmonics for this note
    h = harmonics(t, notes(i), harmamps);
    
    % Modulate the sum of harmonics with the envelope
    n = h.*e;

    % Add the note to the sequence
    y = [y,n];
end

% Play the sound
%sound(y,fs);
end
function [t,e] = envelope(fs,a,d,s,dur,r)
    % In each phase of the signal, determine the corresponding piece of time vector and envelope.
    
    % Attack: signal linearly increases from 0 to 1 in a seconds
    t = 0:1/fs:a;
    e = (1/a)*t;
        
    % Decay: signal linearly decreases from 1 to s in d seconds
    tdelay = (a+1/fs):1/fs:a+d; 
    t = [t, tdelay];
    % just decay portion
    % y = mx+b
    % m
    m = (s-1)/(a+d-a);
    b = s - m*(a+d);
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
function y = harmonics(t, f0, harmamps, harmphase)
    % Initialize y to 0
    y = zeros(size(t));
    
    if nargin<4  % phase is the same (0) for all harmonics
        harmphase = zeros(size(t));
    end
    
    % Loop over harmonics, adding weighted versions to y
    for i=1:length(harmamps)
        
        y = y+harmamps(i)*sin(2*pi*i*f0*t+harmphase(i));
    end
    
    % Normalize maximum amplitude to 0.95 so that 
    % sound(y,fs) doesn't get distorted
    y = y/max(y(:))*0.95;
end