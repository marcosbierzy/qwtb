function [A,B,C,f,D]=ng_bh3(X,J_init)
% N�gyparam�teres frekvenciatartom�nybeli LS szinuszbecsl�s
% [P, D]=ng_bh3(X,J_init)
% X: szinuszjel Fourier transzform�ltj�nak vektora
% J_init: peri�dusok sz�m�nak kezdeti becsl�je
% P: a szinuszjel param�tereit tartalmaz� strukt�ra, mez�k: A, B, C, f
% Az illesztett N pontos szinuszjel:
% Fi=2*pi*P.f*(0:N-1)/N; x=P.C+P.A*cos(Fi)+P.B*sin(Fi);
% D: A Jacobi m�trix inverze (kovarianciasz�m�t�shoz)
% time: illeszt�si id�

% A bemen� jel legyen oszlopvektor
X = X(:);
% A bemen� jel hossza
Nx=length(X);

% A 3 tag� Blackman-Harris ablak egy�tthat�i
A0=+4.243800934609435e-001;
A1=-4.973406350967378e-001;
A2=+7.827927144231873e-002;

% A param�terek kezd��rt�ke a becsl�sn�l
A=0;
B=0;
C=0;
f=J_init;
k=round(f);

% A konvolv�l�vektor
cv=0.5*[A2 A1 2*A0 A1 A2];

% Az illeszt�sn�l haszn�lt binek kiv�laszt�sa
bins=([-2:2, k-2:k+2, Nx-k-2:Nx-k+2]).';
inds0=(bins<0); % Azon elemek indexe, amelyek null�n�l kisebbek
bins(inds0)=Nx+bins(inds0);
indsN=(bins>Nx-1); % Azon elemek indexe, amelyek N-1-n�l nagyobbak
bins(indsN)=-Nx+bins(indsN);
bins=unique(bins); % Sorba van rendezve a 0:N-1 k�z�tt, nincs 2 azonos elem.

% Az illeszt�shez haszn�lt m�rt jel el��ll�t�sa
Xbh3_ref=zeros(length(bins),1);
for ii=1:length(bins)
    ind=bins(ii)+1; % Matlab indexel�s
    indices=(ind-2:ind+2);
    indices(indices<1)=Nx+indices(indices<1);
    indices(indices>Nx)=-Nx+indices(indices>Nx);
    Xbh3_ref(ii)=cv*X(indices);
end


% % A m�rt jel ablakoz�sa, el��ll�t�sa
% xbh3=x.*wbh3;
% Xbh3=fft(xbh3);
% 

% 

% 
% % Az illeszt�shez haszn�lt m�rt jel el��ll�t�sa
% inds=ismember(0:Nx-1,bins);
% Xbh3_ref=Xbh3(inds); % Referenciajel, a hib�t ebb�l sz�moljuk

% Kovarianciam�trix meghat�roz�sa
W=cov_bh3(A0,A1,A2,bins,Nx);
O=zeros(size(W));
K=[...
    W, O;
    O, W;
    ];
invK=pinv(K,0);

% Seg�dpolinom el��ll�t�sa
[limit, sf, p]=poli_bh3(Nx);

% Gauss-Newton
It_szam=10;
for ii=1:It_szam
    [Xbh3_calc, dA, dB, dC, df]=g2_bh3(A,B,C,f,Nx,bins,A0,A1,A2,limit,sf,p); % Sz�molt �rt�k �s a deriv�ltak
    e=[real(Xbh3_ref-Xbh3_calc); imag(Xbh3_ref-Xbh3_calc)];
    J=[...
        real(dA), real(dB), real(dC), real(df);
        imag(dA), imag(dB), imag(dC), imag(df);
        ];
    H=J.'*invK;
    D=pinv(H*J,0);
    dP=D*H*e;
    A=A+dP(1);
    B=B+dP(2);
    C=C+dP(3);
    f=f+dP(4);
end
end









