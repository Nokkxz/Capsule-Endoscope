function K = lqr_depth()

global UUV

A = [0 0 1 0;
     0 0 0 1;
     0 -0.707*UUV.TxMax/UUV.Mw 0 0;
     0 0 0 0];

B = [0 0 0;
     0 0 0;
     0.707/UUV.Mw 0 0;
     0 1/UUV.Iq 0];

Q = [1 0 0 0;%z
     0 1 0 0;%b
     0 0 0 0;%dz
     0 0 0 0];%db

R = [1e4 0 0;
     0 1e11 0;
     0 0 1e11];
 
K = lqr(A,B,Q,R);

end