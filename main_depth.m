%% PID
clc;clear;
run('config.m')

it = 15000;
X_buff = zeros(it,3);
W_buff = zeros(it,3);
dX_buff = zeros(it,3);
dW_buff = zeros(it,3);
u_buff = zeros(it,3);

X = [0,0,0].';
W = [0,0,0].';
dX = [0,0,0].';
dW = [0,0,0].';
u_t = [0,0,0,0].';

X_t = [0,0,0.1].';
W_t = [0,-0.707,0].';
dX_t = [0,0,0].';
dW_t = [0,0,0].';

for i = 1:it
    X_buff(i,:) = X.';
    W_buff(i,:) = W.';
    dX_buff(i,:) = dX.';
    dW_buff(i,:) = dW.';
    
    du_t = pid_depth(X,W,dX,dW,X_t,W_t,dX_t,dW_t);
    u_t = u_t + du_t;
    u = thruster_calc(u_t);
    [X,W,dX,dW] = dynamics(X,W,dX,dW,u);
    u_buff(i,:) = u.';
end

X_buff(:,1) = X_buff(:,1).*0.7;

dt = 0.8;
t = 1:dt:(it*dt+dt);

figure(1)
plot(t,X_buff(:,3))
grid on
xlabel('Time/ms')
ylabel('Depth/m')

% figure(2)
% plot(W_buff(:,2))
% grid on
% 
% figure(3)
% plot(u_buff)
% grid on
% 
% figure(4)
% plot(X_buff(:,1),X_buff(:,3))
% grid on

figure(5)
plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
for i=1:800:it
    if strcmpi(get(gcf,'CurrentCharacter'),'q')
        break
    end
    drawUUV(X_buff(i,:).',W_buff(i,:).');
end

%% LQR
clc;clear;
run('config.m')

it = 15000;
X_buff = zeros(it,3);
W_buff = zeros(it,3);
dX_buff = zeros(it,3);
dW_buff = zeros(it,3);
u_buff = zeros(it,3);

X = [0,0,0].';
W = [0,0,0].';
dX = [0,0,0].';
dW = [0,0,0].';

K = lqr_depth();

for i = 1:it
    
    X_buff(i,:) = X.';
    W_buff(i,:) = W.';
    dX_buff(i,:) = dX.';
    dW_buff(i,:) = dW.';

    u = K*[0.1-X(3) -0.707-W(2) 0-dX(3) 0-dW(2)].';
    
    [X,W,dX,dW] = dynamics(X,W,dX,dW,u);
    u_buff(i,:) = u.';
end

X_buff(:,1) = X_buff(:,1).*0.5;

dt = 0.8;
t = 1:dt:(it*dt+dt);

figure(1)
plot(t,X_buff(:,3))
grid on
xlabel('Time/ms')
ylabel('Depth/m')

% figure(2)
% plot(W_buff(:,2))
% grid on
% 
% figure(3)
% plot(u_buff)
% grid on
% 
% figure(4)
% plot(X_buff(:,1),X_buff(:,3))
% grid on

figure(5)
plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
for i=1:600:it
    if strcmpi(get(gcf,'CurrentCharacter'),'q')
        break
    end
    drawUUV(X_buff(i,:).',W_buff(i,:).');
end

%% animation
figure(5)

% plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
for i=1:800:it
    if strcmpi(get(gcf,'CurrentCharacter'),'q')
        break
    end
    clf
    plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
    drawUUV(X_buff(i,:).',W_buff(i,:).');
%     pause(0.1);
    drawnow
end
