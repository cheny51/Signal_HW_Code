clear all; clc; close all

%Fourier Series Examples

%Sawtooth wave
%Plot of the sawtooth wave, a periodic continuation of the linear function 
%s(t)=t/\pi  on the interval (-\pi ,\pi ]

K = 10;
T = 2*pi; %period
w0 = 2*pi/T; %fundamental frequency (angular)
t = linspace(-T/2*K,T/2*K,2*K*1000);
s = @(t) sawtooth(t);

figure; plot(t,s(t),'linewidth',2)

N = 50;   
a0 = 1/T * integral(@(t) s(t),-T/2,T/2);
a = zeros(1,N);
b = zeros(1,N);
sN = a0;
%Synthesis process
for n = 1:N
    a(n) = 2/T * integral(@(t) s(t).*cos(n*w0*t),-T/2,T/2);
    b(n) = 2/T * integral(@(t) s(t).*sin(n*w0*t),-T/2,T/2);

    sN = sN + a(n)*cos(n*w0*t) + b(n)*sin(n*w0*t);
end

hold on; plot(t,sN,'r','linewidth',2);

%%
%Square wave (a real signal)
t = -20:.0001:20;
w0 = 1;
T = 2*pi/w0;

%duty cycle 50%
s = @(t) (1+square(w0*(t+pi/2),50))/2; 
figure; plot(t,s(t),'linewidth',2)

N = 50;   
a0 = 2/T * integral(@(t) s(t),-T/2,T/2);
a = zeros(1,N);
b = zeros(1,N);
sN = a0/2;
%Synthesis process
for n = 1:N
    a(n) = 2/T * integral(@(t) s(t).*cos(n*w0*t),-T/2,T/2);
    b(n) = 2/T * integral(@(t) s(t).*sin(n*w0*t),-T/2,T/2);

    sN = sN + a(n)*cos(n*w0*t) + b(n)*sin(n*w0*t);
end

hold on; plot(t,sN,'r','linewidth',2);

%Samples of FS coefficients
c = zeros(1,2*N+1);
for n = 1:2*N+1
    if n<N+1
        c(n) = (a((N+1)-n)+1i*b((N+1)-n))/2;
    elseif n>N+1
        c(n) = (a(n-(N+1))-1i*b(n-(N+1)))/2;
    else
        c(n) = a0/2;
    end
end
figure; plot(-N:1:N,c,'linewidth',2);

%What about sinc function? sinc(x) =  sin(pi*x)/(pi*x)
%c_k = sin(k*pi/2)/(pi*k);
Nset = -N:1:N;
figure; plot(Nset,1/2*sinc(Nset/2),'r','linewidth',2)
%%
%sinc function

t = linspace(-N,N);
s = @(t) 1/2*sinc(t/2);
figure; plot(t,s(t),'k','linewidth',2);


