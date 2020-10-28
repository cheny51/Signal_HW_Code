fs = 10000;
[t,e] = envelope(fs,.2,.2,0.5,.3,.3);
plot(t,e)
assert(norm(t(1:1000:10001)-[0:.1:1])<1e-10,'Time vector is incorrect.  Are there repeated elements?  It should be length 10001.');
assert(norm(e(1:1000:10001)- [0 1/2 1 3/4 1/2 1/2 1/2 1/2 1/3 1/6 0])<1e-10,'Envelope values are incorrect.');


function [t,e] = envelope(fs,a,d,s,dur,r)

% In each phase of the signal, determine the corresponding piece of time vector and envelope.

% Attack: signal linearly increases from 0 to 1 in a seconds
t = 0:1/fs:a;
e = (1/a)*t;
    
% Decay: signal linearly decreases from 1 to s in d seconds; points 
tdelay = (a+1/fs):1/fs:a+d; 
t = [t, tdelay];
m = (s-1)/(a+d-a);
e = [e, (m*tdelay +(s-m*(a+d)))];

% Sustain: signal stays at s for dur seconds
tsustain = (a+d+1/fs):1/fs:(a+d+dur); 
t = [t, tsustain];
e = [e, s*ones(1,length(tsustain))];

% Release: signal linearly decreases from s to 0 in r seconds
trelease = (a+d+dur+1/fs):1/fs:(a+d+dur+r);
t = [t, trelease];
m = (0-s)/(a+d+dur+r-(a+d+dur));
e = [e, (m)*trelease+ s-(m)*(a+d+dur)];
plot(t,e)
end