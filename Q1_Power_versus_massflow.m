w=Solution('argon.xml');

DT=[];
m=[];
DT(1)=0;
DT(100)=150;
m(1)=0.01;
m(100)=1;
m(200)=2;
DT(200)=0;
for i = 2:99
    t= -0.50*i+200;
    mi=0.01*i;
    DT(i)=t;
    m(i)=mi;
end
%y=-150x+300;
for i = 101:199
    t= -1.5*i+300;
    mi=0.01*i;
    DT(i)=t;
    m(i)=mi;
end
%plot(m,DT);
n=[];  
Power = [];

P1=50*10e+03;
T1=273.15-20;
set(w,'P',P1,'T',T1);
s1=entropy_mass(w);
h1=enthalpy_mass(w);

P2=6*P1;
s2=s1;
set(w, 'P', P2, 'S', s2);
T2=temperature(w);
h2=enthalpy_mass(w);
e=T2-273.15;

for j=1:200
    t1=DT(j)+e;
    tk=t1+273.15;
    set(w,'P',P2,'T',tk);
    h3=enthalpy_mass(w);
    s3=entropy_mass(w);
    
    s4=s3;
    setState_SP(w,[s4,P1]);
    h4=enthalpy_mass(w);
    
    qin=(h3-h2);
    qout=(h4-h1);
    Power(j)=(qin-qout)*m(j);
    n(j)=round((qin-qout)/qin,5);
end

%plot(m, Power)
%plot(m,n);
transpose(DT)
plot(m,Power);
