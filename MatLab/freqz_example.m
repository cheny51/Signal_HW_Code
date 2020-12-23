%Designing a 3 tap filter in discrete domain


w = linspace(-pi,pi,30); %DTFT periodic with 2pi
h = [1 1 1]; %filter with 3 taps at n=0, n=1 and n=2

%H(w)= sum_n h[n]e^(-jwn) = h[0] +h[1]e^(-jw)+h[2]e^(-2jw)    DTFT

B = h;
A = [1,zeros(1,length(w)-1)];
[H,W] = freqz(B,A,w);
[phaseH,W] = phasez(B,A,w)

figure
plot(w,abs(H),'linewidth',2)
title('Magnitude response')


figure
plot(w,phaseH,'linewidth',2)
title('Phase response')
