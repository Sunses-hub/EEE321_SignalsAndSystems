
%Lab 05 

%------------------------------Part 3--------------------------------------

% dur = rem(21703190,5);
% if dur == 0
%     dur =2
% end
% Ts= dur/3;
% t=[-dur/2:Ts/1000:dur/2-Ts/1000];
% %Zero Order Hold Interpolation
% pz = generateInterp(0,Ts,dur);
% plot(t,pz);
% title("Zero Order Hold Interpolation");
% xlabel("time(s)");
% ylabel("pZ(t)");
% figure;
% %Linear Interpolation
% pl = generateInterp(1,Ts,dur);
% plot(t,pl);
% title("Linear Interpolation");
% xlabel("time(s)");
% ylabel("pL(t)");
% figure;
% %Ideal Bandlimited Interpolation
% pI = generateInterp(2,Ts,dur);
% plot(t,pI);
% title("Ideal Bandlimited Interpolation");
% xlabel("time(s)");
% ylabel("pI(t)");

%---------------------------End of Part 3----------------------------------
%--------------------------------Part 5------------------------------------
% a = randi([2 6],1)
% Ts = 1/(25*a);
% dur=10;
% Ti=Ts/1000;
% t = [-dur/2:Ts:dur/2-Ts]; %for digital signal
% ta=[-dur/2:Ts/1000:dur/2-Ts/1000];%for analog signal
% g=zeros(1,length(t));
% g(-1<=t & t<0) = -1;
% g(0<t & t<=1) = 1;
% 
% %Sampled signal
% stem(t,g);
% title("Stem of g(nTs)");
% ylabel("g(nTs)");
% xlabel("(unitless)");
% figure;
% %Generation of gR(t) for each interpolating method
% gR1=DtoA(0,Ts,dur,g);
% plot(linspace(-5,5,length(gR1)),gR1);
% title("Zero Order Hold Reconstruction");
% ylabel("gR(t)");
% xlabel("time(s)");
% figure;
% gR2=DtoA(1,Ts,dur,g);
% plot(linspace(-5,5,length(gR2)),gR2);
% title("Linear Reconstruction");
% ylabel("gRt)");
% xlabel("time(s)");
% figure;
% gR3=DtoA(2,Ts,dur,g);
% plot(linspace(-5,5,length(gR3)),gR3);
% title("Ideal Bandlimited Reconstruction");
% ylabel("gRt)");
% xlabel("time(s)");
% 

%-------------------------------------Part 6-------------------------------

D5 = rem(21703190,5);
%Ts = 0.005*(D5+1);
%Ts=0.25+0.01*D5
Ts=0.18+0.005*(D5+1)
%Ts=0.099
dur=4;
ta=[-dur/2:Ts/1000:dur/2-Ts/1000]; %analog (continous-time) signal
td=[-dur/2:Ts:dur/2-Ts];%digital (discrete-time) signal
xa=0.25*cos(2*pi*3*ta+pi/8)+0.4*cos(2*pi*5*ta-1.2)+0.9*cos(2*pi*ta+pi/4);
xd=0.25*cos(2*pi*3*td+pi/8)+0.4*cos(2*pi*5*td-1.2)+0.9*cos(2*pi*td+pi/4);

plot(ta,xa,'r');
title("x(t) and x(nTs)");
xlabel("time (s)");
ylabel("x(t) and x(nTs)");
hold on;
stem(td,xd,'b');
hold off;
figure;
%Zero Order Hold
xR1=DtoA(0,Ts,dur,xd);
plot(linspace(-dur/2,dur/2,length(xR1)),xR1);
title("Zero Order Hold Interpolation");
xlabel("time (s)");
ylabel("xR(t)");
figure;
xR2=DtoA(1,Ts,dur,xd);
plot(linspace(-dur/2,dur/2,length(xR2)),xR2);
title("Linear Interpolation Interpolation");
xlabel("time (s)");
ylabel("xR(t)");
figure;
xR3=DtoA(2,Ts,dur,xd);
plot(linspace(-dur/2,dur/2,length(xR3)),xR3);
title("Bandlimited Interpolation");
xlabel("time (s)");
ylabel("xR(t)");


function p = generateInterp(type,Ts,dur)
    Ti = Ts/1000;
    t=[-dur/2:Ts/1000:dur/2-Ts/1000];
    p=zeros(1,length(t));
    if type == 0
        p(-Ts/2 <= t & t < Ts/2)=1;
    elseif type == 1
        p(-Ts <= t & t <= Ts) = 1-abs(t(-Ts <= t & t <= Ts))/Ts;
    elseif type == 2
        p=sin(pi*t/Ts)./(pi*t/Ts);
        p(t==0)=1;
    else
        disp("invalid type")
    end
end
% %-----------------------------------Part 4---------------------------------
function xR=DtoA(type,Ts,dur,Xn)
    Ti=Ts/1000;
    dur =dur*Ts;
    ta=[-dur/2:Ti:dur/2-Ti];
    N = length(Xn);
    p=generateInterp(type,Ts,dur);
    xR=zeros(1,round((dur+(N-1)*Ts)/Ti));
    for n = 0:N-1
        xR(1+round(n*Ts/Ti):round((dur+n*Ts)/Ti)) = xR(1+round(n*Ts/Ti):round((dur+n*Ts)/Ti))+Xn(n+1)*p;
    end
end
    
        
        
        