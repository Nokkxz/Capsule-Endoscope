function du = pid_depth(X, W, dX, dW, X_t, W_t, dX_t, dW_t)
global PID

PID.Kp_X = 0.0003;
PID.Ki_X = 0;
PID.Kp_W = 0;
PID.Ki_W = 0;

du = [0,0,0,0].';
e_X = X_t(3) - X(3);
e_W = W_t(2) - W(2);

du1_p = -PID.Kp_X * (e_X - PID.e1_X) - PID.Kp_W * (e_W - PID.e1_W);
du1_i = -PID.Ki_X * e_X + PID.Ki_W * e_W;
du2_p = PID.Kp_X * (e_X - PID.e1_X);

du(1) = du1_p + du1_i;
du(4) = -du(1);
du(2) = du2_p;
du(3) = du(2);

PID.e2_X = PID.e1_X;
PID.e1_X = e_X;
PID.e2_W = PID.e1_W;
PID.e1_W = e_W;

end