function [limit,sf,p] = poli_bh3(N)
% Polinomegy�tthat�kat adja meg melyek seg�ts�g�vel kisz�m�tjuk az X_sin
% f�ggv�nyban tal�lhat� sin(Nx)/sin(x) h�nyadost ha x z�rushoz tart.

% Polinom
start=-2^-23;
step=2^-30;
stop=2^-23;
limit=sin(stop);
x=start:step:stop;
M=length(x); % Legyen p�ratlan, azaz start=-1*stop, �s step oszt�ja mindkett�nek
center=(M+1)/2;
% for ii=1:center-1
%     y(ii)=sin(N*x(ii))/sin(x(ii));
% end;
% y(center)=N;
% for ii=center+1:M
%     y(ii)=sin(N*x(ii))/sin(x(ii));
% end;
y=sin(N*x)./sin(x);
y(center)=N;
% 1. m�dszer
sf=(M/norm(x,12)^12)^(1/12);
x2=sf*x;
s2=sum(x2.^2); s4=sum(x2.^4); s6=sum(x2.^6); s8=sum(x2.^8); s10=sum(x2.^10); s12=sum(x2.^12);
U=[
    M 0 s2 0 s4 0 s6; 
    0 s2 0 s4 0 s6 0; 
    s2 0 s4 0 s6 0 s8; 
    0 s4 0 s6 0 s8 0; 
    s4 0 s6 0 s8 0 s10;
    0 s6 0 s8 0 s10 0; 
    s6 0 s8 0 s10 0 s12;
    ];
z=[sum(y); 0; sum((x2.^2)*y.'); 0; sum((x2.^4)*y.'); 0; sum((x2.^6)*y.');];
p=U\z;
p=p(end:-1:1); % mert a polyval ford�tva veszi az egy�tthat�kat.
return;

