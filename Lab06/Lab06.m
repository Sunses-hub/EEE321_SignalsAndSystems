
%Part 2
D = 21703190;
D5 = rem(D,6);

a = 0;
M = 4 + D5;
k = [0:M-1];
b = exp(-k);
x = [1,zeros(1,10)];
h = DTLTI(a,b,x,length(x));

%part a
stem(h);
title('h[n]');
figure;

%part e
freqs = [-pi:1/1000:pi-1/1000];
Hfourier = (1-exp(-M*(1i*freqs+1)))./(1-exp(-(1i*freqs+1)));
plot(freqs,abs(Hfourier));
title('|H(exp(jw))| vs Frequency (Hz)');
xlim([-pi,pi]);
xlabel('Frequency (Hz)');
ylabel('|H(exp(jw))|');
figure;

%part f
chirp1 = chirpCalculator(0,1000,1,2000);
freqs = linspace(0,pi,length(chirp1));
y1 = DTLTI(a,b,chirp1,length(chirp1));
subplot(1,3,1);
plot(freqs,abs(y1));
title('for t in [0,1]');
xlabel('Frequency (Hz)');
ylabel('Output Signal');
xlim([0,pi]);


chirp2 = chirpCalculator(0,1000,10,2000);
freqs2 = linspace(0,pi,length(chirp2));
y2 = DTLTI(a,b,chirp2,length(chirp2));
subplot(1,3,2);
plot(freqs2,abs(y2));
title('for t in [0,10]');
xlabel('Frequency (Hz)');
xlim([0,pi]);


chirp3 = chirpCalculator(0,1000,1000,2000);
freqs3 = linspace(0,pi,length(chirp3));
y3 = DTLTI(a,b,chirp3,length(chirp3));
subplot(1,3,3);
plot(freqs3,abs(y3));
title('for t in [0,1000]');
xlabel('Frequency (Hz)');
xlim([0,pi]);
figure;

%Part 4
%my ID is 21703190 so

n8 = 0;
n1 = 2;
n3 = 7;
n6 = 1;
n4 = 0;
n5 = 3;

z1 = (n1+1i*n8)/(sqrt(n1^2+n8^2));
p1 = (n3+1i*n6)/(sqrt(1+n3^2+n6^2));
p2 = (n4+1i*n5)/(sqrt(1+n4^2+n5^2));

%part g
w = [-pi:1/1000:pi-1/1000];
Hfourier = (1-z1*exp(-1i*w))./((1-p1*exp(-1i*w)).*(1-p2*exp(-1i*w)));
plot(w,abs(Hfourier));
title('Magnitude Response');
ylabel('Magnitude');
xlabel('Frequency (Hz)');
xlim([-pi,pi]);
figure;

%part h
a = [(p1+p2), -p1*p2];
b = [1,-z1];

chirpp1 = chirpCalculator2(-500,500,1,1000);
omegas1 = linspace(-pi,pi,length(chirpp1));
output1 = DTLTI(a,b,chirpp,length(chirpp1));
subplot(2,2,1);
plot(omegas1,abs(output1));
title('Magnitude Response for t = 1 [-500,500] Hz');
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-pi,pi]);
subplot(2,2,3);
plot(omegas1,angle(output1));
title('Phase Response for t = 1');
ylabel('Phase Angle')
xlabel('Frequency (Hz)')
xlim([-pi,pi]);

chirpp2 = chirpCalculator2(-400,600,1,600);
omegas2 = linspace(-pi,pi,length(chirpp2));
output2 = DTLTI(a,b,chirpp2,length(chirpp2));
subplot(2,2,2);
plot(omegas2,abs(output2));
title('Magnitude Response for t = 1 [-400,600] Hz');
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-pi,pi]);
subplot(2,2,4);
plot(omegas2,angle(output2));
title('Phase Response for t = 1');
ylabel('Phase Angle')
xlabel('Frequency (Hz)')
xlim([-pi,pi]);


function [x] = chirpCalculator(f0,f_end, t_end, fs)
    t = [0:1/fs:t_end-1/fs];
    k = (f_end-f0)/t_end;
    x = cos(2*pi*(k*(t.^2)/2 + f0*t));
end

function [x] = chirpCalculator2(f0,f_end, t_end, fs)
    t = [0:1/fs:t_end-1/fs];
    k = (f_end-f0)/t_end;
    x = exp(2i*pi*(k*(t.^2)/2 + f0*t));
end
    
    
%Part 1
function [y] = DTLTI(a,b,x,Ny)
    y = zeros(1,Ny);
    M = length(b)-1;
    N = length(a);
    for n = 0:Ny-1
        for l = 1:N 
            if (n-l) >= 0
                y(n+1) = a(l)*y(n-l+1) + y(n+1);
            end
        end
        
        for k = 0:M
            if (n-k) >= 0
                y(n+1) = b(k+1)*x(n-k+1) + y(n+1);
            end
        end
    end
end
%End of Part 1
    