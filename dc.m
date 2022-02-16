%%vars
K = 0.01;
J = 0.01;
b = 0.1;
R = 1;
L = 0.5;



%% System you want to control
A=[-(b/J) K/J;
   -(K/L) R/L];
B=[0;1/L];
C=[1 0];

%% continuous-time state space
sys_cont = ss(A,B,C,0);

%% Sampling period
h = 0.05;

%% ZOH based discrete system
sys_disc= c2d(sys_cont, h);
phi = sys_disc.a
Gamma = sys_disc.b

%% controllability test
gamma = [Gamma phi*Gamma]
det(gamma)

%% Desired closed-loop poles
alpha = [0.1 0.1]

%% feedback gain
K = -acker(phi,Gamma,alpha)

%% feedforward gain
F = 1/(C*inv(eye(2)-phi-Gamma*K)*Gamma)

%% reference
r = 1;

%% initial conditions
x1(2) = 10.0; x1(1) = 10.0;x2(2) = 20.0; x2(1) = 20.0;
input(2) = 0; input(1) = 0;time(2) = h; time(1) = 0;
for i=2:2/h
u = K*[x1(i);x2(i)] + F*r;
xkp1 = phi*[x1(i);x2(i)]+ Gamma*u;
x1(i+1) = xkp1(1);
x2(i+1) = xkp1(2);
%-12 >= input >= 12??
u = min(max(u,-12),12);
input(i+1) = u;
time(i+1) = time(i) + h;
end
plot(time, x1, 'b');
max(input)