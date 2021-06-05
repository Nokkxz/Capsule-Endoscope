function [Xo, Wo, dXo, dWo, u_r] = dynamics(X, W, dX, dW, u)
% X=[x,y,z]  W=[roll,pitch,yaw]  u=[Tx,Mt,Nt]

global UUV ENV

% Transfer Matrix
a=W(1); b=W(2); c=W(3);
Tv = [
    cos(c)*cos(b), -cos(a)*sin(c)+cos(c)*sin(a)*sin(b), sin(c)*sin(a)+cos(c)*cos(a)*sin(b);
    sin(c)*cos(b), cos(c)*cos(a)+sin(c)*sin(a)*sin(b), -cos(c)*sin(a)+cos(a)*sin(c)*sin(b);
    -sin(b), cos(b)*sin(a), cos(b)*cos(a)
    ];
% Tw = [
%     1, tan(b)*sin(a), tan(b)*cos(a);
%     0, cos(a), -sin(a);
%     0, sin(a)/cos(b), cos(a)/cos(b)
%     ];

% Thruster
Tx = u(1);
Ty = 0;
Tz = 0;
Kt = 0;
Mt = u(2);
Nt = u(3);

if Tx>(UUV.TxMax)
    Tx = UUV.TxMax;
elseif Tx<(UUV.TxMin)
    Tx = UUV.TxMin;
end
if Mt>(UUV.MtMax)
    Mt = UUV.MtMax;
elseif Mt<(UUV.MtMin)
    Mt = UUV.MtMin;
end
if Nt>(UUV.Tmax*UUV.Rt)
    Nt = UUV.Tmax*UUV.Rt;
elseif Nt<(-UUV.Tmax*UUV.Rt)
    Nt = -UUV.Tmax*UUV.Rt;
end

u_r = [Tx,Mt,Nt].';

% dX in UUV frame & dW
dX_ = Tv\dX;
u = dX_(1); v = dX_(2); w = dX_(3);
p = dW(1); q = dW(2); r = dW(3);

% Resistance
dXf_ = dX_ - Tv\ENV.vf;
Ru = -UUV.Cu*abs(dXf_(1))*dXf_(1);
Rv = -UUV.Cv*abs(dXf_(2))*dXf_(2);
Rw = -UUV.Cw*abs(dXf_(3))*dXf_(3);
Rp = -UUV.Cp*abs(p)*p;
Rq = -UUV.Cq*abs(q)*q;
Rr = -UUV.Cr*abs(r)*r;

% ddX & ddW in UUV frame
du = (Tx+Ru)/UUV.Mu + r*v - q*w;
dv = (Ty+Rv)/UUV.Mv + p*w - r*u;
dw = (Tz+Rw)/UUV.Mw + q*u - p*v;
dp = (Kt+Rp)/UUV.Ip;
dq = (Mt+Rq + (UUV.Ir-UUV.Ip)*r*p)/UUV.Iq;
dr = (Nt+Rr + (UUV.Ip-UUV.Iq)*p*q)/UUV.Ir;

% Result in world frame
ddX_ = [du,dv,dw].';
ddW = [dp,dq,dr].';
dXo = Tv*(dX_ + ENV.T*ddX_);
dWo = (dW + ENV.T*ddW);
Xo = X + ENV.T*dX;
Wo = W + ENV.T*dW;

end