import numpy as np
import pandas as pd
import math
import streamlit as st
import plotly.graph_objects as go

st.set_page_config(layout="wide")

CurvaInrushTrafos = {
    'a': 1.7687,
    'b': 0.2220,
    'c': -0.1478,
    'min': 0.01,
    'max': 200,
}
CurvaDanoTransformadores = {
	'15kVA': {
		'a': 0.5346,
		'b': 0.8391,
		'c': 0.5266,
        'min': 1.9815,
        'max': 980.2960,
        'pot': 15,
	},
	'30kVA': {
		'a': 0.5346,
		'b': 0.8391,
		'c': 1.0532,
        'min': 1.9815,
        'max': 980.2960,
        'pot': 30,
	},
	'45kVA': {
		'a': 0.5346,
		'b': 0.8391,
		'c': 1.5798,
        'min': 1.9815,
        'max': 980.2960,
        'pot': 45,
	},
	'75kVA': {
		'a': 0.5346,
		'b': 0.8391,
		'c': 2.6330,
        'min': 1.9815,
        'max': 980.2960,
        'pot': 75,
	},
	'112k5VA': {
		'a': 0.5346,
		'b': 0.8391,
		'c': 3.9495,
        'min': 1.9815,
        'max': 980.2960,
        'pot': 125.5,
	},
	'150kVA': {
		'a': 0.5346,
		'b': 0.8391,
		'c': 5.2660,
        'min': 1.9815,
        'max': 980.2960,
        'pot': 150,
	},
	'225kVA': {
		'a': 0.5507,
		'b': 0.8585,
		'c': 8.5095,
        'min': 2.5572,
        'max': 980.2960,
        'pot': 225,
	},
	'300kVA': {
		'a': 0.5507,
		'b': 0.8585,
		'c': 11.3460,
        'min': 2.5572,
        'max': 980.2960,
        'pot': 300,
	},
	'400kVA': {
		'a': 0.5507,
		'b': 0.8585,
		'c': 15.1280,
        'min': 2.5572,
        'max': 980.2960,
        'pot': 400,
	},
	'500kVA': {
		'a': 0.5507,
		'b': 0.8585,
		'c': 18.9100,
        'min': 2.5572,
        'max': 980.2960,
        'pot': 500,
	},
	'600kVA': {
		'a': 0.5507,
		'b': 0.8585,
		'c': 22.6920,
        'min': 2.5572,
        'max': 980.2960,
        'pot': 600,
	},
}

elosMin = {
    '1H': {
        'a': 11.5834,
        'b': -7.7159,
        'c': 2.2435,
        'd': -0.4141,
        'e': 0.0293,
        'IoIn': 1,
    },
    '2H': {
        'a': 15.3612,
        'b': -11.3048,
        'c': 3.7855,
        'd': -0.6767,
        'e': 0.0442,
        'IoIn': 2,
    },
    '3H': {
        'a': 16.6469,
        'b': -10.3608,
        'c': 2.8987,
        'd': -0.4844,
        'e': 0.0315,
        'IoIn': 3,
    },
    '5H': {
        'a': 33.5364,
        'b': -24.1389,
        'c': 7.0071,
        'd': -1.0167,
        'e': 0.0569,
        'IoIn': 5,
    },
    '8H': {
        'a': 137.5572,
        'b': -119.0117,
        'c': 38.2794,
        'd': -5.4440,
        'e': 0.2846,
        'IoIn': 8,
    },
    '6K': {
        'a': 181.2568,
        'b': -167.5711,
        'c': 57.6673,
        'd': -8.7672,
        'e': 0.4916,
        'IoIn': 6,
    },
    '8K': {
        'a': 201.6778,
        'b': -175.2376,
        'c': 56.8760,
        'd': -8.1725,
        'e': 0.4340,
        'IoIn': 8,
    },
    '10K': {
        'a': 251.8801,
        'b': -206.6378,
        'c': 63.3069,
        'd': -8.5810,
        'e': 0.4304,
        'IoIn': 10,
    },
    '12K': {
        'a': 294.2461,
        'b': -229.0340,
        'c': 66.6693,
        'd': -8.5945,
        'e': 0.4107,
        'IoIn': 12,
    },
    '15K': {
        'a': 346.4070,
        'b': -257.6697,
        'c': 71.6644,
        'd': -8.8225,
        'e': 0.4027,
        'IoIn': 15,
    },
    '20K': {
        'a': 382.4620,
        'b': -271.3985,
        'c': 72.1161,
        'd': -8.4924,
        'e': 0.3714,
        'IoIn': 20,
    },
    '25K': {
        'a': 469.9755,
        'b': -321.2512,
        'c': 82.1749,
        'd': -9.3092,
        'e': 0.3918,
        'IoIn': 25,
    },
    '30K': {
        'a': 516.7220,
        'b': -337.6034,
        'c': 82.5876,
        'd': -8.9522,
        'e': 0.3608,
        'IoIn': 30,
    },
    '40K': {
        'a': 672.1360,
        'b': -424.7867,
        'c': 100.3706,
        'd': -10.4950,
        'e': 0.4080,
        'IoIn': 40,
    },
    '50K': {
        'a': 691.3953,
        'b': -419.2300,
        'c': 95.1730,
        'd': -9.5735,
        'e': 0.3584,
        'IoIn': 50,
    },
    '65K': {
        'a': 841.8993,
        'b': -492.8148,
        'c': 107.9499,
        'd': -10.4731,
        'e': 0.3783,
        'IoIn': 65,
    },
    '80K': {
        'a': 881.1649,
        'b': -499.4578,
        'c': 106.0005,
        'd': -9.9685,
        'e': 0.3492,
        'IoIn': 80,
    },
    '100K': {
        'a': 1020.0325,
        'b': -554.4466,
        'c': 112.8674,
        'd': -10.1845,
        'e': 0.3425,
        'IoIn': 100,
    }
}


elosMax = {
    '1H': {
        'a': 11.6256,
        'b': -6.4698,
        'c': 1.3804,
        'd': -0.2041,
        'e': 0.0133,
        'IoIn': 1,
    },
    '2H': {
        'a': 14.6714,
        'b': -9.1330,
        'c': 2.5653,
        'd': -0.4144,
        'e': 0.0256,
        'IoIn': 2,
    },
    '3H': {
        'a': 16.3187,
        'b': -8.3597,
        'c': 1.7248,
        'd': -0.2310,
        'e': 0.0136,
        'IoIn': 3,
    },
    '5H': {
        'a': 30.5611,
        'b': -18.3646,
        'c': 4.2355,
        'd': -0.4978,
        'e': 0.0237,
        'IoIn': 5,
    },
    '8H': {
        'a': 138.7659,
        'b': -111.3549,
        'c': 33.2333,
        'd': -4.4002,
        'e': 0.2156,
        'IoIn': 8,
    },
    '6K': {
        'a': 192.9941,
        'b': -169.0384,
        'c': 55.2403,
        'd': -7.9961,
        'e': 0.4286,
        'IoIn': 6,
    },
    '8K': {
        'a': 232.6677,
        'b': -193.0379,
        'c': 59.8091,
        'd': -8.2061,
        'e': 0.4173,
        'IoIn': 8,
    },
    '10K': {
        'a': 287.7564,
        'b': -225.9500,
        'c': 66.2420,
        'd': -8.5945,
        'e': 0.4135,
        'IoIn': 10,
    },
    '12K': {
        'a': 334.4284,
        'b': -250.5401,
        'c': 70.1765,
        'd': -8.7063,
        'e': 0.4011,
        'IoIn': 12,
    },
    '15K': {
        'a': 371.4044,
        'b': -265.3945,
        'c': 70.9172,
        'd': -8.3938,
        'e': 0.3691,
        'IoIn': 15,
    },
    '20K': {
        'a': 438.8777,
        'b': -299.2860,
        'c': 76.3801,
        'd': -8.6400,
        'e': 0.3636,
        'IoIn': 20,
    },
    '25K': {
        'a': 491.9018,
        'b': -322.7019,
        'c': 79.2818,
        'd': -8.6364,
        'e': 0.3502,
        'IoIn': 25,
    },
    '30K': {
        'a': 549.9245,
        'b': -345.5217,
        'c': 81.3149,
        'd': -8.4872,
        'e': 0.3299,
        'IoIn': 30,
    },
    '40K': {
        'a': 652.1884,
        'b': -396.8930,
        'c': 90.4090,
        'd': -9.1277,
        'e': 0.3432,
        'IoIn': 40,
    },
    '50K': {
        'a': 712.2121,
        'b': -417.4489,
        'c': 91.6205,
        'd': -8.9153,
        'e': 0.3233,
        'IoIn': 50,
    },
    '65K': {
        'a': 813.6765,
        'b': -461.0754,
        'c': 97.8160,
        'd': -9.1979,
        'e': 0.3223,
        'IoIn': 65,
    },
    '80K': {
        'a': 970.6168,
        'b': -532.6923,
        'c': 109.4302,
        'd': -9.9635,
        'e': 0.3382,
        'IoIn': 80,
    },
    '100K': {
        'a': 1065.7914,
        'b': -563.6017,
        'c': 111.5874,
        'd': -9.7938,
        'e': 0.3206,
        'IoIn': 100,
    }
}

TabelaTrafos = {
    '15kVA': {
        'elo': '1H',
    },
    '30kVA': {
        'elo': '2H',
    },
    '45kVA': {
        'elo': '2H',
    },
    '75kVA': {
        'elo': '3H',
    },
    '112k5VA': {
        'elo': '5H',
    },
    '150kVA': {
        'elo': '6K',
    },
    '225kVA': {
        'elo': '10K',
    },
    '300kVA': {
        'elo': '15K',
    },
    '400kVA': {
        'elo': '20K',
    },
    '500kVA': {
        'elo': '20K',
    },
    '600kVA': {
        'elo': '25K',
    },
}
Transformador = st.selectbox(
    'Valor do Transformador em kVA:',
    (15, 30, 45, 75, 112.5, 150, 225, 300, 400, 500, 600))

Tensao = st.selectbox(
    'Valor de Tensão em V:',
    (13800, 23100, 34500))

TMS = st.number_input( label="TMS", min_value=0.01, step=0.015, max_value=10.000, value=0.5, format="%f")

st.write('Valor do Transformador em kVA:', Transformador)
st.write('Valor de Tensão em V:', Tensao)
st.write('Valor de TMS:', TMS)

def EquacaoInrush(x, A, B, C, PotenciaTrafo, Tensao):
    Corrente = (PotenciaTrafo*1000)/(Tensao/math.sqrt(3))
    return A * (Corrente/(x**B + C))

def EquacaoReal(x, A, B, C, PotenciaTrafo):
    return B * ((PotenciaTrafo / x**A) + C)

def EquacaoElos(x, a, b, c, d, e):
    return a + (b * x) + (c * x**2) + (d * x**3) + (e * x**4)

def RetornaValorTempoCorrente(Modelo, Icc, elos):
  x = math.log(Icc)
  valor = EquacaoElos(x, elos[str(Modelo)]['a'], elos[str(Modelo)]['b'], elos[str(Modelo)]['c'], elos[str(Modelo)]['d'], elos[str(Modelo)]['e'])
  return math.exp(valor)

def curva_inversa(TMS, I, n=0.02):
  t = TMS * (0.14 / (I**n - 1))
  t[I <= 1] = np.inf
  return t

def curva_muito_inversa(TMS, I, n=1):
  t = TMS * (13.5 / (I**n - 1))
  t[I <= 1] = np.inf
  return t

def curva_extremamente_inversa(TMS, I, n=2):
  t = TMS * (80 / (I**n - 1))
  t[I <= 1] = np.inf
  return t

def FazPrimeiraImagem(ValorTransformador, Tensao):
    if ValorTransformador == 15 :
        NomeTrafo = '15kVA'
        ValorElo = TabelaTrafos['15kVA']['elo']
    elif ValorTransformador == 30 :
        NomeTrafo = '30kVA'
        ValorElo = TabelaTrafos['30kVA']['elo']
    elif ValorTransformador == 45:
        NomeTrafo = '45kVA'
        ValorElo = TabelaTrafos['45kVA']['elo']
    elif ValorTransformador == 75:
        NomeTrafo = '75kVA'
        ValorElo = TabelaTrafos['75kVA']['elo']
    elif ValorTransformador == 112.5:
        NomeTrafo = '112k5VA'
        ValorElo = TabelaTrafos['112k5VA']['elo']
    elif ValorTransformador == 150:
        NomeTrafo = '150kVA'
        ValorElo = TabelaTrafos['150kVA']['elo']
    elif ValorTransformador == 225:
        NomeTrafo = '225kVA'
        ValorElo = TabelaTrafos['225kVA']['elo']
    elif ValorTransformador == 300:
        NomeTrafo = '300kVA'
        ValorElo = TabelaTrafos['300kVA']['elo']
    elif ValorTransformador == 400:
        NomeTrafo = '400kVA'
        ValorElo = TabelaTrafos['400kVA']['elo']
    elif ValorTransformador == 500:
        NomeTrafo = '500kVA'
        ValorElo = TabelaTrafos['500kVA']['elo']
    elif ValorTransformador == 600:
        NomeTrafo = '600kVA'
        ValorElo = TabelaTrafos['600kVA']['elo']
    else:
        st.error('Valores não encontrados')
        return

    CorrenteDanoTransformadores = np.arange(CurvaDanoTransformadores[NomeTrafo]['min'], CurvaDanoTransformadores[NomeTrafo]['max'], 0.01)
    CorrenteInrush = np.arange(CurvaInrushTrafos['min'], elosMin[ValorElo]['IoIn']*3, 0.01)
    CorrenteElo = np.arange(elosMin[ValorElo]['IoIn']*2, elosMin[ValorElo]['IoIn']*30, 0.01)
    CorrenteElo = np.log(CorrenteElo)
    ResultadoDanoTrafo = EquacaoReal(CorrenteDanoTransformadores, CurvaDanoTransformadores[NomeTrafo]['a'], CurvaDanoTransformadores[NomeTrafo]['b'], CurvaDanoTransformadores[NomeTrafo]['c'], ValorTransformador)
    ResultadoInrushTrafo = EquacaoInrush(CorrenteInrush, CurvaInrushTrafos['a'], CurvaInrushTrafos['b'], CurvaInrushTrafos['c'], ValorTransformador, Tensao)
    ResultadoEloFusivelMax = EquacaoElos(CorrenteElo, elosMax[ValorElo]['a'], elosMax[ValorElo]['b'], elosMax[ValorElo]['c'], elosMax[ValorElo]['d'], elosMax[ValorElo]['e'])
    ResultadoEloFusivelMin = EquacaoElos(CorrenteElo, elosMin[ValorElo]['a'], elosMin[ValorElo]['b'], elosMin[ValorElo]['c'], elosMin[ValorElo]['d'], elosMin[ValorElo]['e'])
    ResultadoEloFusivelMax = np.exp(ResultadoEloFusivelMax)
    ResultadoEloFusivelMin = np.exp(ResultadoEloFusivelMin)
    CorrenteElo = np.exp(CorrenteElo)
    fig = go.Figure()
    fig.add_trace(go.Scatter(x=CorrenteDanoTransformadores, y=ResultadoDanoTrafo, mode = 'lines', name = 'Curva de Dano'))
    fig.add_trace(go.Scatter(x=CorrenteInrush, y=ResultadoInrushTrafo, mode = 'lines', name = 'Curva Inrush'))
    fig.add_trace(go.Scatter(x=CorrenteElo, y=ResultadoEloFusivelMax, mode = 'lines', name = 'Curva Elo Fusivel {} - Max'.format(ValorElo)))
    fig.add_trace(go.Scatter(x=CorrenteElo, y=ResultadoEloFusivelMin, mode = 'lines', name = 'Curva Elo Fusivel {} - Min'.format(ValorElo)))
    fig.update_xaxes(type="log")
    fig.update_yaxes(type="log")
    fig.update_layout(title='Comparação entre Curva de Dano do Transformador, Curva de Inrush e Curva do Elo Fusivel'.format(NomeTrafo),
                   xaxis_title='Corrente (A)',
                   yaxis_title='Tempo (s)')
    st.plotly_chart(fig)

def FazSegundaImagem(ValorTransformador, Tensao):
    if ValorTransformador == 15:
        NomeTrafo = '15kVA'
        ValorElo = TabelaTrafos['15kVA']['elo']
    elif ValorTransformador == 30:
        NomeTrafo = '30kVA'
        ValorElo = TabelaTrafos['30kVA']['elo']
    elif ValorTransformador == 45:
        NomeTrafo = '45kVA'
        ValorElo = TabelaTrafos['45kVA']['elo']
    elif ValorTransformador == 75:
        NomeTrafo = '75kVA'
        ValorElo = TabelaTrafos['75kVA']['elo']
    elif ValorTransformador == 112.5:
        NomeTrafo = '112k5VA'
        ValorElo = TabelaTrafos['112k5VA']['elo']
    elif ValorTransformador == 150:
        NomeTrafo = '150kVA'
        ValorElo = TabelaTrafos['150kVA']['elo']
    elif ValorTransformador == 225:
        NomeTrafo = '225kVA'
        ValorElo = TabelaTrafos['225kVA']['elo']
    elif ValorTransformador == 300:
        NomeTrafo = '300kVA'
        ValorElo = TabelaTrafos['300kVA']['elo']
    elif ValorTransformador == 400:
        NomeTrafo = '400kVA'
        ValorElo = TabelaTrafos['400kVA']['elo']
    elif ValorTransformador == 500:
        NomeTrafo = '500kVA'
        ValorElo = TabelaTrafos['500kVA']['elo']
    elif ValorTransformador == 600:
        NomeTrafo = '600kVA'
        ValorElo = TabelaTrafos['600kVA']['elo']
    else:
        st.error('Valores não encontrados')
        return

    CorrenteDanoTransformadores = np.arange(CurvaDanoTransformadores[NomeTrafo]['min'], CurvaDanoTransformadores[NomeTrafo]['max'], 0.01)
    CorrenteInrush = np.arange(CurvaInrushTrafos['min'], elosMin[ValorElo]['IoIn']*3, 0.01)
    CorrenteCurtoCircuito = np.arange(elosMin[ValorElo]['IoIn'], CurvaDanoTransformadores[NomeTrafo]['max'], 0.01)
    ResultadoDanoTrafo = EquacaoReal(CorrenteDanoTransformadores, CurvaDanoTransformadores[NomeTrafo]['a'], CurvaDanoTransformadores[NomeTrafo]['b'], CurvaDanoTransformadores[NomeTrafo]['c'], ValorTransformador)
    ResultadoInrushTrafo = EquacaoInrush(CorrenteInrush, CurvaInrushTrafos['a'], CurvaInrushTrafos['b'], CurvaInrushTrafos['c'], ValorTransformador, Tensao)
    ResultadoCurvaIEC1 = curva_inversa(TMS, CorrenteCurtoCircuito)
    ResultadoCurvaIEC2 = curva_muito_inversa(TMS, CorrenteCurtoCircuito)
    ResultadoCurvaIEC3 = curva_extremamente_inversa(TMS, CorrenteCurtoCircuito)

    fig = go.Figure()
    fig.add_trace(go.Scatter(x=CorrenteDanoTransformadores, y=ResultadoDanoTrafo, mode = 'lines', name = 'Curva de Dano'))
    fig.add_trace(go.Scatter(x=CorrenteInrush, y=ResultadoInrushTrafo, mode = 'lines', name = 'Curva Inrush'))
    fig.add_trace(go.Scatter(x=CorrenteCurtoCircuito, y=ResultadoCurvaIEC1, mode = 'lines', name = 'Curva IEC Inversa'))
    fig.add_trace(go.Scatter(x=CorrenteCurtoCircuito, y=ResultadoCurvaIEC2, mode = 'lines', name = 'Curva IEC Muito Inversa'))
    fig.add_trace(go.Scatter(x=CorrenteCurtoCircuito, y=ResultadoCurvaIEC3, mode = 'lines', name = 'Curva IEC Curva Extremamente Inversa'))
    fig.update_xaxes(type="log")
    fig.update_yaxes(type="log")
    fig.update_layout(title='Comparação entre Curva de Dano do Transformador de {}, Curva de Inrush e Curva IEC'.format(NomeTrafo),
                   xaxis_title='Corrente (A)',
                   yaxis_title='Tempo (s)')
    st.plotly_chart(fig)

def FazTerceiraImagem(ValorTransformador, Tensao):
    if ValorTransformador == 15:
        NomeTrafo = '15kVA'
        ValorElo = TabelaTrafos['15kVA']['elo']
    elif ValorTransformador == 30:
        NomeTrafo = '30kVA'
        ValorElo = TabelaTrafos['30kVA']['elo']
    elif ValorTransformador == 45:
        NomeTrafo = '45kVA'
        ValorElo = TabelaTrafos['45kVA']['elo']
    elif ValorTransformador == 75:
        NomeTrafo = '75kVA'
        ValorElo = TabelaTrafos['75kVA']['elo']
    elif ValorTransformador == 112.5:
        NomeTrafo = '112k5VA'
        ValorElo = TabelaTrafos['112k5VA']['elo']
    elif ValorTransformador == 150:
        NomeTrafo = '150kVA'
        ValorElo = TabelaTrafos['150kVA']['elo']
    elif ValorTransformador == 225:
        NomeTrafo = '225kVA'
        ValorElo = TabelaTrafos['225kVA']['elo']
    elif ValorTransformador == 300:
        NomeTrafo = '300kVA'
        ValorElo = TabelaTrafos['300kVA']['elo']
    elif ValorTransformador == 400:
        NomeTrafo = '400kVA'
        ValorElo = TabelaTrafos['400kVA']['elo']
    elif ValorTransformador == 500:
        NomeTrafo = '500kVA'
        ValorElo = TabelaTrafos['500kVA']['elo']
    elif ValorTransformador == 600:
        NomeTrafo = '600kVA'
        ValorElo = TabelaTrafos['600kVA']['elo']
    else:
        st.error('Valores não encontrados')
        return

    CorrenteDanoTransformadores = np.arange(CurvaDanoTransformadores[NomeTrafo]['min'], CurvaDanoTransformadores[NomeTrafo]['max'], 0.01)
    CorrenteInrush = np.arange(CurvaInrushTrafos['min'], elosMin[ValorElo]['IoIn']*3, 0.01)
    CorrenteCurtoCircuito = np.arange(elosMin[ValorElo]['IoIn'], CurvaDanoTransformadores[NomeTrafo]['max'], 0.01)

    ResultadoDanoTrafo = EquacaoReal(CorrenteDanoTransformadores, CurvaDanoTransformadores[NomeTrafo]['a'], CurvaDanoTransformadores[NomeTrafo]['b'], CurvaDanoTransformadores[NomeTrafo]['c'], ValorTransformador)
    ResultadoInrushTrafo = EquacaoInrush(CorrenteInrush, CurvaInrushTrafos['a'], CurvaInrushTrafos['b'], CurvaInrushTrafos['c'], ValorTransformador, Tensao)
    ResultadoCurvaIEC = EquacaoReal(CorrenteDanoTransformadores, CurvaDanoTransformadores[NomeTrafo]['a'], CurvaDanoTransformadores[NomeTrafo]['b'], (CurvaDanoTransformadores[NomeTrafo]['c']-(CurvaDanoTransformadores[NomeTrafo]['c']*0.5)), ValorTransformador)

    fig = go.Figure()
    fig.add_trace(go.Scatter(x=CorrenteDanoTransformadores, y=ResultadoDanoTrafo, mode='lines', name='Curva de Dano'))
    fig.add_trace(go.Scatter(x=CorrenteInrush, y=ResultadoInrushTrafo, mode='lines', name='Curva Inrush'))
    fig.add_trace(go.Scatter(x=CorrenteCurtoCircuito, y=ResultadoCurvaIEC, mode='lines', name='Curva Baseada no Dano'))
    fig.update_xaxes(type="log")
    fig.update_yaxes(type="log")
    fig.update_layout(
        title='Comparação entre Curva de Dano do Transformador de {}, Curva de Inrush e Curva Baseada no Dano'.format(NomeTrafo),
        xaxis_title='Corrente (A)',
        yaxis_title='Tempo (s)'
    )

    st.plotly_chart(fig)

if st.button("Gerar Gráfico"):
    FazPrimeiraImagem(Transformador, int(Tensao))
    FazSegundaImagem(Transformador, int(Tensao))
    FazTerceiraImagem(Transformador, int(Tensao))