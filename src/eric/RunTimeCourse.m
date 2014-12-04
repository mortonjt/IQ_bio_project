clear,clc

conc(1,:)=xlsread('Inhib Values.xlsx','0hr','B2:K2');
conc(2,:)=xlsread('Inhib Values.xlsx','0hr','M2:V2');
conc(3,:)=xlsread('Inhib Values.xlsx','0hr','X2:AG2');
conc(4,:)=xlsread('Inhib Values.xlsx','0hr','AI2:AR2');
conc(5,:)=xlsread('Inhib Values.xlsx','0hr','AT2:BC2');
conc(6,:)=xlsread('Inhib Values.xlsx','0hr','BE2:BN2');

equ_fract=.21;
egf_fract=.48;

%Load model values
global conc2
params=xlsread('simplified values.xlsx','Values2','I2:I57');
initial_conditions=xlsread('simplified values.xlsx','Values2','E2:E26');
conc2=conc(:,1);
ERKt=initial_conditions(11)+initial_conditions(12);
%%
params=xlsread('simplified values.xlsx','Values2','I2:I57');
%tic
for i=1:2
EGF_conc=100;
if i==1,EGF_conc=0;end
inhib=[1,1];
%conc2(inhib(1))=inhib(2);
time_course=0:730;
te=10;
tp=370;
[time, y_vals(:,:,i)]=func2_TimeCourse(params,initial_conditions,EGF_conc,inhib,time_course,te,tp);
end

figure
plot(y_vals(:,11,1),'b')
hold all
plot(y_vals(:,11,2),'g')
hold all
line(get(gca,'Xlim'),[ERKt*equ_fract ERKt*equ_fract],'color','k','linestyle','--')
hold all
line(get(gca,'Xlim'),[ERKt*egf_fract ERKt*egf_fract],'color','k','linestyle',':')
legend('equ simulation','EGF simulation','equilibrium','100pM egf')
%toc
%%

vis=17;
figure
plot(y_vals(:,vis,1),'b')
hold all
plot(y_vals(:,vis,2),'g')




%%
opts=optimset('Display','iter','MaxFunEvals',1e2,'MaxIter',5e1);
fract=[equ_fract; egf_fract];
EGF_conc=[0; 100e-12];%in Molar
tf=[600 700 800];
inhib=[1,1];
conc2(inhib(1))=inhib(2);

time_course = 0:801;
tp=1;te=500;
res=fminsearch(@(params) func3_fmin(params,initial_conditions,EGF_conc,inhib,time_course,te,tp,fract,tf),params,opts);

save





