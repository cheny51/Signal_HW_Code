%AR
%Derya Malak, Nov 18, 2019

clear; clc; close all

%Creating an Auto Regressive process
L = 10;  %the input length will be 2^L
         %if you increase this, the Yule Walker equations will give better
         %estimates.
y = filter(1,[1 -0.75 0.5],0.2*randn(2^L,1));

plot(y) 

%AR parameter estimation via Yule-Walker method
[ar_coeffs,NoiseVariance] = aryule(y,2);


ar_coeffs

NoiseVariance


%ARMA

%the following requires Econometrics Toolbox (I do not have it on my computer!)
%model = arima(1,0,1)
%model = arima('ARLags',1:2,'MALags',1,'Constant',0)