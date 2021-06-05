clc;clear;

run('config.m')

i=0;
it = 10000;
X_buff = zeros(it,3);
W_buff = zeros(it,3);
dX_buff = zeros(it,3);
dW_buff = zeros(it,3);
u_buff = zeros(it,3);

X = [0,0,0].';
W = [0,0,0].';
dX = [0,0,0].';
dW = [0,0,0].';
u_t = [1,1,0,0].';

while true
    if i==it
        break
    end
    i=i+1;
    
    X_buff(i,:) = X.';
    W_buff(i,:) = W.';
    dX_buff(i,:) = dX.';
    dW_buff(i,:) = dW.';
    u = thruster_calc(u_t);
    [X,W,dX,dW] = dynamics(X,W,dX,dW,u);
    u_buff(i,:) = u.';
end

figure(1)
plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
grid on

figure(2)
plot3(W_buff(:,1),W_buff(:,2),W_buff(:,3))
grid on

%%
figure(2)
for i=1:it
    if strcmpi(get(gcf,'CurrentCharacter'),'q')
        break
    end
    clf
    plot3(X_buff(:,1),X_buff(:,2),X_buff(:,3))
    drawUUV(X_buff(i,:).',W_buff(i,:).');
%     pause(0.1);
    drawnow
end
