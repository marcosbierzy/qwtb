function [A,B,C,f,COV,time] = fdsfit4_bh3(xq)
%FDSFIT4_BH3 Summary of this function goes here
%   Detailed explanation goes here

N=length(xq);

% MSD ablakos IpFFT
Fc=fft(xq);
F=abs(Fc);
[dummy,w]=max(F(2:round(N/2)));
% w teh�t a 2. indext�l indul� t�mb maximuma, azaz F-ben a t�nyleges
% maximum a w+1 helyen van.
J0=w; % peri�dusok sz�m�nak kezdeti becsl�se 
% 3 t�nyez�s MSD ablak az id�tartom�nyban:
a0=3/8;
a1=-1/2;
a2=1/8;
L=[...
    0, a2/2, a1/2, a0, a1/2, a2/2, 0, 0, 0;... % Xmsd(w-1)
    0, 0, a2/2, a1/2, a0, a1/2, a2/2, 0, 0;... % Xmsd(w)
    0, 0, 0, a2/2, a1/2, a0, a1/2, a2/2, 0;... % Xmsd(w+1)
    ];
v=[...
    Fc(w-3);...
    Fc(w-2);...
    Fc(w-1);...
    Fc(w);...
    Fc(w+1);...
    Fc(w+2);...
    Fc(w+3);...
    Fc(w+4);...
    Fc(w+5);...
    ];
Xmsd3=L*v;
dJ=3*(abs(Xmsd3(3))-abs(Xmsd3(1)))/(abs(Xmsd3(1))+2*abs(Xmsd3(2))+abs(Xmsd3(3)));
J_init=J0+dJ; 
% MSD ablakos IpFFT v�ge

% T�lvez�rl�s detekt�l�s
k=(0:N-1).';
Cmax=max(xq); % legnagyobb k�d
Cmin=min(xq); % legkisebb k�d
ind=((xq<Cmax)&(xq>Cmin));
Fi=2*pi*J_init/N*k(ind); % oszlopvektor
Fi = Fi(:);
D=[cos(Fi), sin(Fi), ones(nnz(ind),1)];
xq = xq(:);
s=pinv(D,0)*xq(ind);
A_init=s(1);
B_init=s(2);
C_init=s(3);
% t�lvez�rl�s detekt�l�sa, majd a szinuszjel kieg�sz�t�se ahol sz�ks�ges
Fi=2*pi*J_init/N*k;
x2=xq;
xf=A_init*cos(Fi)+B_init*sin(Fi)+C_init; % illesztett szinusz
th1=Cmax+1/2;
ind1=(xf>th1); % a felfel� t�lvez�relt mint�k indexe
if (nnz(ind1)>0)
    x2(ind1)=xf(ind1);
end;
th2=Cmin-1/2;
ind2=(xf<th2);
if (nnz(ind2)>0)
    x2(ind2)=xf(ind2);
end
X2=fft(x2);
% T�lvez�rl�s detekt�l�s v�ge

% Szinuszilleszt�s
tic;
[A,B,C,f,M]=ng_bh3(X2, J_init);
time=toc;
N=length(x2);
t=(0:N-1)';
fi=2*pi*f/N*t;
xfit=C+A*cos(fi)-B*sin(fi);
if (size(x2)~=size(xfit))
    xfit=xfit.';
end;
ind12=~(ind1|ind2);
r=xfit(ind12)-x2(ind12);
v=var(r);
% Eredeti
V=N*v; % Mert ha v=var(x), akkor V=var(fft(x))=N*v. 
COV=V*M;
% M�dos�tott
% D2=[cos(fi), -sin(fi), ones(size(fi)), -1/f*fi.*(A*sin(fi)+B*cos(fi))];
% COV=v*pinv(D2.'*D2,0);


