function [lp, lm, rp, rm, re, le, ccc, cct, cequa, NRE] = calcula_parametro_linha(Distancia_Rede, Distancia_Otima)

    % CONSTANTES FIXAS
    v = 220 * sqrt(3);
    fp = 1; % fator de potência (não utilizado diretamente aqui)
    f = 60; % frequência [Hz]
    DI = 8.01e-3; % Diâmetro do condutor [m]
    RI = 1.102;   % Resistência elétrica [Ohm/km]
    rmgi = 0.00308; % Raio médio geométrico [m]
    ri = RI * 1.609344; % [Ohm/milha]
    rd = ((pi)^2 * f * 10^(-4)) / 0.621371; % [Ohm/milha]
    GMRi = rmgi * 3.28084; % [ft]
    dij = Distancia_Otima; % [m]
    Dij = dij * 3.28084; % [ft]
    h = 10.372; % altura do condutor [m]
    rti = 10; rtc = 10;

    % IMPEDÂNCIAS
    zp = ri + rd + (0.12134i)*(log(1/GMRi) + 7.93402); % Ohm/milha
    Zp = zp * 0.621371192; % Ohm/km
    zm = rd + (0.12134i)*(log(1/Dij) + 7.93402); % Ohm/milha
    Zm = zm * 0.621371192; % Ohm/km
    Ze = Zp - 2 * Zm;
    Zl = Zp - Zm;

    % CAPACITÂNCIAS SHUNT
    Ri = (DI/2)*3.28084;
    Rj = (DI/2)*3.28084;
    sii = 2*h; % m
    Sii = sii * 3.28084;
    Sjj = Sii;
    sij = sqrt(dij^2 + sii^2);
    Sij = sij * 3.28084;
    Sji = Sij;

    % MATRIZ DE POTENCIAL E CAPACITÂNCIA
    Pii = 11.17689 * log(Sii / Ri) * 1e6;
    Pjj = 11.17689 * log(Sjj / Rj) * 1e6;
    Pij = 11.17689 * log(Sij / Dij) * 1e6;
    Pji = 11.17689 * log(Sji / Dij) * 1e6;

    Mp = [Pii Pij; Pji Pjj];
    C = inv(Mp) * 0.621371192; % [F/km]

    Cct = C(1,1) + C(2,1); % Condutor-Terra
    Ccc = -C(2,1);         % Entre condutores
    Ceq = Cct - Ccc;       % Equalização

    % INICIALIZAÇÃO DOS VETORES DE SAÍDA
    n = length(Distancia_Rede);
    Lp = zeros(1, n);
    Lm = zeros(1, n);
    rp = zeros(1, n);
    rm = zeros(1, n);
    re = zeros(1, n);
    le = zeros(1, n);
    ccc = zeros(1, n);
    cct = zeros(1, n);
    cequa = zeros(1, n);
    NRE = zeros(1, n);

    % LOOP SOBRE AS DISTÂNCIAS
    for z = 1:n
        d = Distancia_Rede(z);
        cequa(z) = Ceq * d;
        ccc(z)   = Ccc * d;
        cct(z)   = Cct * d;
        rp(z)    = real(Zp) * d;
        rm(z)    = real(Zm) * d;
        re(z)    = (real(Ze) * d) - rti - rtc;

        % NRE: resistência efetiva da equalização
        if re(z) < 0
            NRE(z) = 1e-12;
        else
            NRE(z) = re(z);
        end

        % INDUTÂNCIAS
        lp(z) = (imag(Zp) / (2*pi*f)) * d;
        lm(z) = (imag(Zm) / (2*pi*f)) * d;
        le(z) = 1e-10; % valor fixo como no seu código
    end

end