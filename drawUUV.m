function drawUUV(X,W)
global UUV
a=W(1); b=W(2); c=W(3);
Tv = [
    cos(c)*cos(b), -cos(a)*sin(c)+cos(c)*sin(a)*sin(b), sin(c)*sin(a)+cos(c)*cos(a)*sin(b);
    sin(c)*cos(b), cos(c)*cos(a)+sin(c)*sin(a)*sin(b), -cos(c)*sin(a)+cos(a)*sin(c)*sin(b);
    -sin(b), cos(b)*sin(a), cos(b)*cos(a)
    ];
%绘制圆柱
%需要知道中轴线线段的位置，以及圆筒的半径
%中轴线两端点的坐标，圆柱的高度。
obstracle_R = UUV.R;
obstracle_L_center = X.'+(Tv*[UUV.L/2,0,0].').';
obstracle_H_center = X.'+(Tv*[-UUV.L/2,0,0].').';



%建立底面圆心所在的坐标系
Vector=obstracle_H_center-obstracle_L_center;
obstracle_hight=norm(Vector);
CZ=Vector/norm(Vector);
CZout=null(CZ);
CX=CZout(:,1);
CY=CZout(:,2);
CZ=CZ';
Trans=[[CX CY CZ obstracle_L_center'];0 0 0 1];
Lx=zeros(2,51);
Ly=Lx;
Lz=Lx;

for i=1:50
   Lx(1,i)=obstracle_R*cos(i*2*pi/50);
   Ly(1,i)=obstracle_R*sin(i*2*pi/50);
   Lz(2,i)=obstracle_hight;
   Lz(1,i)=0;
end
Lx(1,51)=Lx(1,1);
Ly(1,51)=Ly(1,1);
Lz(1,51)=0;
Lz(2,51)=obstracle_hight;


Lx(2,:)=Lx(1,:);
Ly(2,:)=Ly(1,:);

for i=1:51
    out=Trans*[Lx(1,i);Ly(1,i);Lz(1,i);1];
    Lx(1,i)=out(1);
    Ly(1,i)=out(2);
    Lz(1,i)=out(3);
    out=Trans*[Lx(2,i);Ly(2,i);Lz(2,i);1];
    Lx(2,i)=out(1);
    Ly(2,i)=out(2);
    Lz(2,i)=out(3);    
end
hold on; grid on;
axis equal;
% axis(2*[-10 10 -10 10 -10 10]);
% view(-120,20);
surf(Lx,Ly,Lz,'FaceColor',[0,0,1]);
fill3(Lx(1,:),Ly(1,:),Lz(1,:),[0,0,1]);
fill3(Lx(2,:),Ly(2,:),Lz(2,:),[0,0,1]);

end

