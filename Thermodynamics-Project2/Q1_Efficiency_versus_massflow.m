w=Solution('argon.xml');

T=[];
m=[];
T(1)=200;
T(100)=150;
m(1)=0;
m(100)=1;

for i = 2:99
    t=-0.50*i+200;
    mi=0.01*i;
    T(i)=t;
    m(i)=mi;
end
%y=-150x+300;
for i = 101:200
    t=-1.50*i+300;
    mi=0.01*i;
    T(i)=t;
    m(i)=mi;
end
plot(m,T);


n=[];


P1=50*10^3;
T1=273-20;
set(w,'P',P1,'T',T1);
s1=entropy_mass(w);
h1=enthalpy_mass(w);

P2=6*P1;
s2=entropy_mass(w);
setState_SP(w,[s2,P2]);
T2=temperature(w);
h2=enthalpy_mass(w);

W=h2-h1;

for j=1:200
    t1=T(j)+T2;
    set(w,'P',P2,'T',t1);
    h3=enthalpy_mass(w);
    s3=entropy_mass(w);
    
    s4=s3;
    setState_SP(w,[s4,P1]);
    h4=enthalpy_mass(w);
    
    qin=(h3-h2);
    qout=(h4-h1);
    w_turbine = h3 - h4;
    w_compressor = h2 - h1;
    
    w_net = w_turbine - w_compressor;
    q = h3 - h2;
    n(j)= w_net/q;
end
max(n)
plot(m,n);