clear;clc;close all

syms t
f = rectangularPulse(t);
f_FT = fourier(f);



