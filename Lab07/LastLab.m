
%Part 2
load Part2

% % plot(t,r);
% % title(" r(t) vs t ");
% % xlabel("t (s)");
% % ylabel("r(t)");
% % figure;
% 
% % R = FT(r);
% % plot(omega,abs(R));
% % title(" R(w) vs w ");
% % xlabel("w (rad/s)");
% % ylabel(" R(w) ");
% 
% soundsc(r,262144);

%ListenToMyRadio(r,40000,t,omega);%fc2 message
%ListenToMyRadio(r,55000,t,omega);%fc1 message
%ListenToMyRadio(r,25000,t,omega);%fc3 message

%ListenToMyRadio(r,55000,t,omega);

%Part 3 

load Part2

%part b
R=FT(r);
W=[zeros(1,length(R(omega<=-2*pi*44100))),R(-2*pi*44100<omega & omega<-2*pi*35900),zeros(1,length(R(-2*pi*35900<=omega & omega <= 2*pi*35900))), R(2*pi*35900<omega & omega<2*pi*44100),zeros(1,length(R(omega>=2*pi*44100)))];
w=IFT(W); % w(t)

%part c
plot(omega,abs(W));
title(" |W(w)| vs w (rad/s) ");
ylabel("|W(w)|");
xlabel("w (rad/s)");
figure;

%part d
%ListenToMyRadio(w,40000,t,omega);

%part e
Q = [zeros(1,length(W(omega<=-2*pi*40000))),W(-2*pi*40000<omega & omega<2*pi*40000),zeros(1,length(W(2*pi*40000<=omega)))];
q = IFT(Q); % q(t)
plot(omega,abs(Q));
title(" |Q(w)| vs w (rad/s) ");
xlabel("w (rad/s)");
ylabel("|Q(w)|");
%part g
%ListenToMyRadio(w,40000,t,omega);


function [] = ListenToMyRadio(r,fc,t,omega)
    B=2*pi*8200;
    d=r.*cos(2*pi*fc*t);
    D=FT(d);
    M=[zeros(1,length(D(omega<=-2*pi*4100))),D(abs(omega)<2*pi*4100),zeros(1,length(D(omega>=2*pi*4100)))];
    m=IFT(M);
    soundsc(m,262144);   
    %plot statements
    subplot(1,2,1);
    plot(t,r);
    title(" r(t) vs t ");
    ylabel(" r(t) ");
    xlabel(" t (s) ");
    subplot(1,2,2);
    plot(omega,abs(FT(r)));
    title(" |R(w)| vs w (rad/s) ");
    ylabel(" |R(w)| ");
    xlabel(" w (rad/s) ");
    figure;

    subplot(1,2,1);
    plot(t,m);
    title(" m(t) vs t ");
    ylabel(" m(t) ");
    xlabel(" t (s) ");
    subplot(1,2,2);
    plot(omega,abs(FT(m)));
    title(" |M(w)| vs w (rad/s) ");
    ylabel(" |M(w)| ");
    xlabel(" w (rad/s) ");
    figure;


    subplot(1,2,1);
    plot(t,d);
    title(" d(t) vs t ");
    ylabel(" d(t) ");
    xlabel(" t (s) ");
    subplot(1,2,2);
    plot(omega,abs(FT(d)));
    title(" |D(w)| vs w (rad/s) ");
    ylabel(" |D(w)| ");
    xlabel(" w (rad/s) ");
end