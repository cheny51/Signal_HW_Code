w=2; % signal width
Amp=1; % signal amplitude
tt=-w:w
t1=-2*w:0;
t2=0:2*w;
t=[t1 t2];
y1=Amp-Amp*abs(tt)/w ;
y=[y1 -y1]
plot(t,y)