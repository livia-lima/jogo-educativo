/// @description Fase 2 - Contagem (Yasmin)

// --- Segurança: se rodar a fase sozinha pra testar, cria as globais ---
if (!variable_global_exists("pontuacao"))          global.pontuacao = 0;
if (!variable_global_exists("total_rounds_fase2")) global.total_rounds_fase2 = 3;

// --- Regras (pode ajustar) ---
max_erros = 3;              // erros na fase para ir à tela de falha
tempo_multiplicador = 30;   // mais que isso (segundos) volta pra 1x
multiplicador_max = 3;      // 1x, 2x, 3x

// --- Estado da fase ---
global.rodada_rounds_fase2 = 1;
global.acertos_fase2 = 0;
global.erros_fase2 = 0;
global.tempos_reacao_fase2 = [];   // segundos de cada resposta (pro relatório do Vitor)

multiplicador = 1;
resposta = 0;        // quantas bicicletas tem na tela
contagem = 0;        // quantas o aluno já "contou" passando o mouse
bloqueado = false;   // trava cliques durante o feedback
feedback_texto = "";
feedback_cor = c_white;
inicio_rodada = current_time;

// Área onde as bicicletas aparecem (lado esquerdo)
area_x1 = 60;  area_y1 = 130;
area_x2 = 1080; area_y2 = 680;

// --- Toca um som só se ele existir no projeto ---
tocar_som = function(_nome) {
    var _s = asset_get_index(_nome);
    if (_s != -1 && audio_exists(_s)) audio_play_sound(_s, 1, false);
};

// --- Monta uma rodada nova ---
nova_rodada = function() {
    with (obj_fase2_item)  instance_destroy();
    with (obj_fase2_botao) instance_destroy();

    resposta = irandom_range(1, 5);
    contagem = 0;
    feedback_texto = "";

    // Bicicletas sem ficar uma em cima da outra
    var _pos = [];
    var _dist = 150;
    for (var i = 0; i < resposta; i++) {
        var _x, _y, _ok, _tent = 0;
        do {
            _x = irandom_range(area_x1 + 80, area_x2 - 80);
            _y = irandom_range(area_y1 + 80, area_y2 - 80);
            _ok = true;
            for (var j = 0; j < array_length(_pos); j++) {
                if (point_distance(_x, _y, _pos[j][0], _pos[j][1]) < _dist) { _ok = false; break; }
            }
            _tent++;
        } until (_ok || _tent > 300);
        array_push(_pos, [_x, _y]);
        instance_create_layer(_x, _y, "Instances", obj_fase2_item);
    }

    // 4 botões: o número certo + 3 errados, embaralhados
    var _opcoes = [resposta];
    while (array_length(_opcoes) < 4) {
        var _n = irandom_range(1, 5);
        if (!array_contains(_opcoes, _n)) array_push(_opcoes, _n);
    }
    _opcoes = array_shuffle(_opcoes);
    for (var k = 0; k < 4; k++) {
        var _b = instance_create_layer(1230, 190 + k * 145, "Instances", obj_fase2_botao);
        _b.valor = _opcoes[k];
    }

    inicio_rodada = current_time;
    bloqueado = false;
};

// --- Chamado quando o aluno clica num número ---
verificar = function(_valor) {
    if (bloqueado) return;
    bloqueado = true;

    var _tempo = (current_time - inicio_rodada) / 1000;
    array_push(global.tempos_reacao_fase2, _tempo);
    if (_tempo > tempo_multiplicador) multiplicador = 1;

    var _fps = game_get_speed(gamespeed_fps);

    if (_valor == resposta) {
        global.acertos_fase2++;
        global.pontuacao += 25 * multiplicador;
        multiplicador = min(multiplicador + 1, multiplicador_max);
        feedback_texto = "Muito bem! São " + string(resposta) + "!";
        feedback_cor = c_lime;
        tocar_som("snd_acerto");
        alarm[0] = _fps * 1.5;   // próxima rodada
    } else {
        global.erros_fase2++;
        global.pontuacao = max(0, global.pontuacao - 25);
        multiplicador = 1;
        feedback_texto = "Quase! Vamos contar de novo.";
        feedback_cor = c_orange;
        alarm[1] = _fps * 1.5;   // tenta de novo ou vai pra falha
    }
};

nova_rodada();
