clear 
clc
close all

%%  Analysis



%% HH proces
load('anova_AVR_.mat')
load('G0AVR_.mat')
load('G3AVR_.mat')
load('G7AVR_.mat')
load('performance_AVR_best_MH.mat')
ffit=Graphics('Fig1');
boxplot(An',{'0','2','3','5','7'})
hold on
plot(Per,'o--k')
xlabel('Steps')
ylabel('Fitness')
%ylim([0 11])
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
setup(ffit);
setsize(ffit,2,[4,2]);
setfont(ffit,12)



%% 
%x=[1.01295047537750	2.03201768041377	2.28681415847675	0.860567898064591	2.19639002112310	2.11367935771301	0.859752548680420	0.663327663766490	0.619922269774622	0.838141287060858	0.893496415822300	0.947289919961679	1.28153545961570	0.657739835377855	0.861890522024934	1.57956682077431	1.06694214868347	0.914203476292532	1.04763026629366	1.09650591759480];
%y=[0.486584926023820	0.483457052606790	0.566876968188730	0.417129954936755	0.347896035674915	0.454407465611150	0.508016335880413	0.335887366095291	0.531153160247976	0.678768910942790	0.510110820137941	0.438544743431312	0.467355359211529	0.642913665243777	0.374553969905356	0.479661612340359	0.462639286464455	0.504680353284888	0.482996396055577	0.535426766402697];
fit=G7AVR_;
iter = 0:60;
ffit=Graphics('Fig1');
for i=1:20
    plot(iter,fit(:,i),'b')
    hold on
end
xlabel('Iteration')
ylabel('Fitness')
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
setup(ffit);
setsize(ffit,2,[4,2]);
setfont(ffit,12)
%ylim([0 20])
xlim([0 40])
%%
subplot('Position', [0.1, 0.15, 0.65, 0.75]); % 
for i=1:20
    plot(iter,fit(:,i),'b')
    hold on
end
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
ylim([0 20])
xlim([0 40])
xlabel('Iteration')
ylabel('Fitness')
subplot('Position', [0.8, 0.15, 0.15, 0.75]); % Más angosto
boxplot(x,{'0'})
set(gca, 'FontSize', 12, 'YTickLabel', {});
xlabel('Step')
ylim([0 20])
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
setup(ffit);
setsize(ffit,2,[6,4]);
setfont(ffit,12)

%%
 kg=0.7:0.001:1;
 Tg=linspace(1,2,length(kg));
 kkg=meshgrid(kg);
 Tgg=meshgrid(Tg);
 L_kg=zeros(size(kkg));
 Ts_kg=L_kg;
 Tr_kg=Ts_kg;
 delta_t_kg=Ts_kg;
 Gm_kg=delta_t_kg;
 Pm_kg=Gm_kg;
 Ess_kg=Pm_kg;
Ga=tf(10,[0.1 1]);
Ge=tf(1,[0.4 1]);
for i=1:length(kg)
    for j=1:length(kg)
        Gg =tf(kkg(i,j),[Tgg(i,j) 1]);
        G1 =tf(Ga*Ge*Gg);
        Gs= tf(1,[0.01 1]);
        G=feedback(G1,Gs);
        H=stepinfo(G,"SettlingTimeThreshold",0.02); %"SettlingTimeThreshold",0.05
        L_kg(i,j)= H.Overshoot;
        Ts_kg(i,j)=H.SettlingTime;
        Tr_kg(i,j)=H.RiseTime;
        delta_t_kg(i,j)=Ts_kg(i,j)-Tr_kg(i,j);
        [Gm_kg(i,j),Pm_kg(i,j),~,~] = margin(G);
        Ess_kg(i,j)=1-vout(end);
    end
end
%%
ffit=Graphics('Fig1');
mesh(kkg,Tgg,L_kg)
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
setup(ffit);
setsize(ffit,2,[6,4]);
setfont(ffit,12)
%%
ffit=Graphics('Fig1');
N=1;
boxplot(An,{'k$_p$','k$_i$','k$_d$','$\lambda$','$\mu$','Fobj'})
ylabel('Value')
 %yscale('log')
setup(ffit);
setsize(ffit,2,[4,2]);
setfont(ffit,12)
%%
%% 

ffit=Graphics('Fig1');
subplot('Position', [0.1, 0.15, 0.65, 0.75]); % 
boxplot(Const,{'k$_p$','k$_i$','k$_d$','$\lambda$','$\mu$'})
ylabel('Value')
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
subplot('Position', [0.8, 0.15, 0.15, 0.75]);boxplot(Fit,{'MH$_*$'})
%set(gca, 'FontSize', 12, 'YTickLabel', {});
ylabel('Fitness')
ylim([min(Fit)-0.05,0.5])
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
setup(ffit);
setsize(ffit,2,[6,4]);
setfont(ffit,12)


