% Create a few notes 
scale = kron([330 440 550 700 1000 2000], ones(1,10));
[t,y] = recreatesignal(.1,scale,10000);
% Make sure frequencies are roughly correct
for i=1:3
   fftpart = fft(y([1:10000]+10000*(i-1)));
   [m,ind] = max(abs(fftpart));
   mf(i) = ind-1;
end
%assert(isequal(mf,  [330 440 550]), 'Frequencies of output signal don''t seem correct.  Does it sound right?');

function [t,y] = recreatesignal(width,d,fs)

% Loop over windows, creating time and signal vector along the way
t = [];
y = [];

% Small time vector corresponding to one window
smallt = 0:1/fs:(width-1/fs);

for i=1:length(d)
    smallsig = cos(2*pi*d(i)*smallt);
    t = [t,smallt];
    y = [y,smallsig];
end
sound(y,fs)
end

