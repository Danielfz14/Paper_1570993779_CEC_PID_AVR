function fcost=AVR_PID_CEC_p1(kp,ki,kd)
format long
warning off
Ga=tf(10,[0.1 1]);
Ge=tf(1,[0.4 1]);
Gg=tf(1,[1 1]);
G1 = (Ga*Ge*Gg);
Gs=tf(1,[0.01 1]);
Gc=pid(kp,ki,kd);
G=feedback(G1*Gc,Gs);
Tss=0.001;
t=0:Tss:8;
[vout,tout]=step(G,t);
H=stepinfo(vout,tout,1);
Tr=H.RiseTime;
Ts=H.SettlingTime;
L = H.Overshoot/100;
if isnan(L), L=100; end , if isnan(Ts),  Ts=100 ; end , if isnan(Tr),  Tr=100 ; end
ye=vout(end-0.1*length(vout):end);
E=abs(1-sum(ye)/length(ye));
time_weighted_absolute_error = t .* abs(ye-ones(size(ye)));
ITAE = sum((time_weighted_absolute_error(2:end) + time_weighted_absolute_error(1:end-1)) / 2) * Tss;
fcost=0.3*abs(L+E)+0.7*abs(Ts-Tr)+0.001*ITAE;
end