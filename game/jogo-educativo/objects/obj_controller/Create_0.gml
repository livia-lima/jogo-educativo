/// @description Inicialização do Sistema Global
randomize(); // Garante que os sorteios da Fase 2 sejam sempre aleatórios

global.CONTROLLER = self;

// Variáveis de Jogador e Relatório (Base para o trabalho do Vitor)
global.nome_aluno = "";
global.pontuacao = 0;
global.faseAtual = 0; // indicador de fase. (0 = nenhuma)

global._tempoMult = time_source_create(time_source_game,30,time_source_units_seconds,resetaMult)
// ^ timer para reset de mult.

global.mult = 1; //        ˅
global._time = [0,0,0]; // usado em ScoreScript
global._Erros = 0; //      ˄

global._faseStart1 = [0,0,0] // usados para calcular o tempo gasto em
global._faseStart2 = [0,0,0] // cada fase.

global.acertos_fase1 = 0;
global.erros_fase1 = 0;
global.tempoEntreAcertos_fase1 = [0,0,0,0,0,0];
global.tempoGasto_fase1 = 0;
global.tentativas_fase1 = 0; // incrementar quando tentar a fase 1 novamente

global.acertos_fase2 = 0;
global.erros_fase2 = 0;
global.tempoGasto_fase2 = 0;
global.tempoEntreAcertos_fase2 = [0,0,0,0,0,0];
global.tentativas_fase2 = 0; // incrementar quando tentar a fase 2 novamente

// Controle de Rodadas
global.round_atual_fase1 = 1;
global.total_rounds_fase1 = 3; // Ajuste conforme a duração desejada
global.rodada_rounds_fase2 = 1;
global.total_rounds_fase2 = 3;

//Controle do volume e escala da fonte
global.volume_jogo = 1; // Vai de 0 (mudo) a 1 (máximo)
global.escala_fonte = 1; // Multiplicador para o tamanho do texto

// Banco de Dados dos Elementos (Base para a sua Fase 1 e a Fase 2 da Yasmin)
// O "frame" deve corresponder à subimagem exata no spr_elementos
global.elementos = [
    { frame: 0,  nome: "Bicicleta",           tipo: "sustentavel" },
    { frame: 1,  nome: "Carro Poluente",      tipo: "nao_sustentavel" },
    { frame: 2,  nome: "Torneira Fechada",    tipo: "sustentavel" },
    { frame: 3,  nome: "Torneira Aberta",     tipo: "nao_sustentavel" },
    { frame: 4,  nome: "Energia Solar",       tipo: "sustentavel" },
    { frame: 5,  nome: "Lâmpada Acesa",       tipo: "nao_sustentavel" },
    { frame: 6,  nome: "Lixeira Reciclável",  tipo: "sustentavel" },
    { frame: 7,  nome: "Lixo no Chão",        tipo: "nao_sustentavel" },
    { frame: 8,  nome: "Fruta Fresca",        tipo: "sustentavel" },
    { frame: 9,  nome: "Embalagem Plástica",  tipo: "nao_sustentavel" },
    { frame: 10, nome: "Caderno Reutilizado", tipo: "sustentavel" },
    { frame: 11, nome: "Papel Amassado",      tipo: "nao_sustentavel"}
];