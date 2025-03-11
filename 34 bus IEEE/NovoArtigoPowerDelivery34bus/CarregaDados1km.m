% Curto Circuito Metodo total
close all;
clear;
clc;

rtc0 = 10;
rtc1 = 10;
rtc2 = 10;
rtc3 = 10;

%%DIMENCIONAMENTO DAS INDUTANCIAS
f=60; %frequencia da rede       ####ALTERAR####
DI=8.01e-3;   %Di�metro do condutor [m]
RI=1.102;      %Resist�ncia el�trica m�xima CA 60Hz 75�C [Ohm/km]
rmgi=0.00308;  %Raio m�dio geom�trico [m]
% Dotima=1.60;
ri=RI*1.609344; % transforma em ohm/milha 
rd=((pi)^2*f*10^(-4))/0.621371; %resistencia de terra ohm/milha 
GMRi=rmgi*3.28084; % transforma para P�S
dij=0.92; %m distancia entre os condutores i e j ####ALTERAR####
% escolhe dist�ncia entre cabos
% dij=[ Dotima]; %m distancia entre os condutores i e j ####ALTERAR####
Dij=dij*3.28084; % transforma em P�S
h1=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
h=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
rti=10;
rtc=10;
%%IMPEDANCIAS PR�PRIAS E MUTUAS
zp = ri+rd+(0.12134i)*(log(1/GMRi)+7.93402); %OHM/milha
Zp=zp*0.621371192; % tranfomada pra ohm/km
zm = rd+(0.12134i)*(log(1/Dij)+7.93402); %OHM/milha
Zm=zm*0.621371192; % tranfomada pra ohm/km
%%DIMENCIONAMENTO DAS CAPACITANCIAS SHUNT
%Dois condutores
Ri=(DI/2)*3.28084; %raio cond i pés
Rj=(DI/2)*3.28084; %raio cond j pés
%Distancias entre os condutores e suas imagens para dada config de poste
sii=2*h; %m
Sii=sii*3.28084;
Sjj=Sii;
sij=sqrt(((dij)^2)+(sii^2)); %m
Sij=sij*3.28084;
Sji=Sij;
%Calculo Coeficientes de potencias proprios e mutuos
Pii= 11.17689*log(Sii/Ri)*10^6;
Pjj= 11.17689*log(Sjj/Rj)*10^6;
Pij= 11.17689*log(Sij/Dij)*10^6;
Pji= 11.17689*log(Sji/Dij)*10^6;
Mp=[Pii Pij; Pji Pjj];
C = inv(Mp); %capacitancias shunt
C=C*0.621371192; % cconvertendo milha para km 
%capacitancias de balanceamento transversal
Cct=C(1,1)+C(2,1); %C entre condutor e terra Farad/km
Ccc=-C(2,1); %C entre condutores F/km
Ceq=Cct-Ccc; %capacitancia de equalização F/km
%IMPEDANCIA DE COMPENSA��O
Ze = Zp-2*Zm; %OHM/km
%%IMPEDANCIAS S�RIE
Zl = Zp-Zm; %OHM/km
dd =[ 4.188002926 ];
for compensada=[0 1 2]
%fazer tudo em fun��o da distancia
    for z = 1:length(dd) % Dist�ncia em KM   
    d=dd(z);
    cequa3=Ceq*d;
    ccc3=Ccc*d;
    cct3=Cct*d;
    rp3=real(Zp)*d;
    rm3=real(Zm)*d;
    re3=(real(Ze)*d)-rti-rtc;
        if re3<0
            NRE3=1e-12;
        else
            NRE3=re;
        end
    % rg=real(Zg)*d;
    lp3=(imag(Zp)/(2*pi*f))*d;
    lm3=(imag(Zm)/(2*pi*f))*d;
    le3=1e-10;%(imag(Ze)/(2*pi*f))*d;
    % lg=(imag(Zg)/(2*pi*f))*d;
        if compensada==0
        cequa3=0;
        NRE3=1e-10;
        le3=1e-10;
        %Sem Compensa��o 
        elseif compensada==1
        % cequa=Ceq*d;
        NRE3=1e-12;
        %Compensa��o C
        elseif compensada==2
        %Compensa��o RC
        end
    end
end

%%DIMENCIONAMENTO DAS INDUTANCIAS
f=60; %frequencia da rede       ####ALTERAR####
DI=8.01e-3;   %Di�metro do condutor [m]
RI=1.102;      %Resist�ncia el�trica m�xima CA 60Hz 75�C [Ohm/km]
rmgi=0.00308;  %Raio m�dio geom�trico [m]
% Dotima=1.60;
ri=RI*1.609344; % transforma em ohm/milha 
rd=((pi)^2*f*10^(-4))/0.621371; %resistencia de terra ohm/milha 
GMRi=rmgi*3.28084; % transforma para P�S
dij=0.92; %m distancia entre os condutores i e j ####ALTERAR####
% escolhe dist�ncia entre cabos
% dij=[ Dotima]; %m distancia entre os condutores i e j ####ALTERAR####
Dij=dij*3.28084; % transforma em P�S
h1=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
h=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
rti=10;
rtc=10;
%%IMPEDANCIAS PR�PRIAS E MUTUAS
zp = ri+rd+(0.12134i)*(log(1/GMRi)+7.93402); %OHM/milha
Zp=zp*0.621371192; % tranfomada pra ohm/km
zm = rd+(0.12134i)*(log(1/Dij)+7.93402); %OHM/milha
Zm=zm*0.621371192; % tranfomada pra ohm/km
%%DIMENCIONAMENTO DAS CAPACITANCIAS SHUNT
%Dois condutores
Ri=(DI/2)*3.28084; %raio cond i pés
Rj=(DI/2)*3.28084; %raio cond j pés
%Distancias entre os condutores e suas imagens para dada config de poste
sii=2*h; %m
Sii=sii*3.28084;
Sjj=Sii;
sij=sqrt(((dij)^2)+(sii^2)); %m
Sij=sij*3.28084;
Sji=Sij;
%Calculo Coeficientes de potencias proprios e mutuos
Pii= 11.17689*log(Sii/Ri)*10^6;
Pjj= 11.17689*log(Sjj/Rj)*10^6;
Pij= 11.17689*log(Sij/Dij)*10^6;
Pji= 11.17689*log(Sji/Dij)*10^6;
Mp=[Pii Pij; Pji Pjj];
C = inv(Mp); %capacitancias shunt
C=C*0.621371192; % cconvertendo milha para km 
%capacitancias de balanceamento transversal
Cct=C(1,1)+C(2,1); %C entre condutor e terra Farad/km
Ccc=-C(2,1); %C entre condutores F/km
Ceq=Cct-Ccc; %capacitancia de equalização F/km
%IMPEDANCIA DE COMPENSA��O
Ze = Zp-2*Zm; %OHM/km
%%IMPEDANCIAS S�RIE
Zl = Zp-Zm; %OHM/km
dd =[ 14.67629846 ];
for compensada=[0 1 2]
%fazer tudo em fun��o da distancia
    for z = 1:length(dd) % Dist�ncia em KM   
    d=dd(z);
    cequa2=Ceq*d;
    ccc2=Ccc*d;
    cct2=Cct*d;
    rp2=real(Zp)*d;
    rm2=real(Zm)*d;
    re2=(real(Ze)*d)-rti-rtc;
        if re2<0
            NRE2=1e-12;
        else
            NRE2=re;
        end
    % rg=real(Zg)*d;
    lp2=(imag(Zp)/(2*pi*f))*d;
    lm2=(imag(Zm)/(2*pi*f))*d;
    le2=1e-10;%(imag(Ze)/(2*pi*f))*d;
    % lg=(imag(Zg)/(2*pi*f))*d;
        if compensada==0
        cequa2=0;
        NRE2=1e-10;
        le2=1e-10;
        %Sem Compensa��o 
        elseif compensada==1
        % cequa=Ceq*d;
        NRE2=1e-12;
        %Compensa��o C
        elseif compensada==2
        %Compensa��o RC
        end
    end
end

%%DIMENCIONAMENTO DAS INDUTANCIAS
f=60; %frequencia da rede       ####ALTERAR####
DI=8.01e-3;   %Di�metro do condutor [m]
RI=1.102;      %Resist�ncia el�trica m�xima CA 60Hz 75�C [Ohm/km]
rmgi=0.00308;  %Raio m�dio geom�trico [m]
% Dotima=1.60;
ri=RI*1.609344; % transforma em ohm/milha 
rd=((pi)^2*f*10^(-4))/0.621371; %resistencia de terra ohm/milha 
GMRi=rmgi*3.28084; % transforma para P�S
dij=0.92; %m distancia entre os condutores i e j ####ALTERAR####
% escolhe dist�ncia entre cabos
% dij=[ Dotima]; %m distancia entre os condutores i e j ####ALTERAR####
Dij=dij*3.28084; % transforma em P�S
h1=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
h=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
rti=10;
rtc=10;
%%IMPEDANCIAS PR�PRIAS E MUTUAS
zp = ri+rd+(0.12134i)*(log(1/GMRi)+7.93402); %OHM/milha
Zp=zp*0.621371192; % tranfomada pra ohm/km
zm = rd+(0.12134i)*(log(1/Dij)+7.93402); %OHM/milha
Zm=zm*0.621371192; % tranfomada pra ohm/km
%%DIMENCIONAMENTO DAS CAPACITANCIAS SHUNT
%Dois condutores
Ri=(DI/2)*3.28084; %raio cond i pés
Rj=(DI/2)*3.28084; %raio cond j pés
%Distancias entre os condutores e suas imagens para dada config de poste
sii=2*h; %m
Sii=sii*3.28084;
Sjj=Sii;
sij=sqrt(((dij)^2)+(sii^2)); %m
Sij=sij*3.28084;
Sji=Sij;
%Calculo Coeficientes de potencias proprios e mutuos
Pii= 11.17689*log(Sii/Ri)*10^6;
Pjj= 11.17689*log(Sjj/Rj)*10^6;
Pij= 11.17689*log(Sij/Dij)*10^6;
Pji= 11.17689*log(Sji/Dij)*10^6;
Mp=[Pii Pij; Pji Pjj];
C = inv(Mp); %capacitancias shunt
C=C*0.621371192; % cconvertendo milha para km 
%capacitancias de balanceamento transversal
Cct=C(1,1)+C(2,1); %C entre condutor e terra Farad/km
Ccc=-C(2,1); %C entre condutores F/km
Ceq=Cct-Ccc; %capacitancia de equalização F/km
%IMPEDANCIA DE COMPENSA��O
Ze = Zp-2*Zm; %OHM/km
%%IMPEDANCIAS S�RIE
Zl = Zp-Zm; %OHM/km
dd =[ 0.521214338 ];
for compensada=[0 1 2]
%fazer tudo em fun��o da distancia
    for z = 1:length(dd) % Dist�ncia em KM   
    d=dd(z);
    cequa1=Ceq*d;
    ccc1=Ccc*d;
    cct1=Cct*d;
    rp1=real(Zp)*d;
    rm1=real(Zm)*d;
    re1=(real(Ze)*d)-rti-rtc;
        if re1<0
            NRE1=1e-12;
        else
            NRE1=re;
        end
    % rg=real(Zg)*d;
    lp1=(imag(Zp)/(2*pi*f))*d;
    lm1=(imag(Zm)/(2*pi*f))*d;
    le1=1e-10;%(imag(Ze)/(2*pi*f))*d;
    % lg=(imag(Zg)/(2*pi*f))*d;
        if compensada==0
        cequa1=0;
        NRE1=1e-10;
        le1=1e-10;
        %Sem Compensa��o 
        elseif compensada==1
        % cequa=Ceq*d;
        NRE1=1e-12;
        %Compensa��o C
        elseif compensada==2
        %Compensa��o RC
        end
    end
end