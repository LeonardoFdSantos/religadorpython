%% Dados de Alimentação.

Ze=13.8^2/120*exp(i*atan(7));
% SCC=300 kVA
Zbase=13.8^2/0.3;
Ztri=2*(0.0048119 +i*0.018511)*Zbase;

%% Dados encontrados do T2F

Za = Ze+Ztri+((rp)*m1)+i*2*pi*60*((lp)*m1)+Raf;
Zb = Ze+Ztri+((rp)*m1)+i*2*pi*60*((lp)*m1)+Rbf;
Zc = Ze+Ztri+rti+NRE+i*2*pi*60*(le*m1)+Rcf;
% Zm Definidos pelo Curto na AT, antes dos Trafos dos Consumidores.
ZmCC = ((rm)*m1)+i*2*pi*60*((lm)*m1);

%% Dados Malhas Tensões.

Va = 13800/sqrt(3)*exp(0);
Vb = 13800/sqrt(3)*exp(-i*2*pi/3);
Vc = 13800/sqrt(3)*exp(i*2*pi/3);

I1 = (Va-Vb-(Vb-Vc)*(ZmCC-Zb)/(Zb+Zc))/(Za+Zb-2*ZmCC-(ZmCC-Zb)^2/(Zb+Zc));
I2 = (Vb-Vc-(-Zb+ZmCC)*I1)/(Zb+Zc);

%% Valores da Corrente de Curto.
IA = abs(I1);
IB = abs(I2 - I1);
IC = abs(-I2);