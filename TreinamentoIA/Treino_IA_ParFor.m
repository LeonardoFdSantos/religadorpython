clc;
clearvars;
close all;

% Parâmetros principais
% Distancias_de_rede = [5:1:120];
Distancias_de_rede = [5:1:10];
Parametros_testes = [0.01:0.01:0.99];
Esquenas_de_curto_circuito = [1:1:5];
Potencias_Transformadores = [15, 30, 45, 75, 112.5, 150, 200, 225, 250, 300, 400, 500, 600]*1e3;
Esquemas_de_curto = 1:5;
Resistencias = 10;

% Inicia o paralelismo
if isempty(gcp('nocreate'))
    parpool;
end

addAttachedFiles(gcp, { ...
    'Sim_Curto_Circuito_Fim_Linha_Pronto.slx', ...
    'Sim_Curto_Circuito_Meio_Linha_Pronto.slx', ...
    'calcula_parametro_linha.m', ...
    'calcula_parametros_resistencias.m' ...
});

% Carrega e ativa Fast Restart nos modelos
load_system('Sim_Curto_Circuito_Fim_Linha_Pronto');
load_system('Sim_Curto_Circuito_Meio_Linha_Pronto');




% Inicializa resultados
result_fim = {};
result_meio = {};

parfor idx = 1:length(Distancias_de_rede)
    dd = Distancias_de_rede(idx);
    [lp, lm, rp, rm, re, le, ccc, cct, cequa, NRE] = calcula_parametro_linha(dd, 0.92);

    local_fim = {};
    local_meio = {};

    for potencia = Potencias_Transformadores
        Potencia_Consumidor = potencia;

        for tipoCurto = Esquemas_de_curto
            [Raf, Rbf, Rcf, RaTrif, RbTrif, RcTrif] = calcula_parametros_resistencias(tipoCurto);

            % Simulação Fim de Linha
            in_fim = Simulink.SimulationInput('Sim_Curto_Circuito_Fim_Linha_Pronto');
            in_fim = in_fim.setVariable('lp', lp).setVariable('lm', lm)...
                            .setVariable('rp', rp).setVariable('rm', rm)...
                            .setVariable('re', re).setVariable('le', le)...
                            .setVariable('ccc', ccc).setVariable('cct', cct)...
                            .setVariable('cequa', cequa).setVariable('NRE', NRE)...
                            .setVariable('Raf', Raf).setVariable('Rbf', Rbf)...
                            .setVariable('Rcf', Rcf).setVariable('RaTrif', RaTrif)...
                            .setVariable('RbTrif', RbTrif).setVariable('RcTrif', RcTrif)...
                            .setVariable('rti', Resistencias).setVariable('rtc', Resistencias)...
                            .setVariable('Potencia_Trafo_Isolador', potencia)...
                            .setVariable('Potencia_Trafo_Consumidor', potencia)...
                            .setVariable('Potencia_Consumidor', potencia)...
                            .setModelParameter('SimulationMode','normal','SaveOutput','on','SignalLogging','on','SignalLoggingName','logsout');

            simOut = sim(in_fim);
            try
                logs = simOut.get('logsout');
                IA_Sim = abs(simOut.CorrenteT2F)/sqrt(2);
                VA_Sim = abs(simOut.TensaoA)/sqrt(2);
                VA_Entrada = abs(simOut.TensaoEntradaTri)/sqrt(2);
                IA_Entrada = abs(simOut.CorrenteTrifasico)/sqrt(2);
            catch
                IA_Sim = 0; VA_Sim = 0; VA_Entrada = 0; IA_Entrada = 0;
            end

            local_fim{end+1, 1} = [dd, tipoCurto, Potencia_Consumidor, ...
                                   IA_Sim(:)', VA_Sim(:)', ...
                                   VA_Entrada(:)', IA_Entrada(:)'];

            for n = Parametros_testes
                m1 = n;
                m2 = 1 - n;
                [Raf, Rbf, Rcf, RaTrif, RbTrif, RcTrif] = calcula_parametros_resistencias(tipoCurto);

                in_meio = Simulink.SimulationInput('Sim_Curto_Circuito_Meio_Linha_Pronto');
                in_meio = in_meio.setVariable('lp', lp).setVariable('lm', lm)...
                                .setVariable('rp', rp).setVariable('rm', rm)...
                                .setVariable('re', re).setVariable('le', le)...
                                .setVariable('ccc', ccc).setVariable('cct', cct)...
                                .setVariable('cequa', cequa).setVariable('NRE', NRE)...
                                .setVariable('Raf', Raf).setVariable('Rbf', Rbf)...
                                .setVariable('Rcf', Rcf).setVariable('RaTrif', RaTrif)...
                                .setVariable('RbTrif', RbTrif).setVariable('RcTrif', RcTrif)...
                                .setVariable('m1', m1).setVariable('m2', m2)...
                                .setVariable('rti', Resistencias).setVariable('rtc', Resistencias)...
                                .setVariable('Potencia_Trafo_Isolador', potencia)...
                                .setVariable('Potencia_Trafo_Consumidor', potencia)...
                                .setVariable('Potencia_Consumidor', potencia)...
                                .setModelParameter('SaveOutput','on', ...
                                                   'SignalLogging','on', ...
                                                   'SignalLoggingName','logsout');

                simOut = sim(in_meio);
                try
                    logs = simOut.get('logsout');
                    IA_Sim = abs(simOut.CorrenteT2F)/sqrt(2);
                    VA_Sim = abs(simOut.TensaoA)/sqrt(2);
                    VA_Entrada = abs(simOut.TensaoEntradaTri)/sqrt(2);
                    IA_Entrada = abs(simOut.CorrenteTrifasico)/sqrt(2);
                catch
                    IA_Sim = 0; VA_Sim = 0; VA_Entrada = 0; IA_Entrada = 0;
                end

                local_meio{end+1, 1} = [dd, m1, tipoCurto, Potencia_Consumidor, ...
                                        IA_Sim(:)', VA_Sim(:)', ...
                                        VA_Entrada(:)', IA_Entrada(:)'];
            end
        end
    end

    result_fim{idx} = local_fim;
    result_meio{idx} = local_meio;
end




header_fim = {'dd', 'tipoCurto', 'Potencia_Carga', ...
    'IA_Sim', 'IB_Sim', 'IC_Sim', ...
    'VA_Sim', 'VB_Sim', 'VC_Sim', ...
    'VA_Entrada_TRIF', 'VB_Entrada_TRIF', 'VC_Entrada_TRIF', ...
    'IA_Entrada_TRIF', 'IB_Entrada_TRIF', 'IC_Entrada_TRIF'};

header_meio = {'dd', 'n', 'tipoCurto', 'Potencia_Carga', ...
    'IA_Sim', 'IB_Sim', 'IC_Sim', ...
    'VA_Sim', 'VB_Sim', 'VC_Sim', ...
    'VA_Entrada_TRIF', 'VB_Entrada_TRIF', 'VC_Entrada_TRIF', ...
    'IA_Entrada_TRIF', 'IB_Entrada_TRIF', 'IC_Entrada_TRIF'};

fim_final = vertcat(result_fim{:});
fim_final = fim_final(cellfun(@(x) size(x,2), fim_final) == length(header_fim));
fim_final = cell2mat(fim_final);

meio_final = vertcat(result_meio{:});
meio_final = meio_final(cellfun(@(x) size(x,2), meio_final) == length(header_meio));
meio_final = cell2mat(meio_final);

writecell([header_fim; num2cell(fim_final)], 'Output/fim_linha.csv');
writecell([header_meio; num2cell(meio_final)], 'Output/meio_linha.csv');
