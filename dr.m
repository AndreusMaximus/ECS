%%vars
K_m = 4.4e-2
J_1 = 3.75e-6
J_2 = 3.75e-6
b   = 1e-5
k   = 0.2656
d   = 3.125e-5



%% System you want to control
A=[0 0 1 0;
   0 0 0 1;
   -(k/J_1) k/J_1 -((b-d)/J_1) ((b+d)/J_1);
   (k/J_2) -(k/J_2) ((b+d)/J_2) -((b-d)/J_2)
   ];
B=[0;0;K_m/J_1;0];
C=[1 1 0 0];

%% continuous-time state space
sys_cont = ss(A,B,C,0);

%% Sampling period
h = 0.05;

%% ZOH based discrete system
sys_disc= c2d(sys_cont, h);
phi = sys_disc.a
Gamma = sys_disc.b

%% controllability test
gamma = [Gamma phi*Gamma (phi^2)*Gamma (phi^3)*Gamma]
det(gamma)

%% Desired closed-loop poles
alpha = [0.1 0.1 0.1 0.1];

%% feedback gain
K = -acker(phi,Gamma,alpha)

%% feedforward gain
F = 1/(C*inv(eye(4)-phi-Gamma*K)*Gamma)

%% reference
r = 1;

%% initial conditions
x1(2) = 10.0; x1(1) = 10.0;  x2(2) = 20.0; x2(1) = 20.0;x3(2) = 10;x3(1) = 10;x4(2) = 10; x4(1) = 10; 
input(3) = 0; input(4) = 0; input(2) = 0; input(1) = 0;time(2) = h; time(1) = 0;
for i=2:2/h
u = K*[x1(i);x2(i);x3(i);x4(i)] + F*r;
xkp1 = phi*[x1(i);x2(i);x3(i);x4(i)]+ Gamma*u;
x1(i+1) = xkp1(1);
x2(i+1) = xkp1(2);
x3(i+1) = xkp1(3);
x4(i+1) = xkp1(4);
%-12 >= input >= 12??
%u = min(max(u,-12),12);
input(i+1) = u;
time(i+1) = time(i) + h;
end
plot(time, x1, 'b');
max(input)