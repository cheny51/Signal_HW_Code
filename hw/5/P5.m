%% P5_1
function tout = time_resample(tin,factor);

% Create the longer time vector using interp1
tout = interp1(tin,tin, tin(1):((tin(2)-tin(1))/factor):tin(end) )

% Remove end values from tout that are inaccurate, if necessary
end
%% P5_2
function [tout,yout] = interp_linear(tin,yin,factor);

% Create the longer time vector (see Problem 5.1)
tout = interp1(tin,tin, tin(1):((tin(2)-tin(1))/factor):tin(end) )

% Linear interpolation using interp1
yout = interp1(tin, yin, tout);
end
%% P5_3
function [tout,yout] = interp_sinc(tin,yin,factor);

% Create the longer time vector (see Problem 5.1)
tout = interp1(tin,tin, tin(1):((tin(2)-tin(1))/factor):tin(end) );
ts = abs(tin(1)-tin(2));
figure;
subplot(3,1,1);
% Initialize the output vector
yinit = zeros(size(tout));
yinit(1:factor:end) = yin;
plot(tout,yinit);
xlim([0 16]);
% Create the sinc function that will be used to filter the
% zero-interpolated sample values.
subplot(3,1,2);
t = [-flip(tout(1:2001)) tout(1+1:2001)];
%t = -1999*ts:ts:2000*ts;
local_mid = tout - tout(floor(length(tout)/2));
sincfilt = sinc(local_mid.*1/(ts));
% sincfilt = sinc(tout);
plot(tout,sincfilt)
% Filter the signal with the sinc function; make sure that the time samples
% and signal samples are aligned (i.e., the interpolated signal matches the
% original samples at the correct points).
subplot(3,1,3);
ytemp = conv(sincfilt,yinit);
plot(ytemp)
xlim([0 16]);
%plot(ytemp)
yout = ytemp(0.5*length(sincfilt)-1:length(sincfilt)+0.5*length(sincfilt)+1);
end
%% P5_4
function yout = rationalresample(yin,I,D)

% Upsample the input by I
yup = upsample(yin, I);

% Create FFT of upsampled signal

F = fft(yup);

% Create ideal lowpass filter in the frequency domain
N = length(F);
k = 0:N-1;
w = 2*pi*k/N;
size_F = size(F);
min_gain = min(1/I, 1/D);
min_w = min(pi/I, pi/D);

H = ((w>= 0)&(w<=min_w))|((w>=2*pi-min_w));
H = H.*I;
plot(H)
% Product in frequency domain

G = F.*H;

% Inverse FFT

g = ifft(G);

% Ensure output is real

g = real(g);

% Downsample by D

yout = downsample(g, D);
end