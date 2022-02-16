
recObj = audiorecorder(8192,8,1);
disp("Start Recording...");
recordblocking(recObj,10);
disp("Stop Recording...");
x = transpose(getaudiodata(recObj));
%soundsc(x,8192); %listen the original sound


M=5;
Ai=[0.35 0.5 0.65 0.05 0.15];
time = [0:1/8192:10-1/8192];
ti=[0.5 1.25 2.5 3 2.75];
echo = zeros(1,81920);

for i = 1:M
    for t = 0:1/8192:10-1/8192
        if t>=ti(i) %croping the signal
            echo(t*8192+1) = echo(t*8192+1) + Ai(i)*x((t-ti(i))*8192 +1); % summation operation
        end
    end
end
y = x + echo; %creating the final y(t) signal
%soundsc(y,8192); %listen echoed sound

%plots
figure
plot(time,x);
xlabel("time (second)");
ylabel("x(t)");
title("x(t) versus time");
figure
plot(time,y);
xlabel("time (seconds)");
ylabel("y(t)");
title("y(t) versus time");

Y=FT(y);
omega=linspace(-8192*pi,8192*pi,81921);
omega=omega(1:81920);
H=ones(1,81920);
for i = 1:M
    H = H + Ai(i)*exp(-1.0i*omega*ti(i)); %formula found in part b
end

h = IFT(H);
figure 
plot(time,h);
title("h(t) versus time");
xlabel("time (second)");
ylabel("h(t)");
figure
plot(omega,abs(H));
title("|H(jw)| versus omega");
xlabel("omega (rad/s)");
ylabel("|H(jw)|");

Xe = Y./H; %estimated X(jw)
xe = IFT(Xe);
soundsc(xe,8192);%listen estimated x(t)

figure
plot(time,xe);
title("xe(t) versus time");
xlabel("time (second)");
ylabel("xe(t)");


