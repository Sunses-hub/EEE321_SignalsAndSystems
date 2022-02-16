t = [0:1/8192:1];
f = 493.88;
x = cos(2*pi*f*t);
plot(t,x);
sound(x);