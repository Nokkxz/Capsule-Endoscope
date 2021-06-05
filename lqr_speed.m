function [K, W_t] = lqr_speed(dX_t)

global UUV

a = 0;
b = atan(-dX_t(3)/dX_t(1));
c = atan(dX_t(2)/dX_t(1));
W_t = [a,b,c].';

Tv = [
    cos(c)*cos(b), -cos(a)*sin(c)+cos(c)*sin(a)*sin(b), sin(c)*sin(a)+cos(c)*cos(a)*sin(b);
    sin(c)*cos(b), cos(c)*cos(a)+sin(c)*sin(a)*sin(b), -cos(c)*sin(a)+cos(a)*sin(c)*sin(b);
    -sin(b), cos(b)*sin(a), cos(b)*cos(a)
    ];
dX_ = Tv\dX_t;
Ru = -UUV.Cu*abs(dX_(1))*dX_(1);

Tx_h = UUV.TxMax + Ru;

A = [
    0 0 0 -sin(b)*cos(c)*Tx_h/UUV.Mu -sin(c)*cos(b)*UUV.TxMax/UUV.Mu 0 0;
    0 0 0 -sin(b)*sin(c)*Tx_h/UUV.Mv cos(b)*cos(c)*UUV.TxMax/UUV.Mv 0 0;
    0 0 0 -cos(b)*Tx_h/UUV.Mw 0 0 0;
    0 0 0 0 0 1 0;
    0 0 0 0 0 0 1;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
    ];

B = [
    cos(c)*cos(b)/UUV.Mu 0 0;
    sin(c)*cos(b)/UUV.Mv 0 0;
    -sin(b)/UUV.Mw 0 0;
    0 0 0;
    0 0 0;
    0 1/UUV.Iq 0;
    0 0 1/UUV.Ir;
    ];

Q = [
    1 0 0 0 0 0 0;%dx
    0 1 0 0 0 0 0;%dy
    0 0 1 0 0 0 0;%dz
    0 0 0 1 0 0 0;%b
    0 0 0 0 1 0 0;%c
    0 0 0 0 0 0 0;%db
    0 0 0 0 0 0 0;%dc
    ];

R = [
    1e3 0 0;
    0 1e11 0;
    0 0 1e11;
    ];
    

K = lqr(A,B,Q,R);

end