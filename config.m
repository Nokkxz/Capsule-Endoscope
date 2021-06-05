global UUV ENV PID


PID.e1_X = 0;
PID.e1_W = 0;

ENV.T = 0.01;
ENV.vf = [0,0,0].';
ENV.p = 1000;
ENV.C = 1;

UUV.L = 0.045;
UUV.R = 0.0105;
UUV.Rt = 0.006;

%TBD
UUV.Tmax = 0.0001;
UUV.Tmin = -0.00001;

UUV.TxMax = UUV.Tmax*2;
UUV.TxMin = UUV.Tmin*2;
UUV.MtMax = (UUV.Tmax-UUV.Tmin)*UUV.Rt;
UUV.MtMin = -(UUV.Tmax-UUV.Tmin)*UUV.Rt;
UUV.NtMax = (UUV.Tmax-UUV.Tmin)*UUV.Rt;
UUV.NtMin = -(UUV.Tmax-UUV.Tmin)*UUV.Rt;

%TBD
UUV.M = 0.005 + 0.001*4;
UUV.Ix = 0.0007;
UUV.Iy = 0.0027;
UUV.Iz = UUV.Iy;

UUV.mu = 0;
UUV.mv = 0;
UUV.mw = 0;
UUV.ip = 0;
UUV.iq = 0;
UUV.ir = 0;

UUV.Mu = UUV.M+UUV.mu;
UUV.Mv = UUV.M+UUV.mv;
UUV.Mw = UUV.M+UUV.mw;
UUV.Ip = UUV.Ix+UUV.ip;
UUV.Iq = UUV.Iy+UUV.iq;
UUV.Ir = UUV.Iz+UUV.ir;

UUV.Sx = pi * UUV.R^2;
UUV.Sy = 2 * UUV.R * UUV.L;
UUV.Sz = UUV.Sy;

UUV.Cu = 0.5 * ENV.p * ENV.C * UUV.Sx;
UUV.Cv = 0.5 * ENV.p * ENV.C * UUV.Sy;
UUV.Cw = 0.5 * ENV.p * ENV.C * UUV.Sz;

%TBD
UUV.Cp = 0;
UUV.Cq = 0.00;
UUV.Cr = UUV.Cq;
