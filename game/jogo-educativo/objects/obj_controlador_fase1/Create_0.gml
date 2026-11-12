
/// obj_controlador_frase1 - CREATE
/// Controla o sorteio, as associacoes e as rodadas.
/// Preparado para integrar pontuacao e cronometro.

// =====================================
// 1. CONFIGURACAO DA FASE
// =====================================

rodada_atual = 1;
total_rodadas = 3;
pares_por_rodada = 5;

acertos_rodada = 0;
rodada_concluida = false;
fase_concluida = false;

ids_acertados = [];
cartoes_rodada = [];

imagens_rodada = [];
palavras_rodada = [];

// =====================================
// 2. CARREGAR FONTE PIXELADA
// =====================================

fonte_palavras = font_add(
    "fonts/PixelifySans.ttf",
    24,
    false,
    false,
    32,
    255
);

if (fonte_palavras == -1) {
    show_debug_message(
        "AVISO: Pixelify Sans nao foi carregada."
    );
} else {
    show_debug_message(
        "Pixelify Sans carregada!"
    );
}

// =====================================
// 3. CATALOGO DOS 15 ITENS
// =====================================

catalogo = [
    {
        id: "arvore",
        nome: "ÁRVORE",
        sprite: spr_item_arvore
    },
    {
        id: "bicicleta",
        nome: "BICICLETA",
        sprite: spr_item_bicicleta
    },
    {
        id: "canudo_metalico",
        nome: "CANUDO METÁLICO",
        sprite: spr_item_canudo_metalico
    },
    {
        id: "canudo_plastico",
        nome: "CANUDO PLÁSTICO",
        sprite: spr_item_canudo_plastico
    },
    {
        id: "carro",
        nome: "CARRO",
        sprite: spr_item_carro
    },
    {
        id: "ecobag",
        nome: "ECOBAG",
        sprite: spr_item_ecobag
    },
    {
        id: "garrafa",
        nome: "GARRAFA",
        sprite: spr_item_garrafa
    },
    {
        id: "garrafa_reutilizavel",
        nome: "GARRAFA REUTILIZÁVEL",
        sprite: spr_item_garrafa_reutilizavel
    },
    {
        id: "lampada_led",
        nome: "LÂMPADA LED",
        sprite: spr_item_lampada_led
    },
    {
        id: "lixeira_reciclavel",
        nome: "LIXEIRA RECICLÁVEL",
        sprite: spr_item_lixeira_reciclavel
    },
    {
        id: "pilha_lixo",
        nome: "PILHA DE LIXO",
        sprite: spr_item_pilha_lixo
    },
    {
        id: "predios",
        nome: "PRÉDIOS",
        sprite: spr_item_predios
    },
    {
        id: "sacola_plastica",
        nome: "SACOLA PLÁSTICA",
        sprite: spr_item_sacola_plastica
    },
    {
        id: "torneira_aberta",
        nome: "TORNEIRA ABERTA",
        sprite: spr_item_torneira_aberta
    },
    {
        id: "torneira_fechada",
        nome: "TORNEIRA FECHADA",
        sprite: spr_item_torneira_fechada
    }
];

// =====================================
// 4. PREPARAR SORTEIO
// =====================================

var _total_necessario =
    total_rodadas * pares_por_rodada;

if (array_length(catalogo) < _total_necessario) {
    show_error(
        "Quantidade insuficiente de itens!",
        true
    );
}

randomise();

itens_partida = array_shuffle(catalogo);

// =====================================
// 5. LIMPAR CARTOES
// =====================================

limpar_cartoes = function() {

    for (var i = 0; i < array_length(cartoes_rodada); i++) {

        var _instancia = cartoes_rodada[i];

        if (instance_exists(_instancia)) {
            with (_instancia) {
                instance_destroy();
            }
        }
    }

    cartoes_rodada = [];
};

// =====================================
// 6. CRIAR CARTOES
// =====================================

criar_cartoes = function() {

    limpar_cartoes();

    if (
        array_length(imagens_rodada) != pares_por_rodada
        || array_length(palavras_rodada) != pares_por_rodada
    ) {
        show_error(
            "Erro: quantidade incorreta de cartoes.",
            true
        );
        return;
    }

    // Posicoes espalhadas das imagens
    var _posicoes_imagens = [
        [0.18, 0.32],
        [0.32, 0.44],
        [0.16, 0.57],
        [0.31, 0.70],
        [0.19, 0.83]
    ];

    var _posicoes_sorteadas =
        array_shuffle(_posicoes_imagens);

    // Posicoes alinhadas das palavras
    var _centro_direito = room_width * 0.745;
    var _primeira_linha = room_height * 0.30;
    var _ultima_linha = room_height * 0.82;

    for (var i = 0; i < pares_por_rodada; i++) {

        // =============================
        // CARTAO DE IMAGEM
        // =============================

        var _x_imagem =
            room_width * _posicoes_sorteadas[i][0];

        var _y_imagem =
            room_height * _posicoes_sorteadas[i][1];

        var _img = instance_create_layer(
            _x_imagem,
            _y_imagem,
            "Instances",
            obj_carta_imagem
        );

        _img.item_id = imagens_rodada[i].id;
        _img.sprite_item = imagens_rodada[i].sprite;

        _img.associada = false;
        _img.controlador = id;

        _img.posicao_inicial_x = _x_imagem;
        _img.posicao_inicial_y = _y_imagem;

        _img.arrastando = false;
        _img.deslocamento_x = 0;
        _img.deslocamento_y = 0;

        _img.erro_frames = 0;
        _img.acerto_frames = 0;

        array_push(cartoes_rodada, _img);

        // =============================
        // CARTAO DE PALAVRA
        // =============================

        var _progresso =
            i / (pares_por_rodada - 1);

        var _y_palavra = lerp(
            _primeira_linha,
            _ultima_linha,
            _progresso
        );

        var _palavra = instance_create_layer(
            _centro_direito,
            _y_palavra,
            "Instances",
            obj_carta_palavra
        );

        _palavra.item_id = palavras_rodada[i].id;
        _palavra.texto = palavras_rodada[i].nome;

        _palavra.fonte_cartao = fonte_palavras;
        _palavra.controlador = id;

        _palavra.posicao_inicial_x = _centro_direito;
        _palavra.posicao_inicial_y = _y_palavra;

        _palavra.arrastando = false;
        _palavra.deslocamento_x = 0;
        _palavra.deslocamento_y = 0;

        _palavra.associada = false;
        _palavra.erro_frames = 0;
        _palavra.acerto_frames = 0;

        array_push(cartoes_rodada, _palavra);
    }

    show_debug_message(
        "Cartoes criados com sucesso!"
    );
};

// =====================================
// 7. INICIAR RODADA
// =====================================

iniciar_rodada = function() {

    acertos_rodada = 0;
    rodada_concluida = false;

    ids_acertados = [];
    imagens_rodada = [];
    palavras_rodada = [];

    var _inicio =
        (rodada_atual - 1) * pares_por_rodada;

    var _selecionados = [];

    for (var i = 0; i < pares_por_rodada; i++) {

        array_push(
            _selecionados,
            itens_partida[_inicio + i]
        );
    }

    imagens_rodada = array_shuffle(_selecionados);
    palavras_rodada = array_shuffle(_selecionados);

    show_debug_message(
        "=== RODADA " + string(rodada_atual) + " ==="
    );

    criar_cartoes();
};

// =====================================
// 8. VALIDAR ASSOCIACAO
// =====================================

validar_associacao = function(
    _id_imagem,
    _id_palavra
) {

    if (rodada_concluida || fase_concluida) {
        return false;
    }

    if (_id_imagem != _id_palavra) {
        return false;
    }

    // Verificar se o item pertence a rodada
    var _encontrado = false;

    for (var i = 0; i < array_length(imagens_rodada); i++) {

        if (imagens_rodada[i].id == _id_imagem) {
            _encontrado = true;
            break;
        }
    }

    if (!_encontrado) {
        return false;
    }

    // Impedir contagem duplicada
    for (var i = 0; i < array_length(ids_acertados); i++) {

        if (ids_acertados[i] == _id_imagem) {
            return false;
        }
    }

    // =================================
    // ASSOCIACAO CORRETA
    // =================================

    array_push(ids_acertados, _id_imagem);

    acertos_rodada++;

    // =================================
    // TODO: INTEGRACAO COM PONTUACAO
    // =================================

    // Quando a branch de pontuacao
    // for integrada, descomentar:
    //
    // Pontuou();
    //
    // Essa chamada fica aqui para
    // funcionar nos dois sentidos de
    // arraste e evitar pontos duplicados.

    show_debug_message(
        "ACERTO: "
        + string(acertos_rodada)
        + "/"
        + string(pares_por_rodada)
    );

    // =================================
    // VERIFICAR FIM DA RODADA
    // =================================

    if (acertos_rodada >= pares_por_rodada) {

        rodada_concluida = true;

        show_debug_message(
            "Rodada "
            + string(rodada_atual)
            + " concluida!"
        );
    }

    return true;
};

// =====================================
// 9. AVANCAR RODADA
// =====================================

avancar_rodada = function() {

    if (!rodada_concluida) {
        return false;
    }

    if (rodada_atual < total_rodadas) {

        rodada_atual++;
        iniciar_rodada();

        return true;

    } else {

        fase_concluida = true;

        show_debug_message(
            "=== FASE 1 CONCLUIDA ==="
        );

        return false;
    }
};

// =====================================
// 10. INTEGRACAO COM CRONOMETRO
// =====================================

// TODO: Quando o sistema compartilhado
// estiver integrado:
//
// 1. Configurar a Fase 1 para 15 acertos.
// 2. Preparar o registro dos 15 tempos.
// 3. Iniciar o cronometro:
//
// FaseTimeStart(1);

// =====================================
// 11. INICIAR PRIMEIRA RODADA
// =====================================

iniciar_rodada();
