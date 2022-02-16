
%-----------------------------------LAB03----------------------------
%1.1 DTMF Transmitter
% phonenumber = [0 5 3 1 6 7 3 8 4 1 9];
% x = DTMFTRA(phonenumber);
% soundsc(x,8192);
% 
%--------------------------------------------------------------------------
% %1.2 DTMF Receiver
Number = [0 9 1 3]; %ID: 21703190
x = DTMFTRA(Number);
orgx = x;
soundsc(x,8192);

%-----------------first part of 1.2 DTMF Receiver--------------------------
X = FT(x);
omega=linspace(-8192*pi,8192*pi,8193);
omega=omega(1:8192);
figure;
plot(omega,abs(X));
xlabel('omega');
ylabel('magnitude of X');
title('Magnitude of X vs Omega');
grid ON;

%----------------second part of 1.2 DTMF Receiver--------------------------
%-----First Digit---------------
figure
r = [ones(1,2048),zeros(1,6144)];
x=x.*r;
X1 = FT(x);
plot(omega,abs(X1));
xlabel('omega');
ylabel('Magnitude of X1');
title('Magnitude of X1 vs Omega');
grid ON;
% %-----Second Digit--------------
x = orgx;
figure
r = [zeros(1,2048),ones(1,2048),zeros(1,4096)];
x=x.*r;
X2 = FT(x);
plot(omega,abs(X2));
xlabel('omega');
ylabel('Magnitude of X2');
title('Magnitude of X2 vs Omega');
grid ON;
% %-----Third Digit--------------
x = orgx;
figure
r = [zeros(1,4096),ones(1,2048),zeros(1,2048)];
x=x.*r;
X3 = FT(x);
plot(omega,abs(X3));
xlabel('omega');
ylabel('Magnitude of X3');
title('Magnitude of X3 vs Omega');
grid ON;
% %-----Fourth Digit--------------
x = orgx;
figure
r = [zeros(1,6144),ones(1,2048)];
x=x.*r;
X4 = FT(x);
plot(omega,abs(X4));
xlabel('omega');
ylabel('Magnitude of X4');
title('Magnitude of X4 vs Omega');
grid ON;

%------------------------------Functions-----------------------------------
function [x] = DTMFTRA (number)
    %matrix of frequencies 1,2,3...9,0
    freqs = [697,1209;697,1336;697,1477;770,1209;770,1336;770,1477;852,1209;852,1336;852,1477;941,1336];
    x = [] %creating an empty array
    for index = 1:length(number)
        starttime = (index-1)*0.25;
        t = [starttime:1/8192:starttime+0.25]%time interval with 1/8192 sample freq
        digit = number(index); %digit needs to be transmitted
        if digit == 0
            a=freqs(10,1);b=freqs(10,2);
        else
            a=freqs(digit,1);b=freqs(digit,2);
        end
        xc = cos(2*pi*a*t) + cos(2*pi*b*t); %create array in the given time interval
        x = cat(2,x,xc(2:length(xc)));%add the array for given time interval to final array
    end
end

