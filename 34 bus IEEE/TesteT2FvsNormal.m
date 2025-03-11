clc;
clear;
format longG
run('CarregaDados1km.m');
SalvarValoresCorrenteT2F(1, :) = string({'tipoCurto' 'n' 'm1' 'm2' 'm3' 'A_I800' 'B_I800' 'C_I800' 'A_I800A' 'B_I800A' 'C_I800A' 'A_I802' 'B_I802' 'C_I802' 'A_I802A' 'B_I802A' 'C_I802A' 'A_I806' 'B_I806' 'C_I806' 'A_I806A' 'B_I806A' 'C_I806A' 'A_I808' 'B_I808' 'C_I808' 'A_I808A' 'B_I808A' 'C_I808A' 'A_I812' 'B_I812' 'C_I812' 'A_I812A' 'B_I812A' 'C_I812A' 'A_I814' 'B_I814' 'C_I814' 'A_I814A' 'B_I814A' 'C_I814A' 'A_I816' 'B_I816' 'C_I816' 'A_I816A' 'B_I816A' 'C_I816A' 'A_I818' 'B_I818' 'C_I818' 'A_I818A' 'B_I818A' 'C_I818A' 'A_I820' 'B_I820' 'C_I820' 'A_I820A' 'B_I820A' 'C_I820A' 'A_I822' 'B_I822' 'C_I822' 'A_I822A' 'B_I822A' 'C_I822A' 'A_I824' 'B_I824' 'C_I824' 'A_I824A' 'B_I824A' 'C_I824A' 'A_I828' 'B_I828' 'C_I828' 'A_I828A' 'B_I828A' 'C_I828A' 'A_I830' 'B_I830' 'C_I830' 'A_I830A' 'B_I830A' 'C_I830A' 'A_I832' 'B_I832' 'C_I832' 'A_I832A' 'B_I832A' 'C_I832A' 'A_I850' 'B_I850' 'C_I850' 'A_I850A' 'B_I850A' 'C_I850A' 'A_I852' 'B_I852' 'C_I852' 'A_I852A' 'B_I852A' 'C_I852A' 'A_I854' 'B_I854' 'C_I854' 'A_I854A' 'B_I854A' 'C_I854A' 'A_IRG10' 'B_IRG10' 'C_IRG10' 'A_IRG10A' 'B_IRG10A' 'C_IRG10A' 'A_IRG11' 'B_IRG11' 'C_IRG11' 'A_IRG11A' 'B_IRG11A' 'C_IRG11A'});
SalvarValoresCorrente(1, :) = string({'tipoCurto' 'n' 'm1' 'm2' 'm3' 'A_I800' 'B_I800' 'C_I800' 'A_I800A' 'B_I800A' 'C_I800A'  'A_I802' 'B_I802' 'C_I802' 'A_I802A' 'B_I802A' 'C_I802A' 'A_I806' 'B_I806' 'C_I806' 'A_I806A' 'B_I806A' 'C_I806A' 'A_I808' 'B_I808' 'C_I808' 'A_I808A' 'B_I808A' 'C_I808A' 'A_I812' 'B_I812' 'C_I812' 'A_I812A' 'B_I812A' 'C_I812A' 'A_I814' 'B_I814' 'C_I814' 'A_I814A' 'B_I814A' 'C_I814A' 'A_I816' 'B_I816' 'C_I816' 'A_I816A' 'B_I816A' 'C_I816A' 'A_I818' 'B_I818' 'C_I818' 'A_I818A' 'B_I818A' 'C_I818A' 'A_I820' 'B_I820' 'C_I820' 'A_I820A' 'B_I820A' 'C_I820A' 'A_I822' 'B_I822' 'C_I822' 'A_I822A' 'B_I822A' 'C_I822A' 'A_I824' 'B_I824' 'C_I824' 'A_I824A' 'B_I824A' 'C_I824A' 'A_I828' 'B_I828' 'C_I828' 'A_I828A' 'B_I828A' 'C_I828A' 'A_I830' 'B_I830' 'C_I830' 'A_I830A' 'B_I830A' 'C_I830A' 'A_I832' 'B_I832' 'C_I832' 'A_I832A' 'B_I832A' 'C_I832A' 'A_I850' 'B_I850' 'C_I850' 'A_I850A' 'B_I850A' 'C_I850A' 'A_I852' 'B_I852' 'C_I852' 'A_I852A' 'B_I852A' 'C_I852A' 'A_I854' 'B_I854' 'C_I854' 'A_I854A' 'B_I854A' 'C_I854A' 'A_IRG10' 'B_IRG10' 'C_IRG10' 'A_IRG10A' 'B_IRG10A' 'C_IRG10A' 'A_IRG11' 'B_IRG11' 'C_IRG11' 'A_IRG11A' 'B_IRG11A' 'C_IRG11A'});
SalvarValoresTensaoT2F(1, :) = string({'tipoCurto' 'n' 'm1' 'm2' 'm3' 'A_I800' 'B_I800' 'C_I800' 'A_I800A' 'B_I800A' 'C_I800A'  'A_V802' 'B_V802' 'C_V802' 'A_V802A' 'B_V802A' 'C_V802A' 'A_V806' 'B_V806' 'C_V806' 'A_V806A' 'B_V806A' 'C_V806A' 'A_V808' 'B_V808' 'C_V808' 'A_V808A' 'B_V808A' 'C_V808A' 'A_V812' 'B_V812' 'C_V812' 'A_V812A' 'B_V812A' 'C_V812A' 'A_V814' 'B_V814' 'C_V814' 'A_V814A' 'B_V814A' 'C_V814A' 'A_V816' 'B_V816' 'C_V816' 'A_V816A' 'B_V816A' 'C_V816A' 'A_V818' 'B_V818' 'C_V818' 'A_V818A' 'B_V818A' 'C_V818A' 'A_V820' 'B_V820' 'C_V820' 'A_V820A' 'B_V820A' 'C_V820A' 'A_V822' 'B_V822' 'C_V822' 'A_V822A' 'B_V822A' 'C_V822A' 'A_V824' 'B_V824' 'C_V824' 'A_V824A' 'B_V824A' 'C_V824A' 'A_V828' 'B_V828' 'C_V828' 'A_V828A' 'B_V828A' 'C_V828A' 'A_V830' 'B_V830' 'C_V830' 'A_V830A' 'B_V830A' 'C_V830A' 'A_V832' 'B_V832' 'C_V832' 'A_V832A' 'B_V832A' 'C_V832A' 'A_V850' 'B_V850' 'C_V850' 'A_V850A' 'B_V850A' 'C_V850A' 'A_V852' 'B_V852' 'C_V852' 'A_V852A' 'B_V852A' 'C_V852A' 'A_V854' 'B_V854' 'C_V854' 'A_V854A' 'B_V854A' 'C_V854A' 'A_VRG10' 'B_VRG10' 'C_VRG10' 'A_VRG10A' 'B_VRG10A' 'C_VRG10A' 'A_VRG11' 'B_VRG11' 'C_VRG11' 'A_VRG11A' 'B_VRG11A' 'C_VRG11A'});
SalvarValoresTensao(1, :) = string({'tipoCurto' 'n' 'm1' 'm2' 'm3' 'A_I800' 'B_I800' 'C_I800' 'A_I800A' 'B_I800A' 'C_I800A'  'A_V802' 'B_V802' 'C_V802' 'A_V802A' 'B_V802A' 'C_V802A' 'A_V806' 'B_V806' 'C_V806' 'A_V806A' 'B_V806A' 'C_V806A' 'A_V808' 'B_V808' 'C_V808' 'A_V808A' 'B_V808A' 'C_V808A' 'A_V812' 'B_V812' 'C_V812' 'A_V812A' 'B_V812A' 'C_V812A' 'A_V814' 'B_V814' 'C_V814' 'A_V814A' 'B_V814A' 'C_V814A' 'A_V816' 'B_V816' 'C_V816' 'A_V816A' 'B_V816A' 'C_V816A' 'A_V818' 'B_V818' 'C_V818' 'A_V818A' 'B_V818A' 'C_V818A' 'A_V820' 'B_V820' 'C_V820' 'A_V820A' 'B_V820A' 'C_V820A' 'A_V822' 'B_V822' 'C_V822' 'A_V822A' 'B_V822A' 'C_V822A' 'A_V824' 'B_V824' 'C_V824' 'A_V824A' 'B_V824A' 'C_V824A' 'A_V828' 'B_V828' 'C_V828' 'A_V828A' 'B_V828A' 'C_V828A' 'A_V830' 'B_V830' 'C_V830' 'A_V830A' 'B_V830A' 'C_V830A' 'A_V832' 'B_V832' 'C_V832' 'A_V832A' 'B_V832A' 'C_V832A' 'A_V850' 'B_V850' 'C_V850' 'A_V850A' 'B_V850A' 'C_V850A' 'A_V852' 'B_V852' 'C_V852' 'A_V852A' 'B_V852A' 'C_V852A' 'A_V854' 'B_V854' 'C_V854' 'A_V854A' 'B_V854A' 'C_V854A' 'A_VRG10' 'B_VRG10' 'C_VRG10' 'A_VRG10A' 'B_VRG10A' 'C_VRG10A' 'A_VRG11' 'B_VRG11' 'C_VRG11' 'A_VRG11A' 'B_VRG11A' 'C_VRG11A'});
valor = 1;
Parametros_testes = [0.001 .1 .2 .3 .4 .5 .6 .7 .8 .9 .999];
for m1 = Parametros_testes
    m2 = 0.5;
    m3 = 0.5;
    Rcc2 = inf;
    Rcc3 = inf;
    for b = [1:1:2]
        if b == 1
            Rcc1 = 1e-5;
            tipoCurto = b;
        elseif b == 2
            Rcc1 = inf;
            tipoCurto = b;
        end
        sim("IEEE34bus_v2019b_Phasor_PI_ZIPload.slx");
        ValoresCorrentes = [abs(I800) angle(I800) abs(I802) angle(I802) abs(I806) angle(I806) abs(I808) angle(I808) abs(I812) angle(I812) abs(I814) angle(I814) abs(I816) angle(I816) abs(I818) angle(I818) abs(I820) angle(I820) abs(I822) angle(I822) abs(I824) angle(I824) abs(I828) angle(I828) abs(I830) angle(I830) abs(I832) angle(I832) abs(I850) angle(I850) abs(I852) angle(I852) abs(I854) angle(I854) abs(IRG10) angle(IRG10) abs(IRG11) angle(IRG11)];
        ValoresTensao = [abs(V800) angle(V800)  abs(V802) angle(V802) abs(V806) angle(V806) abs(V808) angle(V808) abs(V812) angle(V812) abs(V814) angle(V814) abs(V816) angle(V816) abs(V818) angle(V818) abs(V820) angle(V820) abs(V822) angle(V822) abs(V824) angle(V824) abs(V828) angle(V828) abs(V830) angle(V830) abs(V832) angle(V832) abs(V850) angle(V850) abs(V852) angle(V852) abs(V854) angle(V854) abs(VRG10) angle(VRG10) abs(VRG11) angle(VRG11)];
        SalvarValoresCorrente(valor+1, :) = [tipoCurto valor m1 m2 m3 ValoresCorrentes];
        SalvarValoresTensao(valor+1, :) = [tipoCurto valor m1 m2 m3 ValoresTensao];
        valor = valor + 1;
    end
end
for m2 = Parametros_testes
    m1 = 0.5;
    m3 = 0.5;
    Rcc1 = inf;
    Rcc3 = inf;
    for b = [1:1:2]
        if b == 1
            Rcc1 = 1e-5;
            tipoCurto = b;
        elseif b == 2
            Rcc1 = inf;
            tipoCurto = b;
        end
        sim("IEEE34bus_v2019b_Phasor_PI_ZIPload.slx");
        ValoresCorrentes = [abs(I800) angle(I800) abs(I802) angle(I802) abs(I806) angle(I806) abs(I808) angle(I808) abs(I812) angle(I812) abs(I814) angle(I814) abs(I816) angle(I816) abs(I818) angle(I818) abs(I820) angle(I820) abs(I822) angle(I822) abs(I824) angle(I824) abs(I828) angle(I828) abs(I830) angle(I830) abs(I832) angle(I832) abs(I850) angle(I850) abs(I852) angle(I852) abs(I854) angle(I854) abs(IRG10) angle(IRG10) abs(IRG11) angle(IRG11)];
        ValoresTensao = [abs(V800) angle(V800)  abs(V802) angle(V802) abs(V806) angle(V806) abs(V808) angle(V808) abs(V812) angle(V812) abs(V814) angle(V814) abs(V816) angle(V816) abs(V818) angle(V818) abs(V820) angle(V820) abs(V822) angle(V822) abs(V824) angle(V824) abs(V828) angle(V828) abs(V830) angle(V830) abs(V832) angle(V832) abs(V850) angle(V850) abs(V852) angle(V852) abs(V854) angle(V854) abs(VRG10) angle(VRG10) abs(VRG11) angle(VRG11)];
        SalvarValoresCorrente(valor+1, :) = [tipoCurto valor m1 m2 m3 ValoresCorrentes];
        SalvarValoresTensao(valor+1, :) = [tipoCurto valor m1 m2 m3 ValoresTensao];
        valor = valor + 1;
    end
end
for m3 = Parametros_testes
    m2 = 0.5;
    m1 = 0.5;
    Rcc2 = inf;
    Rcc1 = inf;
    for b = [1:1:2]
        if b == 1
            Rcc1 = 1e-5;
            tipoCurto = b;
        elseif b == 2
            Rcc1 = inf;
            tipoCurto = b;
        end
        sim("IEEE34bus_v2019b_Phasor_PI_ZIPload.slx");
        ValoresCorrentes = [abs(I800) angle(I800) abs(I802) angle(I802) abs(I806) angle(I806) abs(I808) angle(I808) abs(I812) angle(I812) abs(I814) angle(I814) abs(I816) angle(I816) abs(I818) angle(I818) abs(I820) angle(I820) abs(I822) angle(I822) abs(I824) angle(I824) abs(I828) angle(I828) abs(I830) angle(I830) abs(I832) angle(I832) abs(I850) angle(I850) abs(I852) angle(I852) abs(I854) angle(I854) abs(IRG10) angle(IRG10) abs(IRG11) angle(IRG11)];
        ValoresTensao = [abs(V800) angle(V800)  abs(V802) angle(V802) abs(V806) angle(V806) abs(V808) angle(V808) abs(V812) angle(V812) abs(V814) angle(V814) abs(V816) angle(V816) abs(V818) angle(V818) abs(V820) angle(V820) abs(V822) angle(V822) abs(V824) angle(V824) abs(V828) angle(V828) abs(V830) angle(V830) abs(V832) angle(V832) abs(V850) angle(V850) abs(V852) angle(V852) abs(V854) angle(V854) abs(VRG10) angle(VRG10) abs(VRG11) angle(VRG11)];
        SalvarValoresCorrente(valor+1, :) = [tipoCurto valor m1 m2 m3 ValoresCorrentes];
        SalvarValoresTensao(valor+1, :) = [tipoCurto valor m1 m2 m3 ValoresTensao];
        valor = valor + 1;
    end
end

%% Separando T2F
valord = 1;
for m1 = Parametros_testes
    m2 = 0.5;
    m3 = 0.5;
    Rcc2A = inf;
    Rcc2B = inf;
    Rcc2C = inf;
    Rcc3A = inf;
    Rcc3B = inf;
    Rcc3C = inf;
    for b = [1:1:5]
        if b == 1
            Rcc1A = 1e-5;
            Rcc1B = 1e-5;
            Rcc1C = 1e-5;
            tipoCurto = b;
        elseif b == 2
            Rcc1A = 1e-5;
            Rcc1B = inf;
            Rcc1C = 1e-5;
            tipoCurto = b;
        elseif b == 3
            Rcc1A = inf;
            Rcc1B = 1e-5;
            Rcc1C = 1e-5;
            tipoCurto = b;
        elseif b == 4
            Rcc1A = 1e-5;
            Rcc1B = 1e-5;
            Rcc1C = inf;
            tipoCurto = b;
        elseif b == 5
            Rcc1A = inf;
            Rcc1B = inf;
            Rcc1C = inf;
            tipoCurto = b;
        end
        sim("T2F_IEEE34bus_v2019b_Phasor_PI_ZIPload.slx");
        SalvarValoresCorrenteT2F(valord+1, :) = [tipoCurto valord m1 m2 m3 abs(I800) angle(I800)  abs(I802) angle(I802) abs(I806) angle(I806) abs(I808) angle(I808) abs(I812) angle(I812) abs(I814) angle(I814) abs(I816) angle(I816) abs(I818) angle(I818) abs(I820) angle(I820) abs(I822) angle(I822) abs(I824) angle(I824) abs(I828) angle(I828) abs(I830) angle(I830) abs(I832) angle(I832) abs(I850) angle(I850) abs(I852) angle(I852) abs(I854) angle(I854) abs(IRG10) angle(IRG10) abs(IRG11) angle(IRG11)];
        SalvarValoresTensaoT2F(valord+1, :) = [tipoCurto valord m1 m2 m3 abs(I800) angle(I800)  abs(V802) angle(V802) abs(V806) angle(V806) abs(V808) angle(V808) abs(V812) angle(V812) abs(V814) angle(V814) abs(V816) angle(V816) abs(V818) angle(V818) abs(V820) angle(V820) abs(V822) angle(V822) abs(V824) angle(V824) abs(V828) angle(V828) abs(V830) angle(V830) abs(V832) angle(V832) abs(V850) angle(V850) abs(V852) angle(V852) abs(V854) angle(V854) abs(VRG10) angle(VRG10) abs(VRG11) angle(VRG11)];
        valord = valord + 1;
    end
end
for m2 = Parametros_testes
    m1 = 0.5;
    m3 = 0.5;
    Rcc1A = inf;
    Rcc1B = inf;
    Rcc1C = inf;
    Rcc3A = inf;
    Rcc3B = inf;
    Rcc3C = inf;
    for b = [1:1:1]
        if b == 1
            Rcc2A = 1e-5;
            Rcc2B = 1e-5;
            Rcc2C = 1e-5;
            tipoCurto = b;
        elseif b == 2
            Rcc2A = 1e-5;
            Rcc2B = inf;
            Rcc2C = 1e-5;
            tipoCurto = b;
        elseif b == 3
            Rcc2A = inf;
            Rcc2B = 1e-5;
            Rcc2C = 1e-5;
            tipoCurto = b;
        elseif b == 4
            Rcc2A = 1e-5;
            Rcc2B = 1e-5;
            Rcc2C = inf;
            tipoCurto = b;
        elseif b == 5
            Rcc2A = inf;
            Rcc2B = inf;
            Rcc2C = inf;
            tipoCurto = b;
        end
        sim("T2F_IEEE34bus_v2019b_Phasor_PI_ZIPload.slx");
        SalvarValoresCorrenteT2F(valord+1, :) = [tipoCurto valord m1 m2 m3 abs(I800) angle(I800)  abs(I802) angle(I802) abs(I806) angle(I806) abs(I808) angle(I808) abs(I812) angle(I812) abs(I814) angle(I814) abs(I816) angle(I816) abs(I818) angle(I818) abs(I820) angle(I820) abs(I822) angle(I822) abs(I824) angle(I824) abs(I828) angle(I828) abs(I830) angle(I830) abs(I832) angle(I832) abs(I850) angle(I850) abs(I852) angle(I852) abs(I854) angle(I854) abs(IRG10) angle(IRG10) abs(IRG11) angle(IRG11)];
        SalvarValoresTensaoT2F(valord+1, :) = [tipoCurto valord m1 m2 m3 abs(I800) angle(I800)  abs(V802) angle(V802) abs(V806) angle(V806) abs(V808) angle(V808) abs(V812) angle(V812) abs(V814) angle(V814) abs(V816) angle(V816) abs(V818) angle(V818) abs(V820) angle(V820) abs(V822) angle(V822) abs(V824) angle(V824) abs(V828) angle(V828) abs(V830) angle(V830) abs(V832) angle(V832) abs(V850) angle(V850) abs(V852) angle(V852) abs(V854) angle(V854) abs(VRG10) angle(VRG10) abs(VRG11) angle(VRG11)];
        valord = valord + 1;
    end
end
for m3 = Parametros_testes
    m2 = 0.5;
    m1 = 0.5;
    Rcc2A = inf;
    Rcc2B = inf;
    Rcc2C = inf;
    Rcc1A = inf;
    Rcc1B = inf;
    Rcc1C = inf;
    for b = [1:1:1]
        if b == 1
            Rcc3A = 1e-5;
            Rcc3B = 1e-5;
            Rcc3C = 1e-5;
            tipoCurto = b;
        elseif b == 2
            Rcc3A = 1e-5;
            Rcc3B = inf;
            Rcc3C = 1e-5;
            tipoCurto = b;
        elseif b == 3
            Rcc3A = inf;
            Rcc3B = 1e-5;
            Rcc3C = 1e-5;
            tipoCurto = b;
        elseif b == 4
            Rcc3A = 1e-5;
            Rcc3B = 1e-5;
            Rcc3C = inf;
            tipoCurto = b;
        elseif b == 5
            Rcc3A = inf;
            Rcc3B = inf;
            Rcc3C = inf;
            tipoCurto = b;
        end
        sim("T2F_IEEE34bus_v2019b_Phasor_PI_ZIPload.slx");
        SalvarValoresCorrenteT2F(valord+1, :) = [tipoCurto valord m1 m2 m3 abs(I800) angle(I800)  abs(I802) angle(I802) abs(I806) angle(I806) abs(I808) angle(I808) abs(I812) angle(I812) abs(I814) angle(I814) abs(I816) angle(I816) abs(I818) angle(I818) abs(I820) angle(I820) abs(I822) angle(I822) abs(I824) angle(I824) abs(I828) angle(I828) abs(I830) angle(I830) abs(I832) angle(I832) abs(I850) angle(I850) abs(I852) angle(I852) abs(I854) angle(I854) abs(IRG10) angle(IRG10) abs(IRG11) angle(IRG11)];
        SalvarValoresTensaoT2F(valord+1, :) = [tipoCurto valord m1 m2 m3 abs(I800) angle(I800)  abs(V802) angle(V802) abs(V806) angle(V806) abs(V808) angle(V808) abs(V812) angle(V812) abs(V814) angle(V814) abs(V816) angle(V816) abs(V818) angle(V818) abs(V820) angle(V820) abs(V822) angle(V822) abs(V824) angle(V824) abs(V828) angle(V828) abs(V830) angle(V830) abs(V832) angle(V832) abs(V850) angle(V850) abs(V852) angle(V852) abs(V854) angle(V854) abs(VRG10) angle(VRG10) abs(VRG11) angle(VRG11)];
        valord = valord + 1;
    end
end

writematrix(SalvarValoresCorrenteT2F, 'ResultadoValoresCorrenteT2F.csv');
writematrix(SalvarValoresTensaoT2F, 'ResultadoValoresTensaoT2F.csv');
writematrix(SalvarValoresCorrente, 'ResultadoValoresCorrente.csv');
writematrix(SalvarValoresTensao, 'ResultadoValoresTensao.csv');