function [Raf, Rbf, Rcf, RaTrif, RbTrif, RcTrif] = calcula_parametros_resistencias(tipoCurto)
    switch tipoCurto
        case 1
            Raf = 1e-5; Rbf = 1e-5; Rcf = 1e-5;
            RaTrif = 1e-5; RbTrif = 1e-5; RcTrif = 1e-5;
        case 2
            Raf = 1e-5; Rbf = 1e-5; Rcf = 1e-5;
            RaTrif = 1e-5; RbTrif = 1e-5; RcTrif = 1e-5;
        case 3
            Raf = 1e-5; Rbf = 1e6; Rcf = 1e-5;
            RaTrif = 1e-5; RbTrif = 1e6; RcTrif = 1e-5;
        case 4
            Raf = 1e6; Rbf = 1e-5; Rcf = 1e-5;
            RaTrif = 1e6; RbTrif = 1e-5; RcTrif = 1e-5;
        case 5
            Raf = 1e-5; Rbf = 1e-5; Rcf = 1e6;
            RaTrif = 1e-5; RbTrif = 1e-5; RcTrif = 1e6;
        otherwise
            error('Tipo de curto inválido');
    end
end
