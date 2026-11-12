/// @description Inicialização do Sistema Global
randomize(); // Garante que os sorteios da Fase 2 sejam sempre aleatórios

global.CONTROLLER = self;

// Variáveis de Jogador e Relatório: zeradas em NovaPartida (ScoreScript),
// chamada aqui e de novo sempre que um nome é confirmado.
NovaPartida("");
global.alvoDeLeitura = "";

global._tempoMult = time_source_create(time_source_game,30,time_source_units_seconds,resetaMult)
// ^ timer para reset de mult.

global.errosParaFimDeFase = 3 // erros numa tentativa para ir à tela de falha (as duas fases)

if (!file_exists("ranking.txt")) gerarRanking() // gera um ranking placeholder
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