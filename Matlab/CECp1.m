kp=[0.643,1.128,1.042,1.777,1.949];
ki=[0.438,0.956,1.009,0.382,0.318];
kd=[0.205,0.567,0.599,0.318,0.342];
format long
warning off
ffit=Graphics('Fig1');

for i=1:length(kp)
Ga=tf(10,[0.1 1]);
Ge=tf(1,[0.4 1]);
Gg=tf(1,[1 1]);
G1 = (Ga*Ge*Gg);
Gs=tf(1,[0.01 1]);
Gc=pid(kp(i),ki(i),kd(i));
G=feedback(G1*Gc,Gs);
Tss=0.001;
t=0:Tss:8;
[vout,tout]=step(G,t);
plot(tout,vout,LineWidth=1.1)
hold on
end
legend({'MH$_*$','IKA','TSA','PSO','DEA'})
xlim([0 4])
xlabel('Time [s]')
ylabel('Output voltage change [p.u]')
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
setup(ffit);
setsize(ffit,2,[4,2]);
setfont(ffit,12)