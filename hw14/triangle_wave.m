% Creates triangle waves two ways, one using repmat() and 
% one using sawtooth() from the Signal Processing Toolbox.
format longg;
format compact;
clc;	% Clear command window.
workspace;	% Make sure the workspace panel is showing.
fontSize = 15;
close all;   % Close figures from a prior run of this demo.

% If you have the signal Processing Toolbox, you can do
figure;
x=-30 : 0.01 : 30;
f=@(x) 10 * sawtooth(x ,0.5) + 5;
line(x,f(x),'color','r', 'linewidth',2.5)

grid on;
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 

% If you don't have the Signal Processing Toolbox, you can try this:

% Define some parameters that define the triangle wave.
elementsPerHalfPeriod = 30; % Number of elements in each rising or falling section.
amplitude = 5; % Peak-to-peak amplitude.
verticalOffset = -2; % Also acts as a phase shift.
numberOfPeriods = 4; % How many replicates of the triangle you want.

% Construct one cycle, up and down.
risingSignal = linspace(0, amplitude, elementsPerHalfPeriod);
fallingSignal = linspace(amplitude, 0, elementsPerHalfPeriod);
% Combine rising and falling sections into one single triangle.
oneCycle = [risingSignal, fallingSignal(2:end-1)] + verticalOffset;
x = 0 : length(oneCycle)-1;

% Now plot the triangle.
figure;
subplot(3, 1,  1);
plot(x, oneCycle, 'bo-');
grid on;
title('One Cycle of the Triangle', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 

% Now replicate this cycle several (numberOfPeriods) times.
triangleWaveform = repmat(oneCycle, [1 numberOfPeriods]);
x = 0 : length(triangleWaveform)-1;

% Now plot the triangle wave.
subplot(3, 1,  2);
plot(x, triangleWaveform, 'bo-');
grid on;
title('Several Cycles of the Triangle', 'FontSize', fontSize);

% Now blur it to smooth it out:
windowWidth = 9;
smoothTriangleWave = conv(triangleWaveform, ones(1,windowWidth)/windowWidth, 'same');
subplot(3, 1,  3);
plot(x, smoothTriangleWave, 'bo-');
grid on;
title('Smoothed Triangle Wave', 'FontSize', fontSize);
