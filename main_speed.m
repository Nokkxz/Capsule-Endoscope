%% LQR
clc;clear;
run('config.m')

it = 90000;
X_buff = zeros(it,3);
W_buff = zeros(it,3);
dX_buff = zeros(it,3);
dW_buff = zeros(it,3);
u_buff = zeros(it,3);

X = [0,0,0].';
W = [0,0,0].';
dX = [0,0,0].';
dW = [0,0,0].';
u = [0,0,0,0].';

dX_t1 = [0.01,-0.01,0.01].';

dX_t1 = dX_t1+dX_t1.*[0.2,0.2,-0.1].';
[K1, W_t1] = lqr_speed(dX_t1);

dX_t2 = dX_t1.*[1,-1,-1].';
[K2, W_t2] = lqr_speed(dX_t2);

for i = 1:it
    X_buff(i,:) = X.';
    W_buff(i,:) = W.';
    dX_buff(i,:) = dX.';
    dW_buff(i,:) = dW.';
    if i<it/3
        K = K1;
        W_t = W_t1;
        dX_t = dX_t1;
    else
        K = K2;
        W_t = W_t2;
        dX_t = dX_t2;
    end
    u = K*[dX_t - dX; W_t(2:3) - W(2:3); [0;0] - dW(2:3)];
    [X,W,dX,dW,u_r] = dynamics(X,W,dX,dW,u);
    u_buff(i,:) = u_r.';
end

dt = 0.333;
t = 1:dt:(it*dt+dt);

figure(1)
subplot(3,1,1)
plot(t,dX_buff(1:length(t),1))
grid on
ylabel('Vx(m/s)')
subplot(3,1,2)
plot(t,dX_buff(1:length(t),2))
grid on
ylabel('Vy(m/s)')
subplot(3,1,3)
plot(t,dX_buff(1:length(t),3))
grid on
xlabel('Time(ms)')
ylabel('Vz(m/s)')

figure(2)
plot(t,W_buff(1:length(t),:))
grid on
xlabel('Time(ms)')
ylabel('Angle(rad)')
legend('Raw','Pitch','Yaw')


% figure(3)
% plot(u_buff)
% grid on
% 
% figure(4)
% plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
% grid on

X_buff = X_buff.*0.2;
figure(5)
plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
for i=1:3000:it
    drawUUV(X_buff(i,:).',W_buff(i,:).');
end

%% animation
figure(5)
for i=1:100:it
    if strcmpi(get(gcf,'CurrentCharacter'),'q')
        break
    end
    clf
    plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
    drawUUV(X_buff(i,:).',W_buff(i,:).');
%     pause(0.1);
    drawnow
end
