function out = propagateState(oe0,t,t_0,MU,J2,Re)
%DESCRIPTION: Computes the propagated position and velocity in km, km/s
%accounting for approximate J2 perturbations

%Defining Orbit Elemets
a = oe0(1);
e = oe0(2);
i = oe0(3);
Omeg = oe0(4);
omeg = oe0(5);
f0= oe0(6);

%J2 Perturbations 
p = a*(1-e^2);
Omeg_dot = (3/2)*sqrt(MU/(a^3))*J2*(Re/p)^2*cos(i);
Omeg_f = Omeg_dot*(t-t_0)+ Omeg;
omeg_dot = (3/2)*sqrt(MU/(a^3))*J2*(Re/p)^2*(2-(5/2)*sin(i)^2);
omeg_f = omeg_dot*(t-t_0) + omeg;

%Time of flight & True Anomoly
%E0 = atan(tan(f/2)/sqrt((1+e)/(1-e)))*2;
 M = (t-t_0)/sqrt(a^3/MU);
x=0;  %Initial guess                             
nmax=1000;                           
eps=1;                                 
xvals=x;                                 
n=0;                                    
while eps>=1e-5&n<=nmax                      
    y=x-(x-e*sin(x)-M)/(1-e*cos(x)); 
    xvals=[xvals;y];                         
    eps=abs(y-x);                             
    x=y;n=n+1;                              
end                                           
f = atan(sqrt((1+e)/(1-e))*tan(x/2))*2 + f0;

%Pos and Vel Perifocal
r = p/(1+e*cos(f));
h = sqrt(MU*p);
p_r = [r*cos(f) r*sin(f) 0];
p_rdot = (MU/p)*[-sin(f) (e+cos(f)) 0];


%DCM
c1 = cos(Omeg_f);
s1 = sin(Omeg_f);
c2 = cos(i);
s2 = sin(i);
c3 = cos(omeg_f);
s3 = sin(omeg_f);
FR = [c1 s1 0;-s1 c1 0;0 0 1];
SR = [1 0 0;0 c2 s2;0 -s2 c2];
TR = [c1 s3 0;-s3 c3 0;0 0 1];
DCM = FR*SR*TR;
%DCM = TR*SR*FR;
DCM = angle2dcm(Omeg_f,i,omeg_f,'ZXZ');
%Perifocal to Inertial (ECI)
N_r = (DCM')*p_r';
N_rdot = (DCM')*p_rdot';

out = [N_r;N_rdot];
end




