function u = thruster_calc(u_t)
% Thruster 1234 to [Tx,Mt,Nt]

global UUV

u = [u_t(1)+u_t(2)+u_t(3)+u_t(4), (u_t(1)-u_t(4))*UUV.Rt, (u_t(3)-u_t(2))*UUV.Rt].';

end