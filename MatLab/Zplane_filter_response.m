clear all; clc; close all;
%October 17, 2019
%Derya Malak

%%
%Example 1: bandpass

%r = 5/6; 
%r = 1/6; %smaller r (less peaky)
r = 99/100; %larger r (sharp peak)

b = [0 sin(pi/3)*r];

a = [1 -2*r*cos(pi/3) r^2];

%Plotting z plane
figure
zplane(b,a); 
set(gca,'FontSize',24)  %enlarge figure font size
set(findall(gcf,'-property','linewidth'),'linewidth',2) %makes the lines visible
set(findall(gcf,'-property','markersize'),'markersize',18) %enlarges the markers 

%Plotting frequency response
figure
freqz(b,a)
set(findall(gcf,'-property','linewidth'),'linewidth',2) 


%%
%Example 2: low pass
N = 8; %order of filter. if you want a better low pass characteristics, change this term to 54
b = fircls1(N,0.3,0.02,0.008); 
a = 1;

figure
zplane(b,a); 
set(gca,'FontSize',24)  
set(findall(gcf,'-property','linewidth'),'linewidth',2)
set(findall(gcf,'-property','markersize'),'markersize',18)  

figure
freqz(b,a)
set(findall(gcf,'-property','linewidth'),'linewidth',2) 

%%
%Example 3: low pass
N = 5; %order of filter
[b,a] = ellip(N,0.5,20,0.4);

figure
zplane(b,a); 
set(gca,'FontSize',24)  
set(findall(gcf,'-property','linewidth'),'linewidth',2) 
set(findall(gcf,'-property','markersize'),'markersize',18) 

figure
freqz(b,a)
set(findall(gcf,'-property','linewidth'),'linewidth',2) 

%%
%Example 4: high pass (this is an IIR filter-we have not seen IIR filters yet, but we will!)

[z,p,k] = butter(6,0.7,'high');
%locations of zeros and poles

figure
zplane(z,p); 
set(gca,'FontSize',24)  
set(findall(gcf,'-property','linewidth'),'linewidth',2) 
set(findall(gcf,'-property','markersize'),'markersize',18) 

SOS = zp2sos(z,p,k);    
freqz(SOS)
set(findall(gcf,'-property','linewidth'),'linewidth',2) 
