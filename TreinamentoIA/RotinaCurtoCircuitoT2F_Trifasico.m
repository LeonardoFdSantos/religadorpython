clear;
clc;
close all;

%% Comparação entre Trifásico e T2F (
valores_resultados_simulacao_meio_linha_T2F(1, :) = string({'n' 'tipoCurto' 'IA' 'IB' 'IC'});
valores_resultados_simulacao_fim_linha_T2F(1, :) = string({'n' 'tipoCurto' 'IA' 'IB' 'IC'});

valores_resultados_simulacao_fim_linha_Trifasico(1, :) = string({'n' 'tipoCurto' 'IA' 'IB' 'IC'});
valores_resultados_simulacao_meio_linha_Trifasico(1, :) = string({'n' 'tipoCurto' 'IA' 'IB' 'IC'});

% para tipoCurto
% 1 = Trifásico
% 2 = Bifásico AC
% 3 = Bifásico BC

c = 1;
e = 1;

load('trif2awg.mat');
% load('trifasico2awg.mat');

for b = [1:1:3]
    if b == 1
        Raf = 1e-5;
        Rbf = 1e-5;
        Rcf = 1e-5;
        tipoCurto = 1;
    elseif b == 2
        Raf = 1e-5;
        Rbf = 100000;
        Rcf = 1e-5;
        tipoCurto = 2;
    elseif b == 3
        Raf = 100000;
        Rbf = 1e-5;
        Rcf = 1e-5;
        tipoCurto = 3;
    end

  

    v=220*sqrt(3);
    fp=[1]; %####ALTERAR####
    S=[120e3];        %####ALTERAR####

    %DIMENCIONAMENTO DAS INDUTANCIAS
    f=60; %frequencia da rede       ####ALTERAR####
    DI=8.01e-3;   %Di�metro do condutor [m]
    RI=1.102;      %Resist�ncia el�trica m�xima CA 60Hz 75�C [Ohm/km]
    rmgi=0.00308;  %Raio m�dio geom�trico [m]

    Dotima=0.92;

    ri=RI*1.609344; % transforma em ohm/milha 
    rd=((pi)^2*f*10^(-4))/0.621371; %resistencia de terra ohm/milha 
    GMRi=rmgi*3.28084; % transforma para P�S
    dij=1.2; %m distancia entre os condutores i e j ####ALTERAR####

    % escolhe dist�ncia entre cabos
    dij=[ Dotima]; %m distancia entre os condutores i e j ####ALTERAR####
    Dij=dij*3.28084; % transforma em P�S
    h1=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
    h=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
    rti=10;
    rtc=10;

    %IMPEDANCIAS PR�PRIAS E MUTUAS
    zp = ri+rd+(0.12134i)*(log(1/GMRi)+7.93402); %OHM/milha
    Zp=zp*0.621371192; % tranfomada pra ohm/km
    zm = rd+(0.12134i)*(log(1/Dij)+7.93402); %OHM/milha
    Zm=zm*0.621371192; % tranfomada pra ohm/km
    % %% Aten��o
    % Zm=0; %%######%para teste da eq do CC

    %DIMENCIONAMENTO DAS CAPACITANCIAS SHUNT
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

    %IMPEDANCIAS S�RIE
    Zl = Zp-Zm; %OHM/km

    dd =[60];

    for compensada=[0]
    %fazer tudo em fun��o da distancia
        for z = 1:length(dd) % Dist�ncia em KM   
        d=dd(z);
        cequa=Ceq*d;
        ccc=Ccc*d;
        cct=Cct*d;
        rp=real(Zp)*d;
        rm=real(Zm)*d;
        re=(real(Ze)*d)-rti-rtc;
            if re<0
                NRE=1e-12;
            else
                NRE=re;
            end
    
        % rg=real(Zg)*d;
        lp=(imag(Zp)/(2*pi*f))*d;
        lm=(imag(Zm)/(2*pi*f))*d;
        le=1e-10;%(imag(Ze)/(2*pi*f))*d;
        % lg=(imag(Zg)/(2*pi*f))*d;
    
            if compensada==0
            cequa=0; 
            NRE=1e-10;
            le=1e-10;
            %Sem Compensa��o 
            elseif compensada==1
            % cequa=Ceq*d; 
            NRE=1e-12;
            %Compensa��o C
            elseif compensada==2
            %Compensa��o RC
            end
        end
    end

    sim('.\SimCurtoCircuitoFimLinhaT2F.slx')
    sim('.\SimTrifasicoFimLinha.slx')

    Corrente_T2F_Ensaio = abs(CorrenteT2F)/sqrt(2);
    Corrente_T2F_Ensaio;

    Corrente_Trifasica_Ensaio = abs(CorrenteTrifasica)/sqrt(2);
    Corrente_Trifasica_Ensaio;

    valores_resultados_simulacao_fim_linha_T2F(b+1, :) = [b tipoCurto Corrente_T2F_Ensaio];
    valores_resultados_simulacao_fim_linha_Trifasico(b+1, :) = [b tipoCurto Corrente_Trifasica_Ensaio];

end

%  Fim rotina Calculo de Circuito 

% para tipoCurto
% 1 = Trifásico
% 2 = Bifásico AC
% 3 = Bifásico BC

b = 0;

Parametros_testes = [0.001:0.001:0.999];
% Parametros_testes = [0.1 0.25 0.5 0.75];
for n = Parametros_testes
    m1 = n;
    m2 = 1 - m1;
    for b = [1:1:3]
        if b == 1
           Raf = 1e-5;
           Rbf = 1e-5;
           Rcf = 1e-5;
           tipoCurto = 1;
        elseif b == 2
           Raf = 1e-5;
           Rbf = 100000;
           Rcf = 1e-5;
           tipoCurto = 2;
        elseif b == 3
           Raf = 100000;
           Rbf = 1e-5;
           Rcf = 1e-5;
           tipoCurto = 3;
        end
    
        v=220*sqrt(3);
        fp=[1]; %####ALTERAR####
        S=[120e3];        %####ALTERAR####
        
        %DIMENCIONAMENTO DAS INDUTANCIAS
        f=60; %frequencia da rede       ####ALTERAR####
        DI=8.01e-3;   %Di�metro do condutor [m]
        RI=1.102;      %Resist�ncia el�trica m�xima CA 60Hz 75�C [Ohm/km]
        rmgi=0.00308;  %Raio m�dio geom�trico [m]
        Dotima=1.60;
        
        ri=RI*1.609344; % transforma em ohm/milha 
        rd=((pi)^2*f*10^(-4))/0.621371; %resistencia de terra ohm/milha 
        GMRi=rmgi*3.28084; % transforma para P�S
        
        %% escolhe dist�ncia entre cabos
        dij=[ Dotima]; %m distancia entre os condutores i e j ####ALTERAR####
        Dij=dij*3.28084; % transforma em P�S
        h1=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
        h=10.372; %distancia condutor mais alto da terra [m] ###ALTERAR####
        rti=10;
        rtc=10;
        
        %IMPEDANCIAS PR�PRIAS E MUTUAS
        zp = ri+rd+(0.12134i)*(log(1/GMRi)+7.93402); %OHM/milha
        Zp=zp*0.621371192; % tranfomada pra ohm/km
        zm = rd+(0.12134i)*(log(1/Dij)+7.93402); %OHM/milha
        Zm=zm*0.621371192; % tranfomada pra ohm/km
        % %% Aten��o
        % Zm=0; %%######%para teste da eq do CC

        %DIMENCIONAMENTO DAS CAPACITANCIAS SHUNT
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
        
        %IMPEDANCIAS S�RIE
        Zl = Zp-Zm; %OHM/km
        
        dd =[60];
    
        for compensada=[0]
            %fazer tudo em fun��o da distancia
            for z = 1:length(dd) % Dist�ncia em KM   
            d=dd(z);
            cequa=Ceq*d;
            ccc=Ccc*d;
            cct=Cct*d;
            rp=real(Zp)*d;
            rm=real(Zm)*d;
            re=(real(Ze)*d)-rti-rtc;
            if re<0
                NRE=1e-12;
            else
                NRE=re;
            end
        
            % rg=real(Zg)*d;
            lp=(imag(Zp)/(2*pi*f))*d;
            lm=(imag(Zm)/(2*pi*f))*d;
            le=1e-10;%(imag(Ze)/(2*pi*f))*d;
            % lg=(imag(Zg)/(2*pi*f))*d;
        
            if compensada==0
                cequa=0; 
                NRE=1e-10;
                le=1e-10;
                %Sem Compensa��o 
                elseif compensada==1
                % cequa=Ceq*d; 
                NRE=1e-12;
                %Compensa��o C
            elseif compensada==2
                %Compensa��o RC
            end
            
            end
        end

        sim('.\SimCurtoCircuitoMeioLinhaT2F')

        

        Corrente_T2F_Ensaio = abs(CorrenteT2F)/sqrt(2);
        Corrente_T2F_Ensaio;

        sim('.\SimTrifasicoMeioLinha.slx')

        Corrente_Trifasica_Ensaio = abs(CorrenteTrifasica)/sqrt(2);
        Corrente_Trifasica_Ensaio;

        valores_resultados_simulacao_meio_linha_T2F(c+1, :) = [m1 tipoCurto Corrente_T2F_Ensaio];
        valores_resultados_simulacao_meio_linha_Trifasico(c+1, :) = [m1 tipoCurto Corrente_Trifasica_Ensaio];

        c = c + 1;
        % (Vb-Va)*exp(-i*pi/6)+CorrenteT2F(1)/sqrt(2)*(Za-Zm)+CorrenteT2F(2)/sqrt(2)*(Zm-Zb)
    end
end

writematrix(valores_resultados_simulacao_meio_linha_T2F, 'Output/ValoresResultadoSimulacaoMeioLinha.csv');
writematrix(valores_resultados_simulacao_fim_linha_T2F, 'Output/ValoresResultadoSimulacaoFimLinha.csv');

writematrix(valores_resultados_simulacao_fim_linha_Trifasico, 'Output/valores_resultados_simulacao_fim_linha_Trifasico.csv');
writematrix(valores_resultados_simulacao_meio_linha_Trifasico, 'Output/valores_resultados_simulacao_meio_linha_Trifasico.csv');

fprintf('terminado!');
